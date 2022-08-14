let asCurrency = (value: float) => {
  Js.Float.toFixedWithPrecision(value, ~digits=2)
} 
