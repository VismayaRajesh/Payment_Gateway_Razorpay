import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late Razorpay _razorpay;

  _handlePaymentErrorResponse(PaymentFailureResponse? response) {
    print(response.toString());
  }

  _handlePaymentSuccessResponse(PaymentSuccessResponse? response) {
    // you can do anything here to print/alert/toast response here
    print(response.toString());
  }

  _handlePaymentWalletResponse(ExternalWalletResponse? response) {
    print(response.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentWalletResponse);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void openCheckOut(double amt, String name, String description, String contact,
      String email) {
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb', //replace with client key
      'amount': amt * 100,
      'name': '$name',
      'description': '$description',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '$contact', 'email': '$email'},
      'external': {
        'wallets': ['paytm']
      }
    };
    _razorpay.open(options);
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: ElevatedButton(onPressed: () {
          openCheckOut(1000, "vis", 'payment', "8506987259",
              "vismayarajesh259@gmail.com");
        }, child: Text("CheckOut")),
      );
    }
  }
