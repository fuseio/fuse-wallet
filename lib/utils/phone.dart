String formatPhoneNumber (String phoneNumber, String myCountryCode) {
  String formattedPhoneNumber = phoneNumber.replaceAll(new RegExp('(-| )'), '').replaceFirst(new RegExp('^0+'), '');
  if (formattedPhoneNumber[0] != '+') {
    formattedPhoneNumber = myCountryCode + formattedPhoneNumber;
  }
  return formattedPhoneNumber;
}