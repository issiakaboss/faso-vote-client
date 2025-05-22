
class Functions {
  static String currencyToEmoji(String countyCode) {
    countyCode = countyCode.toUpperCase();
    final int firstLetter = countyCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countyCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }


}
