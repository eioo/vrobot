module vrobot

pub fn pixel_color(x int, y int) Color {
  hdc := C.GetDC(C.NULL)

  if hdc == C.NULL {
    panic('Could not get device context handle')
  }

  mut pixel := i32(0)
  pixel = C.GetPixel(hdc, x, y)
  C.ReleaseDC(C.GetDesktopWindow(), hdc)

  color := Color{
    r: get_r_value(pixel),
    g: get_g_value(pixel),
    b: get_b_value(pixel)
  }

  return color
}

pub fn screen_size() Size {
  width := int(C.GetSystemMetrics(C.SM_CXSCREEN))
  height := int(C.GetSystemMetrics(C.SM_CYSCREEN))

  return Size{
    width: width,
    height: height
  }
}

/*
pub fn screenshot(x, y, width, height int, filename string) {
  hdc := C.CreateCompatibleDC(0)

  // make a bmp in memory to store the capture in
  hbmp := C.CreateCompatibleBitmap(C.GetDC(0), width, height)

  // join em up
  C.SelectObject(hdc, hbmp)

  // copy from the screen to my bitmap
  C.BitBlt(hdc, 0, 0, width, height, C.GetDC(0), x, y, C.SRCCOPY)

  // save my bitmap
  ret := C.SaveBMPFile(filename, hbmp, hdc, width, height)

  // free the bitmap memory
  C.DeleteObject(hbmp)
}
*/