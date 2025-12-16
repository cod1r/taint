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
external _getch : unit -> int option = "_getch" "_getch"
external _keypad : unit -> unit = "_keypad" "_keypad"
external _intrflush : unit -> unit = "_intrflush" "_intrflush"
external _nodelay : unit -> unit = "_nodelay" "_nodelay"
external _notimeout : unit -> unit = "_notimeout" "_notimeout"
external _doupdate : unit -> unit = "_doupdate" "_doupdate"
external _printw : int -> unit = "_printw" "_printw"

type button_states = Button1Pressed | Button1Released

external has_button_state : button_states -> int -> bool
  = "has_button_state" "has_button_state"
