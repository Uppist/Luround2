import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/services/account_viewer/services/get_user_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/payment_folder/black_card_for_accviewer.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/payment_folder/green_card_for_accviewer.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/payment_folder/upload_receipt_widget.dart';










class PaymentScreen extends StatefulWidget {
  PaymentScreen({super.key, required this.amount, required this.service_name, required this.serviceId, required this.time, required this.duration, required this.date, });
  
  final String amount;
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
      body: SingleChildScrollView(
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
                        "Make your payment to any of the following account detail below:",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 30.h,),
                      /*Text(
                        "Account detail",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 10.h,),*/
                      //Futurebuilder with the user list of aza
                      Obx(
                        () {
                          return service.userBankAccountList.isNotEmpty ? ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                            itemCount: service.userBankAccountList.length,
                            itemBuilder: (context, index) {
                          
                              final item = service.userBankAccountList[index];
                          
                              if(index.isEven) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Account Detail ${index + 1}",
                                      style: GoogleFonts.inter(
                                        color: AppColor.blackColor,
                                        fontSize: 14.sp,
                                      fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                    GreenCardAccViewer(
                                      accountName: item.account_name, 
                                      accountNumber: item.account_number, 
                                      bank: item.bank_name
                                    ),
                                  ],
                                );
                              }
                              if(index.isOdd) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Account Detail ${index + 1}",
                                      style: GoogleFonts.inter(
                                        color: AppColor.blackColor,
                                        fontSize: 14.sp,
                                      fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                    BlackCardAccViewer(
                                      accountName: item.account_name, 
                                      accountNumber: item.account_number, 
                                      bank: item.bank_name
                                    ),
                                  ],
                                );
                              }
                              return BlackCardAccViewer(
                                accountName: 'unavailable',
                                accountNumber: 'unavailable',
                                bank: 'unavailable',
                              );
                            }
                          ) : BlackCardAccViewer(
                            accountName: 'unavailable',
                            accountNumber: 'unavailable',
                            bank: 'unavailable',
                          );
                        }
                      ),
                      //////////
                      SizedBox(height: 40.h,),
                      Text(
                        "Upload proof of payment",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 30.h,),
                      Obx(
                        () {
                          return controller.isFileSelectedForBooking.value ?
                          UploadedReceiptWidget(
                            onDelete: () {
                              controller.isFileSelectedForBooking.value = false;
                              controller.selectedFileForBooking = null;
                              controller.isReceitUploaded.value = false;
                            },
                            file: controller.selectedFileForBooking!,
                            text: controller.isReceitUploaded.value ? "file uploaded" : "file selected",
                          )
                          :UploadReceiptWidget(
                            onPressed: () {
                              controller.pickFileForPayment(context);
                            },
                          );
                        }
                      ),
          
                      SizedBox(height: 160.h,),
          
                      //pay button
                      Obx(    //isFileSelectedForBooking
                        () {
                          return service.isLoading.value ? Loader() : RebrandedReusableButton(
                            textColor: controller.isReceitUploaded.value ? AppColor.bgColor : AppColor.darkGreyColor,
                            color: controller.isReceitUploaded.value ? AppColor.mainColor : AppColor.lightPurple, 
                            text: controller.isReceitUploaded.value ? "I've made payment" : "Pay N${widget.amount}", 
                            onPressed: controller.isReceitUploaded.value  
                            ? () async{
                              await service.bookUserService(
                                context: context, 
                                name: controller.nameBAController.text, 
                                email: controller.emailBAController.text.trim(), 
                                service_name: widget.service_name,                  
                                serviceId: widget.serviceId, 
                                phone_number: "${controller.codeBA.value} ${controller.phoneNumberBAController.text}", 
                                appointment_type: controller.step1Appointment, 
                                date: controller.getDate(initialDate: widget.date), 
                                time: widget.time, //controller.getTime()
                                duration: widget.duration, 
                                message: controller.messageBAController.text, 
                                location: controller.step1Appointment == 'Virtual' 
                                ?"The location for this service is set to be virtual." 
                                :"The location for this service is set to be physical."
                              ).whenComplete(() {
                                controller.isFileSelectedForBooking.value = false;
                                controller.selectedFileForBooking = null;
                                controller.isReceitUploaded.value = false;
                              });
                            }
                            : () {
                              print('nothing');
                            },
                          );
                        }
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
  
    );
  }
}