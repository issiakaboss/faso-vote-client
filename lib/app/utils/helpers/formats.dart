class Formats {
   static String formatPrice(double price) {
  if (price >= 1000000) {
    return '${(price / 1000000).toStringAsFixed(1)}M'; 
  } else if (price >= 1000) {
    return '${(price / 1000).toStringAsFixed(1)}k';
  } else {
    return price.toStringAsFixed(0);
  }
}
}
