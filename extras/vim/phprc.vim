
" Automatically strip white-space from the end of lines for all PHP files on save
:%s/\s\+$//e

" run file with PHP CLI (CTRL-M)
noremap <C-M> :w!<CR>:!$HOME/bin/php %<CR>

" PHP parser check (CTRL-L)
noremap <C-L> :!$HOME/bin/php -l %<CR>

let php_sql_query=1     " Highlight sql in php strings
let php_htmlInSTrings=1 " Highlight HTML in php strings
let php_noShortTags=1   " Disable PHP Short Tags
