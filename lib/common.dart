import 'dart:io';

bool isValidPhone(String value) {
    if (value.length < 8) {
      return false;
    } else {
      return true;
    }
}

bool isValidEmail(String em) {
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}

  bool isIPhoneX() {
    return Platform.isIOS;
  }