import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:uuid/uuid.dart';





class TestFlutterwave extends StatelessWidget {


  handlePaymentInitialization(BuildContext context) async { 
	 final Customer customer = Customer(
	 name: "Flutterwave Developer",
	 phoneNumber: "1234566677777",   
     email: "customer@customer.com"  
 );            
    final Flutterwave flutterwave = Flutterwave(
        context: context, 
        publicKey: "FLWPUBK_TEST-3718c40f5e0f4f9ba647682545f96a9f-X",
		    currency: "NGN",   
        redirectUrl: "add-your-redirect-url-here",  
        txRef: "add-your-unique-reference-here",   
        amount: "3000",   
        customer: customer,   
        paymentOptions: "ussd, card, barter, payattitude",   
        customization: Customization(title: "My Payment"),
        isTestMode: true );

    final ChargeResponse response = await flutterwave.charge(); 
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Centered Elevated Button'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add your button click logic here
            handlePaymentInitialization(context);
          },
          child: Text('Press Me'),
        ),
      ),
    );
  }
}