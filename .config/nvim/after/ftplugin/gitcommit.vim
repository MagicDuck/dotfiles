" do not wrap lines
setlocal textwidth=0

if getline(1) == ""
    :r! echo "$( git branch | grep \* | cut -d ' ' -f2 | grep -o "\w\+-\d\+" ) "
    :goto 1
    :delete
    :startinsert!
endif

