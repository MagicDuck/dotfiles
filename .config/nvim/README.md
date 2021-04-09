# Keys to remember

 - command history is:  `q:`
 - sneak is bound to `s`
 - quickscope is f, t, F, T  &  , and ;  to jump to next occurrence
 - closing other windows except current is `wincmd o`

# Workflows

## Search for file
CTRL-P

## Search in files
1. <leader>f
2. enter term,

## Search in files with particular type
You can pass any rg opts to :Search
1. :Search -tscss
2. enter term, above will only search inside scss files

## Search in files and open in quickfix
1. <leader>f
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


