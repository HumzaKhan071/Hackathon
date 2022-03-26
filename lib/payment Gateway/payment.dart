import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentHomeScreen extends StatefulWidget {
  const PaymentHomeScreen({Key? key}) : super(key: key);

  @override
  _PaymentHomeScreenState createState() => _PaymentHomeScreenState();
}

class _PaymentHomeScreenState extends State<PaymentHomeScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController amount = TextEditingController();

  late Razorpay _razorpay;

  @override
  void initState() {
    initializeRazorPay();

    super.initState();
  }

  void launchRazorPay() {
    int amountToPay = int.parse(amount.text) * 100;
    var options = {
      'key': 'rzp_test_cCREwC9xnlENIM',
      'amount': "$amountToPay",
      'name': name.text,
      'description': description.text,
      'prefill': {'contact': phoneNo.text, 'email': email.text}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error : $e");
    }
  }

  void initializeRazorPay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Successfull");

    print(
        "${response.orderId} \n${response.paymentId} \n${response.signature}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed");

    print("${response.code}\n${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("Payment Failed");
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Payments"),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              textField(size, "name", false, name),
              textField(size, "Phone no.", false, phoneNo),
              textField(size, "Email", false, email),
              textField(size, "Description", false, description),
              textField(size, "amount", true, amount),
              ElevatedButton(
                onPressed: launchRazorPay,
                child: Text("pay Now"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(Size size, String text, bool isNumerical,
      TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height / 50),
      child: Container(
        height: size.height / 15,
        width: size.width / 1.1,
        child: TextField(
          controller: controller,
          keyboardType: isNumerical ? TextInputType.number : null,
          decoration:
              InputDecoration(hintText: text, border: OutlineInputBorder()),
        ),
      ),
    );
  }
}
