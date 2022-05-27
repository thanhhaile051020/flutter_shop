import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalPayment extends StatefulWidget {
  final double? amount;
  final String currency;
  const PaypalPayment({Key? key, required this.amount, required this.currency})
      : super(key: key);

  @override
  State<PaypalPayment> createState() => _PaypalPaymentState();
}

class _PaypalPaymentState extends State<PaypalPayment> {
  int totalPrices = 0;

  void initState() {
    totalPrices = Provider.of<Cart>(context, listen: false).total;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: WebView(
        initialUrl:
            'http://10.0.2.2:3000/createpaypalpayment?amount=${totalPrices}&currency=${widget.currency}',
        javascriptMode: JavascriptMode.unrestricted,
        gestureRecognizers: Set()
          ..add(Factory<DragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())),
        onPageFinished: (value) {
          print(value);
        },
        navigationDelegate: (NavigationRequest request) async {
          if (request.url.contains('http://return_url/?status=success')) {
            print('return url on success');
            Navigator.pop(context);
            await Provider.of<Cart>(context, listen: false).placeOrder();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'Order Placed Successfully!',
                  textAlign: TextAlign.center,
                ),
                content: LottieBuilder.asset(
                  'assets/images/success.json',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Provider.of<Cart>(context, listen: false).clearCart();
                      Navigator.of(context).pushNamed(HomeScreen.routeName);
                    },
                    child: Text(
                      'Okay!',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ],
              ),
            );
          }
          if (request.url.contains('http://cancel_url')) {
            Navigator.pop(context);
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
