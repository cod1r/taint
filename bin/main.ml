open Taint

let () = at_exit (fun _ -> Ncurses._endwin ())
let _window = Ncurses._initscr ()
let () = Ncurses._cbreak ()
let () = Ncurses._noecho ()
let () = Ncurses._refresh ()

let rec loop () =
  let m_event = Ncurses._get_mouse () in
  begin match m_event with
  | Some m_event ->
      Ncurses._move m_event.y m_event.x;
      Ncurses._refresh ()
  | None -> ()
  end;
  loop ()

let () = loop ()
