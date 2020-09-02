# cyclist.vim

cycle + listchars = cyclist.vim

For general information, see `:help listchars`

![simple_example](./media/examples.png)

```
Colorscheme: https://github.com/tjdevries/gruvbuddy.nvim
Console    : kitty
Font       : JetBrains Mono
OS         : Ubuntu
Developed  : On my stream at https://twitch.tv/teej_dv
```

## Cycling

![cycling](./media/cycling.svg)

## Usage

```vim
" Add a new named configuration
call cyclist#add_listchar_option_set('limited', {
        \ 'eol': '↲',
        \ 'tab': '» ',
        \ 'trail': '·',
        \ 'extends': '<',
        \ 'precedes': '>',    
        \ 'conceal': '┊',
        \ 'nbsp': '␣',
        \ })

" Cycle to the next configuration
nmap <leader>cn <Plug>CyclistNext
nmap <leader>cp <Plug>CyclistPrev

" Set a specific configuration
call cyclist#activate_listchars('limited')

" Reset to default configuration
call cyclist#activate_listchars('default')

" Override just one value in a configuration
"   Each of the `cyclist#set_*` is based on the names in `:help listchars`

" TRAIL U+2591
call cyclist#set_trail('default', '░')

" PRECEDES & EXTENDS
call cyclist#set_precedes('default', '☚')
call cyclist#set_extends('default', '☛')
```


## Interesting Uses

```vim
" You can change it on autocmds, using saved configurations.
augroup ChangeListChars
  au!
  au FileType C :call cyclist#activate_listchars('c_listchars')<CR>
augroup END
```

## Example configurations that I use

```vim
call cyclist#add_listchar_option_set('limited', {
        \ 'eol': '↲',
        \ 'tab': '» ',
        \ 'trail': '·',
        \ 'extends': '<',
        \ 'precedes': '>',    
        \ 'conceal': '┊',
        \ 'nbsp': '␣',
        \ })

call cyclist#add_listchar_option_set('busy', {
        \ 'eol': '↲',
        \ 'tab': '»·',
        \ 'space': '␣',
        \ 'trail': '-',
        \ 'extends': '☛',
        \ 'precedes': '☚',    
        \ 'conceal': '┊',
        \ 'nbsp': '☠',
        \ })

```
