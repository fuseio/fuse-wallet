String formatPhoneNumber(String phoneNumber, String myCountryCode) {
  phoneNumber = removeUnicodes(phoneNumber);
  myCountryCode = removeUnicodes(myCountryCode);
  String countryCodeNumeric = myCountryCode.replaceFirst('+', '');
  phoneNumber = phoneNumber.startsWith(countryCodeNumeric)
      ? phoneNumber.replaceFirst(countryCodeNumeric, '')
      : phoneNumber;
  phoneNumber = phoneNumber.startsWith(myCountryCode)
      ? phoneNumber.replaceFirst(myCountryCode, '')
      : phoneNumber;
  phoneNumber =
      phoneNumber.replaceAll(RegExp('(-| |\\(0\\)|\\(0|\\(|\\))'), '');
  phoneNumber = phoneNumber.replaceFirst(RegExp('^0+'), '');
  if (!phoneNumber.startsWith('+')) {
    if (myCountryCode.contains('+')) {
      phoneNumber = myCountryCode + phoneNumber;
    } else {
      myCountryCode = '+$myCountryCode';
      phoneNumber = myCountryCode + phoneNumber;
    }
  }
  return phoneNumber;
}

String removeUnicodes(String value) {
  return value.replaceAll(RegExp(r"[^\s\w]"), '');
}

String clearNotNumbersAndPlusSymbol(String phoneNumber) {
  return phoneNumber.replaceAll(RegExp('(-| |\\(0\\)|\\(0|\\(|\\))'), '');
}
