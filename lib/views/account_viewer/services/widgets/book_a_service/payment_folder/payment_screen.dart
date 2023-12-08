import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/services/account_viewer/services/get_user_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/payment_folder/transaction_successful_screen.dart';
import 'payment_textfield.dart';









class PaymentScreen extends StatefulWidget {
  PaymentScreen({super.key, required this.amount, required this.service_name, required this.serviceId, required this.time, required this.duration, required this.date});
  final int amount;
  final String service_name;
  final String serviceId;
  final String time;
  final String duration;
  final String date;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  var controller = Get.put(AccViewerServicesController());
  var service = Get.put(AccViewerService());

  @override
  void initState() {
    // Add a listener to the text controller
    controller.cvvController.addListener(() {
      setState(() {
        // Check if the text field is empty or not
        controller.isCVVEnabled.value = controller.cvvController.text.isNotEmpty;
      });
    });
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7.h,
              ),
              SizedBox(height: 20.h,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Enter your payment details",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    PaymentTextField(
                      onChanged: (val) {},
                      hintText: "Cardholder name*",
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      textController: controller.cardholderNameController,
                    ),
                    SizedBox(height: 30.h,),
                    PaymentTextField(
                      onChanged: (val) {},
                      hintText: "Card number*",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      textController: controller.cardNumberController,
                    ),
                    SizedBox(height: 30.h,),
                    PaymentTextField(
                      onChanged: (val) {},
                      hintText: "Expiry date*",
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      textController: controller.expiryDateController,
                    ),
                    SizedBox(height: 30.h,),
                    PaymentTextField(
                      onChanged: (val) {},
                      hintText: "CVV*",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      textController: controller.cvvController,
                    ),
                    SizedBox(height: 270.h,),
                    //pay button
                    RebrandedReusableButton(
                      textColor: controller.isCVVEnabled.value ? AppColor.bgColor : AppColor.darkGreyColor,
                      color: controller.isCVVEnabled.value ? AppColor.mainColor : AppColor.lightPurple, 
                      text: "Pay N${widget.amount}", 
                      onPressed: controller.isCVVEnabled.value  
                      ? () async{
                        await service.bookUserService(
                          context: context, 
                          name: controller.nameBAController.text, 
                          email: controller.emailBAController.text.trim(), 
                          service_name: widget.service_name,                  
                          serviceId: widget.serviceId, 
                          phone_number: "${controller.codeBA} ${controller.phoneNumberBAController.text}", 
                          appointment_type: controller.step1Appointment, 
                          date: controller.getDate(initialDate: widget.date), 
                          time: widget.time, //controller.getTime()
                          duration: widget.duration, 
                          message: controller.messageBAController.text, 
                          location: controller.step1Appointment == 'Virtual' 
                          ?"The location for this service is set to be virtual." 
                          :"The location for this service is set to be physical."
                        ).whenComplete(() {
                          controller.nameBAController.clear();
                          controller.emailBAController.clear();
                          controller.phoneNumberBAController.clear();
                          controller.messageBAController.clear();
                          controller.cardholderNameController.clear();
                          controller.cardNumberController.clear();
                          controller.expiryDateController.clear();
                          controller.cvvController.clear();
                        });
                      }
                      : () {
                        print('nothing');
                      },
                    ),
                    SizedBox(height: 10.h,),
              
                    /*Icon(
                      CupertinoIcons.check_mark_circled, 
                      color: AppColor.textGreyColor, 
                      size: 20,
                    )*/
                  ]
                ),
              ),
            ],
          )
        )
      )
    );
  }
}