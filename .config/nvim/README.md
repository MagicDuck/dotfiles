# Workflows

## Search for file
CTRL-P

## Search in files and open in quickfix
1. <leader>F
2. enter term,
3. select some (TAB) or all (C-a)
4. C-q (send to quickfix)

## Search in dir
1. open coc-explorer (<leader>e)
2. move to directory you need to search in
3. press F

## Replace in dir
1. open coc-explorer (<leader>e)
2. move to directory you need to replace stuff in
3. open terminal (<leader>tt)
4. execute something like the following to preview the replace:
  ```script
  fd -e js -e jsx | sad "useS.*?[(]" "useGeorge{"
  ```
5. if you are happy, with the changes, either:
  - in sad, select some (TAB) or all (C-a), then press ENTER to apply
  - exit sad, then execute same command prefixing with `--commit`


