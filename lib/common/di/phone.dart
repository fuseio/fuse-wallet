import 'package:injectable/injectable.dart';
import 'package:phone_number/phone_number.dart';

@module
abstract class Phone {
  @lazySingleton
  PhoneNumberUtil get phoneNumberUtil => PhoneNumberUtil();
}
