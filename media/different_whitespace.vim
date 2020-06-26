" Example whitepsace, so you can check out your listchars
"
" trailing space
"     
" nbsb vv
" -> This is a NONBREAKING SPACE  
" garbage tabs
" 		
"

call cyclist#add_listchar_option_set('limited', {
      \ 'eol': '↲','tab': '» ','trail': '·','extends': '<','precedes': '>','conceal': '┊','nbsp': '␣',})

call cyclist#add_listchar_option_set('busy', {
      \ 'eol': '↲','tab': '»·','space': '␣','trail': '-','extends': '☛','precedes': '☚',    'conceal': '┊','nbsp': '☠',})
