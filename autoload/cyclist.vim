let s:DEBUG = v:false

let s:current_listchar_opt = 'default'
let s:listchar_key_order = []
let s:listchar_opts = {}

" let crazy_option_set = cyclist#add_listchar_option_set(...)
"
" call cyclist#activate_listchars(crazy_option_set)
function cyclist#add_listchar_option_set(opts_name, opts_dict, ...) abort
  let use_defaults = get(a:, 1, v:false)

  let to_add = deepcopy(a:opts_dict)
  " Populate any missing keys with the default value from the first config.
  if use_defaults
    call extend(to_add, s:listchar_opts.default, "keep")
  endif

  " If we've never inserted this before, insert it now!
  if index(s:listchar_key_order, a:opts_name) < 0
    call add(s:listchar_key_order, a:opts_name)
  endif

  let s:listchar_opts[a:opts_name] = to_add
endfunction

function cyclist#activate_listchars(opt_name) abort
  " Just make sure list is set, in case people don't do it themselves.
  set list

  let listchar_mapped = join(map(
        \ items(filter(s:listchar_opts[a:opt_name], {k, v -> v != ''})),
        \ { opt_name, key -> printf("%s:%s", key[0], key[1])}
        \ ), ',')
  if s:DEBUG
    echo "Listchar set: " . a:opt_name
    echo 'listchar_mapped:'
    echo listchar_mapped
  endif

  let s:current_listchar_opt = a:opt_name
  let &listchars = listchar_mapped
endfunction

function s:cyclist_move_listchar(change) abort
  let current_option_index = index(
        \ s:listchar_key_order,
        \ s:current_listchar_opt)

  call assert_true(
        \  current_option_index >= 0,
        \ "Must have index in listchar_key_order")

  let new_option_index = float2nr(
        \ fmod(
          \ current_option_index + a:change,
          \ len(s:listchar_key_order)))

  call cyclist#activate_listchars(s:listchar_key_order[new_option_index])
endfunction

function cyclist#next_listchar() abort
  call s:cyclist_move_listchar(1)
endfunction

function cyclist#prev_listchar() abort
  call s:cyclist_move_listchar(-1)
endfunction

function cyclist#set_eol(opt_name, chars) abort
  let s:listchar_opts[a:opt_name].eol = a:chars
  call cyclist#activate_listchars(a:opt_name)
endfunction

function cyclist#set_tab(opt_name, chars) abort
  let s:listchar_opts[a:opt_name].tab = a:chars
  call cyclist#activate_listchars(a:opt_name)
endfunction

function cyclist#set_space(opt_name, chars) abort
  let s:listchar_opts[a:opt_name].space = a:chars
  call cyclist#activate_listchars(a:opt_name)
endfunction

function cyclist#set_trail(opt_name, chars) abort
  let s:listchar_opts[a:opt_name].trail = a:chars
  call cyclist#activate_listchars(a:opt_name)
endfunction

function cyclist#set_extends(opt_name, chars) abort
  let s:listchar_opts[a:opt_name].extends = a:chars
  call cyclist#activate_listchars(a:opt_name)
endfunction

function cyclist#set_precedes(opt_name, chars) abort
  let s:listchar_opts[a:opt_name].precedes = a:chars
  call cyclist#activate_listchars(a:opt_name)
endfunction

function cyclist#set_conceal(opt_name, chars) abort
  let s:listchar_opts[a:opt_name].conceal = a:chars
  call cyclist#activate_listchars(a:opt_name)
endfunction

function cyclist#set_nbsp(opt_name, chars) abort
  let s:listchar_opts[a:opt_name].nbsp = a:chars
  call cyclist#activate_listchars(a:opt_name)
endfunction

call cyclist#add_listchar_option_set("default", {
        \ 'eol': '↲',
        \ 'tab': '» ',
        \ 'space': '',
        \ 'trail': '𝁢',
        \ 'extends': '…',
        \ 'precedes': '…',    
        \ 'conceal': '┊',
        \ 'nbsp': '☠',
        \ })
