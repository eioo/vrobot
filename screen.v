module vrobot

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