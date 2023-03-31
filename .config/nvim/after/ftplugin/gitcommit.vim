" do not wrap lines
setlocal textwidth=0

" goto 1
" startinsert!

" if !exists("g:jiraIdAdded") && getline(1) == ''
"    let g:jiraIdAdded = "added"
"    :r! echo "$( git branch | grep \* | cut -d ' ' -f2 | grep -o "\w\+-\d\+" ) "
"    :goto 1
"    :join
"    :startinsert!
" endif

