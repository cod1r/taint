open Taint

let () = at_exit (fun _ -> Ncurses._endwin ())
let _window = Ncurses._initscr ()
let () = Ncurses._cbreak ()
let () = Ncurses._noecho ()
let () = Ncurses._clear ()
let () = Ncurses._refresh ()
let () = Ncurses._keypad ()
let () = Ncurses._nodelay ()
let () = Ncurses._notimeout ()

let _write_to_debug_file s =
  Out_channel.with_open_gen [ Open_append; Open_creat ]
    (0o200 lor 0o400) "debug.txt" (fun oc -> Out_channel.output_string oc s)

let rec loop () =
  Ncurses._getch ();
  let m_event = Ncurses._get_mouse () in
  begin match m_event with
  | Some m_event ->
      Ncurses._move m_event.y m_event.x;
      Ncurses._doupdate ()
  | None -> ()
  end;
  loop ()

let () = loop ()
