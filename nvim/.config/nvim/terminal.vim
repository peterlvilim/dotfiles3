" This is a script for designating a terminal buffer in nvim where cargo
" commands will be run. You can run the normal cargo command in that buffer
" and then in jump between problems it finds in your source buffers while not
" having to navigate to the terminal buffer. A typical workflow involves
" having the terminal buffer open in one split and your source buffers in
" several other splits. So you can see all your cargo output and jump between
" problems using hot keys in the other splits without having to visit the
" terminal split.
"
" CONFIG
let g:rust_root="~/server/desktop/rust/"

" Mark terminal split that cargo will be run in
" Need to do this before doing anything else otherwise you'll get errors when
" using other hotkeys.
"
" This allows us to call hot keys while in other buffers and not have to leave
" those buffers but have this script parse the terminal buffer where cargo
" errors are
nnoremap <leader>T :call MarkTerminal()<CR>

" Move up or down one problem in terminal split
nnoremap <leader>k :call SearchUp()<CR>
nnoremap <leader>j :call SearchDown()<CR>

" Move up or down one problem in termainl split AND jump to buffer source position 
" Opens a new buffer if 
nnoremap <leader>K :call SearchUpJump()<CR>
nnoremap <leader>J :call SearchDownJump()<CR>

" Jump to designated terminal split, clear its output, and run the last
" command (typical cargo check workflow loop), then jump back to original
" split
nnoremap <leader>y :call LastCommand()<CR>


function! ClearTerminal()
	set scrollback=0
	call feedkeys("\i")
	call feedkeys("clear\<CR>")
	set scrollback=10000
endfunction

function! SearchProblem(flags)
	let current_line = line('.')
	let error_line=search("error.*\\n *-->", a:flags)
	let warning_line=search("warning.*\\n *-->", a:flags)
	let error_distance = abs(current_line - error_line)
	let warning_distance = abs(current_line - warning_line)
	if warning_distance <= error_distance
		return warning_line
	else
		return error_line
	endif
endfunction

function FileNameOffset(file_line)
	let line_text = getline(a:file_line)
	return match(line_text, "-->")+3+2
endfunction

function! SearchBlank(flags)
	let blank_line=search("^$", a:flags)
	return blank_line
endfunction

function! SearchFile(flags)
	let file_line=search("-->", a:flags)
	return file_line
endfunction

function! GetProblemLocation(file_line)
	let line_text = getline(a:file_line)
	let file_line_col = matchlist(line_text, '^.*--> \(.*\)')[1]
	let file_line_col = matchlist(file_line_col, '\(.*\):\(.*\):\(.*\)')
	let filename = file_line_col[1]
	let line = file_line_col[2]
	let col = file_line_col[3]
	let winid = bufwinid(filename)
	return [filename, winid, line, col]
endfunction

function! JumpProblem(filename, winid, line, column)
	echo a:filename
	if a:winid == -1
		execute "edit ".g:rust_root.a:filename
		call cursor(a:line, a:column)
	else
		call win_gotoid(a:winid)
		call cursor(a:line, a:column)
	endif
endfunction

function! MarkTerminal()
	let g:terminal_winid = win_getid()
endfunction

function! JumpTerminal()
	let winid = win_getid()
	let line = line('.')
	let column = col('.')
	call win_gotoid(g:terminal_winid)
	return [winid, line, column]
endfunction

function! ResetView(winid, line, column)
	if a:winid != g:terminal_winid
		call win_gotoid(a:winid)
		call cursor(a:line, a:column)
	endif
endfunction

function Highlight(problem_line, file_line, blank_line)
	highlight Background ctermbg=0
	for i in range(a:problem_line, a:blank_line)
		call matchaddpos("Background", [i])
	endfor
	call matchaddpos("Error", [a:problem_line])
	call matchaddpos("Todo", [[a:file_line, FileNameOffset(a:file_line), 1000]])
endfunction

function! SearchDown()
	let [old_winid, old_line, old_column] = JumpTerminal()
	call clearmatches()
	let problem_line = SearchProblem("zn")
	call cursor(problem_line, 0)
	let file_line = SearchFile("zn")
	let blank_line = SearchBlank("zn")
	let problem_location = GetProblemLocation(file_line)
	call Highlight(problem_line, file_line, blank_line)
	call ResetView(old_winid, old_line, old_column)
	return problem_location
endfunction

function! SearchUp()
	let [old_winid, old_line, old_column] = JumpTerminal()
	call clearmatches()
	let problem_line = SearchProblem("zbn")
	call cursor(problem_line, 0)
	let file_line = SearchFile("zn")
	let blank_line = SearchBlank("zn")
	let problem_location = GetProblemLocation(file_line)
	call Highlight(problem_line, file_line, blank_line)
	call ResetView(old_winid, old_line, old_column)
	return problem_location
endfunction

function! SearchUpJump()
	let [filename, winid, line, column] = SearchUp()
	call JumpProblem(filename, winid, line, column)
endfunction

function! SearchDownJump()
	let [filename, winid, line, column] = SearchDown()
	call JumpProblem(filename, winid, line, column)
endfunction

function! Jump()
	let [old_winid, old_line, old_column] = JumpTerminal()
	let [filename, winid, line, column] = GetProblemLocation()
	call ResetView(old_winid, old_line, old_column)
	call JumpProblem(filename, winid, line, column)
endfunction

function! LastCommand()
	let [old_winid, old_line, old_column] = JumpTerminal()
	call ClearTerminal()
	" Skip the clear command run command before that
	call feedkeys("\<Up>\<Up>\<CR>")
endfunction
