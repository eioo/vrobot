module main
 
import math
import time

#include "windows.h"

struct Point {
  x int
  y int
}

pub fn click(button string) {
  match button {
    'left' => {
      C.mouse_event(C.MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
      C.mouse_event(C.MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)
    }
    'right' => {
      C.mouse_event(C.MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0)
      C.mouse_event(C.MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0)
    }
    'middle' => {
      C.mouse_event(C.MOUSEEVENTF_MIDDLEDOWN, 0, 0, 0, 0)
      C.mouse_event(C.MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0)
    }
  }
}

pub fn double_click(button string) {
  click(button)
  click(button)
}

pub fn move_mouse(x, y int) {
  C.SetCursorPos(x, y)
}

pub fn move_mouse_rel(offset_x, offset_y, duration_ms int) {
  start_pos := get_mouse_pos()
  dest_x := start_pos.x + offset_x
  dest_y := start_pos.y + offset_y

  if duration_ms == 0 {
    move_mouse(dest_x, dest_y)
  } else {
    move_mouse_smooth(dest_x, dest_y, duration_ms)
  }
}

pub fn move_mouse_smooth(dest_x, dest_y, duration_ms int) {
  steps := 500
  start_pos := get_mouse_pos()

  dx := (f32(dest_x) - start_pos.x) / steps
  dy := (f32(dest_y) - start_pos.y) / steps
  dt := int(f32(duration_ms) / f32(steps))

  mut i := 0
  
  for i < steps {
    x := int(f32(start_pos.x) + dx * i)
    y := int(f32(start_pos.y) + dy * i)

    move_mouse(x, y)
    time.sleep_ms(dt)
    i++
  }
}

pub fn get_mouse_pos() Point {
  p := Point{}
  cursor := C.GetCursorPos(&p)

  if !cursor {
    panic('No cursor found')
  }

  return p
}

fn main() {
  // Test code
  move_mouse_rel(100, 100, 500)
  double_click('left')
}