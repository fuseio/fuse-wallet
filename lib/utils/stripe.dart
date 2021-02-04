import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:peepl/redux/actions/cash_wallet_actions.dart';
import 'package:peepl/utils/stripe_custom_response.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  StripeService._privateConstructor();

  static final StripeService _intance = StripeService._privateConstructor();

  factory StripeService() => _intance;

  String _paymentApiUrl =
      'http://ec2-18-198-1-146.eu-central-1.compute.amazonaws.com/api/stripe/pay';
  String _apiKey =
      'pk_test_51IFlGaF8mk2quJk5flt3T1QwFcGzY7DjUk0YJaWe5nxmSMPNUegWZ3Fox9H99PVfMzKJjovk9Prc3g9eMKM0rOHy00iZJddxqk';

  void init() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: this._apiKey,
        androidPayMode: 'test',
        merchantId: 'test',
      ),
    );
  }

  Future<StripeCustomResponse> payWithNewCard({
    @required String amount,
    @required String currency,
    @required String walletAddress,
  }) async {
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest(),
      );

      final StripeCustomResponse resp = await this._makePayment(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
        walletAddress: walletAddress,
      );

      return resp;
    } catch (e) {
      return StripeCustomResponse(
        ok: false,
        msg: e.toString(),
      );
    }
  }

  Future<StripeCustomResponse> payAppleGooglePay({
    @required String amount,
    @required String currency,
    @required String walletAddress,
  }) async {
    try {
      final newAmount = double.parse(amount) / 100;

      final token = await StripePayment.paymentRequestWithNativePay(
        androidPayOptions: AndroidPayPaymentRequest(
          currencyCode: currency,
          totalPrice: amount,
        ),
        applePayOptions: ApplePayPaymentOptions(
            countryCode: 'US',
            currencyCode: currency,
            items: [
              ApplePayItem(
                label: 'producto 1',
                amount: '$newAmount',
              ),
            ]),
      );

      final paymentMethod =
          await StripePayment.createPaymentMethod(PaymentMethodRequest(
        card: CreditCard(
          token: token.tokenId,
        ),
      ));

      final resp = await this._makePayment(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
        walletAddress: walletAddress,
      );

      await StripePayment.completeNativePayRequest();

      return resp;
    } catch (e) {
      print('Error: ${e.toString()}');
      return StripeCustomResponse(
        ok: false,
        msg: e.toString(),
      );
    }
  }

  Future<StripeCustomResponse> createPaymentMethod({
    @required String amount,
    @required String currency,
    @required CreditCard card,
    @required String walletAddress,
  }) async {
    try {
      final paymentMethod =
          await StripePayment.createPaymentMethod(PaymentMethodRequest(
        card: card,
      ));

      final resp = await this._makePayment(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
        walletAddress: walletAddress,
      );

      return resp;
    } catch (e) {
      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }

  Future<Map> _crearPaymentIntent({
    @required String amount,
    @required String currency,
    @required String paymentMethodId,
    @required String walletAddress,
  }) async {
    try {
      String body = jsonEncode(
        Map.from({
          'amount': num.tryParse(amount) ?? amount,
          'currency': currency,
          'paymentMethodId': paymentMethodId,
          'walletAddress': walletAddress
        }),
      );
      final response = await Client().post(
        _paymentApiUrl,
        headers: {"Content-Type": 'application/json'},
        body: body,
      );
      final Map data = responseHandler(response);
      return data['data']['paymentIntent'];
    } catch (e) {
      print('Error _crearPaymentIntent ${e.toString()}');
      return {'error': e.toString()};
    }
  }

  Future<StripeCustomResponse> _makePayment({
    @required String amount,
    @required String currency,
    @required PaymentMethod paymentMethod,
    @required String walletAddress,
  }) async {
    try {
      final paymentIntent = await this._crearPaymentIntent(
        amount: amount,
        currency: currency,
        paymentMethodId: paymentMethod.id,
        walletAddress: walletAddress,
      );

      final PaymentIntentResult paymentResult =
          await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent['clientSecret'],
          paymentMethodId: paymentMethod.id,
        ),
      );

      if (paymentResult.status == 'succeeded') {
        return StripeCustomResponse(ok: true);
      } else {
        return StripeCustomResponse(
          ok: false,
          msg: 'Failed ${paymentResult.status}',
        );
      }
    } catch (e) {
      print('Error _makePayment: ${e.toString()}');
      return StripeCustomResponse(
        ok: false,
        msg: e.toString(),
      );
    }
  }
}
