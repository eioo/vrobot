module vrobot
 
import math
import time

#flag -lgdi32
#include "windows.h"

struct Color {
pub:
  r int
  g int
  b int
}

struct Point {
pub:
  x int
  y int
}

fn send_mouse_event(x int) {
  C.mouse_event(x, 0, 0, 0, 0)
}

fn mouse_down(button string) {
  match button {
    'left' => send_mouse_event(C.MOUSEEVENTF_LEFTDOWN)
    'right' => send_mouse_event(C.MOUSEEVENTF_RIGHTDOWN)
    'middle' => send_mouse_event(C.MOUSEEVENTF_MIDDLEDOWN)
    else => panic('Invalid mouse button')
  }
}

fn mouse_up(button string) {
  match button {
    'left' => send_mouse_event(C.MOUSEEVENTF_LEFTUP)
    'right' => send_mouse_event(C.MOUSEEVENTF_RIGHTUP)
    'middle' => send_mouse_event(C.MOUSEEVENTF_MIDDLEUP)
    else => panic('Invalid mouse button')
  }
}

pub fn click(button string) {
  mouse_down(button)
  mouse_up(button)
}

pub fn double_click(button string) {
  click(button)
  click(button)
}

pub fn drag(x, y int) {
  mouse_down('left')
  move_mouse(x, y)
  mouse_up('left')
}

pub fn drag_rel(offset_x, offset_y int) {
  start_pos := get_mouse_pos()
  dest_x := start_pos.x + offset_x
  dest_y := start_pos.y + offset_y

  mouse_down('left')
  move_mouse(dest_x, dest_y)
  mouse_up('left')
}

pub fn move_mouse(x, y int) {
  C.SetCursorPos(x, y)
}

pub fn move_mouse_rel(offset_x, offset_y int) {
  start_pos := get_mouse_pos()
  dest_x := start_pos.x + offset_x
  dest_y := start_pos.y + offset_y
  move_mouse(dest_x, dest_y)
}

pub fn move_mouse_smooth(x, y, duration_ms int, tween string) {
  start_pos := get_mouse_pos()
  dist_x := f64(x) - start_pos.x
  dist_y := f64(y) - start_pos.y
  dist := math.sqrt(math.pow(x - start_pos.x, 2) + math.pow(y - start_pos.y, 2))
  steps := int(math.max(50.0, duration_ms / 5))
  dt := int(f64(duration_ms) / f64(steps))
  
  mut factor := 0.0
  mut i := 0
  
  for i < steps {
    n := normalize(i, 0, steps)

    // TODO there must be better way to do this
    match tween {
      'linear' => factor = n
      'ease_in_quad' => factor = ease_in_quad(n)
      'ease_out_quad' => factor = ease_out_quad(n)
      'ease_in_out_quad' => factor = ease_in_out_quad(n)
      'ease_in_cubic' => factor = ease_in_cubic(n)
      'ease_out_cubic' => factor = ease_out_cubic(n)
      'ease_in_out_cubic' => factor = ease_in_out_cubic(n)
      'ease_in_quart' => factor = ease_in_quart(n)
      'ease_out_quart' => factor = ease_out_quart(n)
      'ease_in_out_quart' => factor = ease_in_out_quart(n)
      'ease_in_quint' => factor = ease_in_quint(n)
      'ease_out_quint' => factor = ease_out_quint(n)
      'ease_in_out_quint' => factor = ease_in_out_quint(n)
      'ease_in_sine' => factor = ease_in_sine(n)
      'ease_out_sine' => factor = ease_out_sine(n)
      'ease_in_out_sine' => factor = ease_in_out_sine(n)
      'ease_in_expo' => factor = ease_in_expo(n)
      'ease_out_expo' => factor = ease_out_expo(n)
      'ease_in_out_expo' => factor = ease_in_out_expo(n)
      'ease_in_circ' => factor = ease_in_circ(n)
      'ease_out_circ' => factor = ease_out_circ(n)
      'ease_in_out_circ' => factor = ease_in_out_circ(n)
      'ease_in_elastic' => factor = ease_in_elastic(n)
      'ease_out_elastic' => factor = ease_out_elastic(n)
      'ease_in_out_elastic' => factor = ease_in_out_elastic(n)
      'ease_in_back' => factor = ease_in_back(n)
      'ease_out_back' => factor = ease_out_back(n)
      'ease_in_out_back' => factor = ease_in_out_back(n)
      'ease_in_bounce' => factor = ease_in_bounce(n)
      'ease_out_bounce' => factor = ease_out_bounce(n)
      'ease_in_out_bounce' => factor = ease_in_out_bounce(n)
      else => panic('Tween not found')
    }

    current_x := int(f64(start_pos.x) + factor * dist_x)
    current_y := int(f64(start_pos.y) + factor * dist_y)

    move_mouse(current_x, current_y)
    time.sleep_ms(dt)
    i++
  }
}

pub fn move_mouse_smooth_rel(offset_x, offset_y, duration_ms int, tween string) {
  start_pos := get_mouse_pos()
  dest_x := start_pos.x + offset_x
  dest_y := start_pos.y + offset_y
  move_mouse_smooth(dest_x, dest_y, duration_ms, tween)
}

pub fn get_mouse_pos() Point {
  p := Point{}
  cursor := C.GetCursorPos(&p)

  if !cursor {
    panic('No cursor found')
  }

  return p
}

pub fn get_pixel_color(x, y int) Color {
  hdc := C.GetDC(C.NULL)

  if !hdc {
    panic('Could not get device context handle')
  }

  mut pixel := i32(0)
  pixel = C.GetPixel(hdc, x, y)
  C.ReleaseDC(C.GetDesktopWindow(), hdc)

  color := Color{
    r: C.GetRValue(pixel),
    g: C.GetGValue(pixel),
    b: C.GetBValue(pixel),
  }

  return color
}

/*
struct C.INPUT

pub fn type_stuff() {
  // Keyboard
  input := &C.INPUT{}
  vkey := C.VK_RETURN
  input.type = 1 // C.INPUT_KEYBOARD
  input.ki.wScan = C.MapVirtualKey(vkey, C.MAPVK_VK_TO_VSC)
  input.ki.time = 0 
  input.ki.dwExtraInfo = 0
  input.ki.wVk = vkey
  input.ki.dwFlags = 0
  C.SendInput(1, &input, sizeof(C.INPUT))

  input.ki.dwFlags = C.KEYEVENTF_KEYUP
  C.SendInput(1, &input, sizeof(C.INPUT))
}
*/