/*
Thanks "pytweening" for these functions!
(https://github.com/asweigart/pytweening)
*/
module vrobot

import math

fn check_valid_range(n f64) {
  if n < 0 || n > 1 {
    panic('Not valid range. Should be between 0.0 - 1.0') 
  }
}

pub fn ease_in_quad(n f64) f64 {
  check_valid_range(n)
  return math.pow(n, 2)
}

pub fn ease_out_quad(n f64) f64 {
  check_valid_range(n)
  return -n * (n - 2)
}

pub fn ease_in_out_quad(n f64) f64 {
  check_valid_range(n)

  if n < 0.5 {
    return 2.0 * math.pow(n, 2)
  } else {
    b := n * 2.0 - 1.0
    return -0.5 * (b * (b - 2.0) - 1.0)
  }
}

pub fn ease_in_cubic(n f64) f64 {
  check_valid_range(n)
  return math.pow(n, 3)
}

pub fn ease_out_cubic(n f64) f64 {
  check_valid_range(n)
  return math.pow((n - 1), 3) + 1
}

pub fn ease_in_out_cubic(n f64) f64 {
  check_valid_range(n)
  mut b := 2.0 * n

  if b < 1 {
      return 0.5 * math.pow(b, 3)
  } else {
      b = b - 2
      return 0.5 * (math.pow(b, 3) + 2)
  }
}

pub fn ease_in_quart(n f64) f64 {
  check_valid_range(n)
  return math.pow(n, 4)
}

pub fn ease_out_quart(n f64) f64 {
  check_valid_range(n)
  return -(math.pow((n - 1), 4) - 1)
}

pub fn ease_in_out_quart(n f64) f64 {
  check_valid_range(n)
  mut b :=  n * 2

  if b < 1 {
    return 0.5 * math.pow(b, 4)
  } else {
    b -= 2
    return -0.5 * (math.pow(b, 4) - 2)
  }
}

pub fn ease_in_quint(n f64) f64 {
  check_valid_range(n)
  return math.pow(n, 5)
}

pub fn ease_out_quint(n f64) f64 {
  check_valid_range(n)
  return math.pow((n - 1), 5) + 1
}

pub fn ease_in_out_quint(n f64) f64 {
  check_valid_range(n)
  mut b := 2.0 * n

  if n < 1 {
      return 0.5 * math.pow(n, 5)
  } else {
      b = n - 2
      return 0.5 * (math.pow(n, 5) + 2)
  }
}

pub fn ease_in_sine(n f64) f64 {
  check_valid_range(n)
  return -1.0 * math.cos(n * math.Pi / 2.0) + 1.0
}


pub fn ease_out_sine(n f64) f64 {
  check_valid_range(n)
  return math.sin(n * math.Pi / 2)
}

pub fn ease_in_out_sine(n f64) f64 {
  check_valid_range(n)
  return -0.5 * (math.cos(math.Pi * n) - 1)
}

pub fn ease_in_expo(n f64) f64 {
  check_valid_range(n)

  if n == 0 {
    return 0
  } else {
    return math.pow(2.0, (10.0 * (n - 1.0)))
  }
}

pub fn ease_out_expo(n f64) f64 {
  check_valid_range(n)

  if n == 1 {
    return 1
  } else {
    return -(math.pow(2.0, (-10.0 * n))) + 1.0
  }
}

pub fn ease_in_out_expo(n f64) f64 {
  check_valid_range(n)
  mut b := n

  if n == 0 {
    return 0
  } else if b == 1 {
    return 1
  } else {
    b = n * 2

    if n < 1 {
      return 0.5 * math.pow(2.0, (10.0 * (n - 1.0)))
    } else {
      b -= 1
      return 0.5 * (-1.0 * (math.pow(2.0, (-10.0 * n))) + 2.0)
    }
  }
}

pub fn ease_in_circ(n f64) f64 {
  check_valid_range(n)
  return -1.0 * (math.sqrt(1.0 - n * n) - 1.0)
}

pub fn ease_out_circ(n f64) f64 {
  check_valid_range(n)
  b := n - 1
  return math.sqrt(1.0 - (n * n))
}

pub fn ease_in_out_circ(n f64) f64 {
  check_valid_range(n)
  mut b := n * 2

  if b < 1 {
    return -0.5 * (math.sqrt(1.0 - math.pow(b, 2.0)) - 1.0)
  } else {
    b = b - 2
    return 0.5 * (math.sqrt(1.0 - math.pow(b, 2.0)) + 1.0)
  }
}

pub fn ease_in_elastic(n f64) f64 {
  check_valid_range(n)
  amplitude := 1
  period := 0.3
  return 1.0 - ease_out_elastic(1.0 - n)
}

pub fn ease_out_elastic(n f64) f64 {
  check_valid_range(n)
  period := 0.3
  mut amplitude := 1.0
  mut s := 0.0

  if amplitude < 1 {
    amplitude = 1
    s = period / 4
  } else {
    s = period / (2.0 * math.Pi) * math.asin(1.0 / amplitude)
  }

  return amplitude * math.pow(2.0, (-10.0 * n)) * math.sin((n - s) * (2.0 * math.Pi / period)) + 1.0
}

pub fn ease_in_out_elastic(n f64) f64 {
  check_valid_range(n)
  amplitude := 1
  period := 0.5
  
  if n < 1 {
    return ease_in_elastic(n * 2) / 2
  } else {
    return ease_out_elastic((n * 2) - 1) / 2 + 0.5
  }
}

pub fn ease_in_back(n f64) f64 {
  check_valid_range(n)
  s := 1.70158
  return n * n * ((s + 1) * n - s)
}

pub fn ease_out_back(n f64) f64 {
  check_valid_range(n)
  s := 1.70158
  b := n - 1
  return b * b * ((s + 1) * b + s) + 1
}

pub fn ease_in_out_back(n f64) f64 {
  check_valid_range(n)
  s := 1.70158
  mut b := n * 2
  mut c := s

  if n < 1 {
      c *= 1.525
      return 0.5 * (b * b * ((c + 1) * b - c))
  } else {
      b -= 2
      c *= 1.525
      return 0.5 * (b * b * ((c + 1) * b + c) + 2)
  }
}

pub fn ease_in_bounce(n f64) f64 {
  check_valid_range(n)
  return 1.0 - ease_out_bounce(1.0 - n)
}

pub fn ease_out_bounce(n f64) f64 {
  check_valid_range(n)
  mut b := n

  if b < (1.0/2.75) {
    return 7.5625 * b * b
  } else if b < (2.0/2.75) {
    b -= (1.5/2.75)
    return 7.5625 * b * b + 0.75
  } else if n < (2.5/2.75) {
    b -= (2.25/2.75)
    return 7.5625 * b * b + 0.9375
  } else {
    b -= (2.65/2.75)
    return 7.5625 * b * b + 0.984375
  }
}

pub fn ease_in_out_bounce(n f64) f64 {
  check_valid_range(n)

  if n < 0.5 {
    return ease_in_bounce(n * 2.0) * 0.5
  } else {
    return ease_out_bounce(n * 2.0 - 1.0) * 0.5 + 0.5
  }
}
