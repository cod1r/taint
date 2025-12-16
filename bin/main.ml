open Taint

let _window = Ncurses._initscr ()
let () = Ncurses._raw ()
let () = Ncurses._noecho ()
let () = Ncurses._clear ()
let () = Ncurses._keypad ()
let () = Ncurses._nodelay ()
let () = Ncurses._notimeout ()

let _write_to_debug_file s =
  Out_channel.with_open_gen [ Open_append; Open_creat ]
    (0o200 lor 0o400) "debug.txt" (fun oc -> Out_channel.output_string oc s)

type taint_state = {
  holding_button1 : bool;
  key : int option;
  cursor_pos : int * int;
  last_drawn_coord : int * int;
}

let rec loop state =
  let key = Ncurses._getch () in
  let m_event = Ncurses._get_mouse () in
  let state =
    match m_event with
    | Some m_event -> begin
        let button1_released =
          Ncurses.has_button_state Button1Released m_event.bstate
        in
        let button1_pressed =
          (not button1_released)
          && (state.holding_button1
             || Ncurses.has_button_state Button1Pressed m_event.bstate)
        in
        {
          state with
          holding_button1 = button1_pressed;
          cursor_pos = (m_event.y, m_event.x);
        }
      end
    | None -> state
  in
  let y, x = state.cursor_pos in
  Ncurses._move y x;
  let state =
    {
      state with
      key =
        (match key with
        | Some key ->
            if key = 3 then (
              Ncurses._shutdown ();
              exit 0);
            Some key
        | None -> state.key);
    }
  in
  let state =
    match state.key with
    | Some key when state.holding_button1 && (y, x) <> state.last_drawn_coord ->
        Ncurses._printw key;
        { state with last_drawn_coord = (y, x) }
    | _ -> state
  in
  Ncurses._doupdate ();
  loop state

let () =
  loop
    {
      holding_button1 = false;
      key = None;
      cursor_pos = (0, 0);
      last_drawn_coord = (-1, -1);
    }
