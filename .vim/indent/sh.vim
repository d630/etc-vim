" Vim indent file
" Language:            Shell Script

" D630
" Fork of: https://github.com/chrisbra/vim-sh-indent


" TODO:
" - rewrite case handling
" - " and '
" - pipe, continuation, termination

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetShIndent()
setlocal indentkeys+=0=then,0=do,0=else,0=elif,0=fi,0=esac,0=done,),},],0=;;
setlocal indentkeys+=0=;&,0=&&,0=\|\|
setlocal indentkeys+=0=fin,0=fil,0=fip,0=fir,0=fix
setlocal indentkeys-=:,0#
setlocal nosmartindent

let b:undo_indent = 'setlocal indentexpr< indentkeys< smartindent<'

if exists("*GetShIndent")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

let s:sh_indent_defaults = {
      \ 'case-labels': function('shiftwidth'),
      \ 'case-statements': function('shiftwidth'),
      \ 'continuation-line': function('shiftwidth'),
      \ 'default': function('shiftwidth'),
      \ 'pipe-line': function('shiftwidth'),
      \ 'case-breaks': 0 }

function! s:indent_value(option)
  let Value = exists('b:sh_indent_options')
        \ && has_key(b:sh_indent_options, a:option) ?
        \ b:sh_indent_options[a:option] :
        \ s:sh_indent_defaults[a:option]
  if type(Value) == type(function('type'))
    return Value()
  endif
  return Value
endfunction

function! GetShIndent()
  let lnum = prevnonblank(v:lnum - 1)
  if lnum == 0
    return 0
  endif

  let pnum = prevnonblank(lnum - 1)
  let ind = indent(lnum)
  let line = getline(lnum)

  if s:is_compound_cmd(line)
    if !s:is_compound_cmd_end(line)
      let ind += s:indent_value('default')
    endif
  elseif s:is_case_label(line, pnum)
    if !s:is_case_ended(line)
      let ind += s:indent_value('case-statements')
    endif
  elseif s:is_func_def(line)
    if !s:is_compound_cmd_end(line)
      let ind = ind
      " let ind += s:indent_value('default')
    endif
  elseif s:is_substitution(line)
    if !s:is_substitution_end(line)
      let ind += s:indent_value('default')
    endif
  elseif s:is_terminator_line(line)
    let pine = getline(pnum)
    if pnum == 0
          \ || (s:is_terminator_line(pine) && indent(pnum) <= ind)
          \ || s:is_compound_cmd(pine)
          \ || s:is_func_def(pine)
      let ind = ind
    else
      let ind = indent(s:find_terminated_lnum(pnum, lnum))
    endif
  elseif s:is_pipe_line(line)
    let rind = indent(s:find_terminated_lnum(lnum, lnum))
    if rind == ind
      let ind += s:indent_value('pipe-line')
    elseif rind == 0
      let ind = s:indent_value('pipe-line')
    else
      let pind = indent(s:find_piped_lnum(pnum, lnum))
      if s:is_continuation_line(getline(pnum))
            \ || line =~ '^\s*\%(}\|)\|\]\|"\|''\)'
        let ind -= s:indent_value('continuation-line')
      " elseif pind == rind
      "   let ind = pind + s:indent_value('pipe-line')
      else
        let ind = ind
      endif
    endif
  elseif s:is_continuation_line(line)
    let rind = indent(s:find_terminated_lnum(lnum, lnum))
    if rind == ind
      let ind += s:indent_value('continuation-line')
    else
      let ind = indent(s:find_continued_lnum(pnum, lnum)) +
            \ s:indent_value('continuation-line')
    endif
    if s:is_sublist_line(getline(v:lnum))
      let ind = rind
    endif
  endif

  let pine = line
  let line = getline(v:lnum)

  if s:is_compound_cmd_attention(line)
    return ind - s:indent_value('default')
  elseif line =~ '\%(^\|\s*\)\zs\<\esac\>\s*' && s:is_case_empty(getline(v:lnum - 1))
    return ind - s:indent_value('default')
  elseif line =~ '\%(^\|\s*\)\zs\<\esac\>\s*'
    let ind -= (s:is_case_label(pine, lnum) && s:is_case_ended(pine) ?
          \ 0 : s:indent_value('case-statements')) +
          \ s:indent_value('case-labels')
    if s:is_case_break(pine)
      return ind + s:indent_value('case-breaks')
    else
      return ind
    endif
  elseif s:is_case_label(line, lnum)
    if s:is_case(pine)
      return indent(lnum) + s:indent_value('case-labels')
    else
      return ind - (s:is_case_label(pine, lnum) && s:is_case_ended(pine) ?
            \ 0 : s:indent_value('case-statements')) -
            \ s:indent_value('case-breaks')
    endif
  elseif s:is_case_break(line)
    return ind - s:indent_value('case-breaks')
  elseif s:is_here_doc(line)
    return 0
  " statements, executed within a here document. Keep the current indent
  elseif match(map(synstack(v:lnum, 1), 'synIDattr(v:val, "name")'), '\c\mheredoc') > -1
    return indent(v:lnum)
  endif

  return ind
endfunction

function! s:is_substitution(line)
  return a:line =~ '\%(^\|\s*\)\zs\%([<>]\|\$\)\%((\|{\|\[\)'
endfunction

function! s:is_substitution_end(line)
  return a:line =~ '\%()\|}\|\]\)\s*\%(;*\|&*\|;;&\=\|;&\)\=\s*\%(#.*\)\=$'
endfunction

function! s:is_compound_cmd(line)
  return a:line =~ '\%(^\|\s*\)\zs\<\%(if\|then\|else\|elif\|for\|select\|until\|while\|do\|case\)\>'
        \ || a:line =~ '\%(^\|\s*\)\zs\$\@<!\%((\|{\|\[\)'
endfunction

function! s:is_compound_cmd_end(line)
  return a:line =~ '\<\%(fi\|done\|esac\)\>\s*\%(;*\|&*\|;;&\=\|;&\)\=\s*\%(#.*\)\=$'
        \ || a:line =~ '\%()\|}\|\]\)\s*\%(;*\|&*\|;;&\=\|;&\)\=\s*\%(#.*\)\=$'
endfunction

function! s:is_compound_cmd_attention(line)
  return a:line =~ '\%(^\|\s*\)\zs\<\%(do\|elif\|then\|else\|fi\|done\)\>'
        \ || a:line =~ '\%(^\|\s*\)\zs\$\@<!\%([^(])\|}\|\]\)'
endfunction

function! s:is_func_def(line)
  return a:line =~ '\<[^[:cntrl:]|&;()<>$`\\#\*[:space:]""']\+\>\s*()'
  " return a:line =~ '^\s*\<\k\+\>\s*()\s*'
        \ || a:line =~ '^\s*function\s*\w\S\+\s*\%(()\)\?'
endfunction

function! s:is_continuation_line(line)
  return a:line =~ '\%(\%(^\|[^\\]\)\\\)\s*\%(#.*\)\=$'
endfunction

function! s:is_pipe_line(line)
  return a:line =~ '\%(|\)\s*\%(#.*\)\=$'
endfunction

function! s:is_sublist_line(line)
  return a:line =~ '\%(^\|\s*\)\zs\%(&&\|||\)\s*\%(#.*\)\=$'
endfunction

function! s:is_terminator_line(line)
  return a:line =~ '\%(;\|&\)\s*\%(#.*\)\=$'
endfunction

function! s:find_continued_lnum(lnum, num)
  let i = a:lnum
  let ind = indent(a:num)
  while i > 1
    let line = getline(i - 1)
    if !empty(line) && !s:is_continuation_line(line) && indent(i - 1) < ind
      return i
    else
      let i -= 1
    endif
  endwhile
  return i
endfunction

function! s:find_piped_lnum(lnum, num)
  let i = a:lnum
  let ind = indent(a:num)
  while i > 1
    let line = getline(i - 1)
    if !empty(line) && !s:is_pipe_line(line) && indent(i - 1) < ind
      return i
    else
      let i -= 1
    endif
  endwhile
  return i
endfunction

function! s:find_terminated_lnum(lnum, num)
  let i = a:lnum
  let ind = indent(a:num)
  while i > 1
    let line = getline(i - 1)
    if !empty(line) && !s:is_terminator_line(line) && indent(i - 1) < ind
      if line =~ '^\s*\%(if\|then\|do\|case\|else\|elif\|while\|until\|for\|select\)\>'
            \ || line =~ '^\s*\<\k\+\>\s*()\s*\%({\|\[\|(\)'
            \ || line =~ '^\s*\%({\|\[\|(\)'
            \ || line =~ '\%({\|\[\|(\)$'
            \ || line =~ '^\s*function\s*\w\S\+\s*\%(()\)\?\s*\%({\|\[\|(\)'
        return i
      else
        return i - 1
      endif
    else
      let i -= 1
    endif
  endwhile
  return i
endfunction

function! s:is_case_label(line, pnum)
  if a:line !~ '^\s*(\=.*)'
    return 0
  endif

  if a:pnum > 0
    let pine = getline(a:pnum)
    if !(s:is_case(pine) || s:is_case_ended(pine))
      return 0
    endif
  endif

  let suffix = substitute(a:line, '^\s*(\=', "", "")
  let nesting = 0
  let i = 0
  let n = strlen(suffix)
  while i < n
    let c = suffix[i]
    let i += 1
    if c == '\\'
      let i += 1
    elseif c == '('
      let nesting += 1
    elseif c == ')'
      if nesting == 0
        return 1
      endif
      let nesting -= 1
    endif
  endwhile
  return 0
endfunction

function! s:is_case(line)
  return a:line =~ '^\s*case\>'
endfunction

function! s:is_case_break(line)
  return a:line =~ '^\s*;[;&]'
endfunction

function! s:is_here_doc(line)
  if a:line =~ '^\w\+$'
    let here_pat = '<<-\?'. s:escape(a:line). '\$'
    return search(here_pat, 'bnW') > 0
  endif
  return 0
endfunction

function! s:is_case_ended(line)
  return s:is_case_break(a:line) || a:line =~ ';[;&]\s*\%(#.*\)\=$'
endfunction

function! s:is_case_empty(line)
  if a:line =~ '^\s*$' || a:line =~ '^\s*#'
    return s:is_case_empty(getline(v:lnum - 1))
  else
    return a:line =~ '^\s*case\>'
  endif
endfunction

function! s:escape(pattern)
  return '\V'. escape(a:pattern, '\\')
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2 ts=8 et:
