import 'package:flutter/material.dart';
import 'package:flutter_paypal_native/flutter_paypal_native.dart';
import 'package:flutter_paypal_native/models/custom/currency_code.dart';
import 'package:flutter_paypal_native/models/custom/environment.dart';
import 'package:flutter_paypal_native/models/custom/user_action.dart';

class PaypalGateway extends StatefulWidget {
  const PaypalGateway({super.key});

  @override
  PaypalGatewayState createState() => PaypalGatewayState();
}

class PaypalGatewayState extends State<PaypalGateway> {
  final _flutterPaypalPlugin = FlutterPaypalNative.instance;

  @override
  void initState() {
    super.initState();
    initPayPal();
  }

  void initPayPal() async {
    await _flutterPaypalPlugin.init(
      returnUrl:
          "com.Platform Partner App - 4815457267258627131.scheme://payment",
      // 앱에서 처리할 URL
      clientID:
          "AT31esdhFVHuLtKQqGpbRZy32tcoUL8MzpKGYPNcI8IdnAaUwbyVlWc5ntmNHHWPiYrU1YpZBVl5iE2p",
      // PayPal Developer Dashboard에서 제공하는 Sandbox 모드의 Client ID
      payPalEnvironment: FPayPalEnvironment.sandbox,
      // Sandbox 모드로 설정 실제에서는 live
      currencyCode: FPayPalCurrencyCode.usd,
      // 사용할 통화 코드. 필요에 따라 변경 가능 현재는 달러
      action: FPayPalUserAction.payNow, // 결제 동작 설정. payNow는 결제를 즉시 실행.
    );

    // 필요한 경우, 다른 설정이나 콜백 함수도 추가로 설정가능.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PayPal Gateway'),
      ),
      body: Center(
        child: Text('Welcome to PayPal Gateway!'),
      ),
    );
  }
}
