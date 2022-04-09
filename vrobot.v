module vrobot
 
#flag -lgdi32
#include "windows.h"

[typedef]
type COLORREF = int

fn C.mouse_event(int, int, int, int, int)
fn C.SetCursorPos(int, int)
fn C.GetCursorPos(point &Point) bool
fn C.GetDC(int) C.HDC
fn C.GetPixel(C.HDC, int, int) COLORREF
fn C.GetDesktopWindow() C.HWDC
fn C.ReleaseDC(C.HWDC, C.HDC) int
fn C.GetSystemMetrics(int) int


pub fn get_r_value(color COLORREF) int {

	return color & 0xFF

}

pub fn get_g_value(color COLORREF) int {

	return (color & 0xFF00) >> 8 

}

pub fn get_b_value(color COLORREF) int {

	return color >> 16

}