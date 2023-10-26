import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/payment_folder/transaction_successful_screen.dart';
import 'payment_textfield.dart';









class PaymentScreen extends StatefulWidget {
  PaymentScreen({super.key, required this.amount});
  final int amount;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  var controller = Get.put(AccViewerServicesController());

  @override
  void initState() {
    // Add a listener to the text controller
    controller.cvvController.addListener(() {
      setState(() {
        // Check if the text field is empty or not
        controller.isCVVEnabled.value = controller.cvvController.text.isNotEmpty;
      });
    });
    //
    //
    //
    //
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColor.blackColor,
          )
        ),
        title: CustomAppBarTitle(text: 'Back',),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: GlobalKey(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Container(
                    color: AppColor.greyColor,
                    width: double.infinity,
                    height: 7,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "Enter your payment details",
                    style: GoogleFonts.poppins(
                      color: AppColor.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 20,),
                  PaymentTextField(
                    onChanged: (val) {},
                    hintText: "Cardholder name*",
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    textController: controller.cardholderNameController,
                  ),
                  SizedBox(height: 20,),
                  PaymentTextField(
                    onChanged: (val) {},
                    hintText: "Card number*",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    textController: controller.cardNumberController,
                  ),
                  SizedBox(height: 20,),
                  PaymentTextField(
                    onChanged: (val) {},
                    hintText: "Expiry date*",
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.next,
                    textController: controller.expiryDateController,
                  ),
                  SizedBox(height: 20,),
                  PaymentTextField(
                    onChanged: (val) {},
                    hintText: "CVV*",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    textController: controller.cvvController,
                  ),
                  SizedBox(height: 350,),
                  //pay button
                  RebrandedReusableButton(
                    textColor: controller.isCVVEnabled.value ? AppColor.bgColor : AppColor.darkGreyColor,
                    color: controller.isCVVEnabled.value ? AppColor.mainColor : AppColor.lightPurple, 
                    text: "Pay N${widget.amount}", 
                    onPressed: controller.isCVVEnabled.value  
                    ? () {
                      print("yayyyy");
                      Get.to(() => TransactionSuccesscreen());
                    }
                    : () {
                      print('nothing');
                    },
                  ),
                  SizedBox(height: 10,),

                  /*Icon(
                    CupertinoIcons.check_mark_circled, 
                    color: AppColor.textGreyColor, 
                    size: 20,
                  )*/
                ]
              ),
            ),
          )
        )
      )
    );
  }
}