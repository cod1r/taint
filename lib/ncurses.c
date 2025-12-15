#include <curses.h>
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>
#include <string.h>

CAMLprim value _initscr() {
  CAMLparam0();
  CAMLlocal1(window);
  window = caml_alloc(1, Abstract_tag);
  WINDOW* window_ptr = initscr();
  if (window_ptr == NULL) caml_failwith("initscr failed");
  *((WINDOW***)Data_abstract_val(window)) = malloc(sizeof(WINDOW*));
  memcpy(*((WINDOW***)Data_abstract_val(window)), &window_ptr, sizeof(WINDOW*));
  CAMLreturn(window);
}
CAMLprim value _cbreak() {
  CAMLparam0();
  if (cbreak() == ERR) caml_failwith("cbreak failed");
  CAMLreturn(Val_unit);
}
CAMLprim value _noecho() {
  CAMLparam0();
  if (noecho() == ERR) caml_failwith("noecho failed");
  CAMLreturn(Val_unit);
}
CAMLprim value _clear() {
  CAMLparam0();
  if (clear() == ERR) caml_failwith("erase failed");
  CAMLreturn(Val_unit);
}
CAMLprim value _refresh() {
  CAMLparam0();
  if (refresh() == ERR) caml_failwith("refresh failed");
  CAMLreturn(Val_unit);
}
CAMLprim value _endwin() {
  CAMLparam0();
  if (endwin() == ERR) caml_failwith("endwin failed");
  CAMLreturn(Val_unit);
}
CAMLprim value _move(value x, value y) {
  CAMLparam2(x, y);
  int _x = Int_val(x);
  int _y = Int_val(y);
  if (move(_y, _x) == ERR) caml_failwith("move failed");
  CAMLreturn(Val_unit);
}
CAMLprim value _get_mouse() {
  CAMLparam0();
  CAMLlocal1(m_event);
  m_event = caml_alloc(3, 0);
  MEVENT m;
  mousemask(BUTTON1_PRESSED | BUTTON1_RELEASED, NULL);
  if (!has_mouse()) caml_failwith("mouse driver not initialized");
  if (getmouse(&m) == ERR) CAMLreturn(Val_none);
  Store_field(m_event, 0, Val_int(m.x));
  Store_field(m_event, 1, Val_int(m.y));
  Store_field(m_event, 2, Val_long(m.bstate));
  CAMLreturn(caml_alloc_some(m_event));
}
