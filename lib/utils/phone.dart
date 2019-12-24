String formatPhoneNumber (String phoneNumber, String myCountryCode) {
  String countryCodeNumeric = myCountryCode.replaceFirst('+', '');
  phoneNumber = phoneNumber.replaceFirst(myCountryCode, '');
  phoneNumber = phoneNumber.startsWith(countryCodeNumeric) ? phoneNumber.replaceFirst(countryCodeNumeric, '') : phoneNumber;
  phoneNumber = phoneNumber.replaceAll(new RegExp('(-| |\\(0\\)|\\(0|\\(|\\))'), '');
  phoneNumber = phoneNumber.replaceFirst(new RegExp('^0+'), '');
  if (!phoneNumber.startsWith('+')) {
    phoneNumber = myCountryCode + phoneNumber;
  }
  return phoneNumber;
}