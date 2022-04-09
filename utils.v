module vrobot

pub fn normalize(val f64, min f64, max f64) f64 {
  return (val - min) / (max - min)
}