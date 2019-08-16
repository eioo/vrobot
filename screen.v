module vrobot

pub fn pixel_color(x, y int) Color {
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