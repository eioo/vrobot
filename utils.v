module vrobot

pub fn normalize(val, min, max f64) f64 {
  return (val - min) / (max - min)
}