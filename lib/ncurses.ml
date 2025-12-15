type window
type m_event = { x : int; y : int; bstate : int }

external _initscr : unit -> window = "_initscr" "_initscr"
external _cbreak : unit -> unit = "_cbreak" "_cbreak"
external _noecho : unit -> unit = "_noecho" "_noecho"
external _clear : unit -> unit = "_clear" "_clear"
external _refresh : unit -> unit = "_refresh" "_refresh"
external _endwin : unit -> unit = "_endwin" "_endwin"
external _move : int -> int -> unit = "_move" "_move"
external _get_mouse : unit -> m_event option = "_get_mouse" "_get_mouse"
