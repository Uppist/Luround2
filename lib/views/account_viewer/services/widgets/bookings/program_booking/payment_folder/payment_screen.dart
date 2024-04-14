import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/services/account_viewer/services/get_user_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_viewer/services/widgets/bookings/program_booking/payment_folder/black_card_for_accviewer.dart';
import 'package:luround/views/account_viewer/services/widgets/bookings/program_booking/payment_folder/green_card_for_accviewer.dart';
import 'package:luround/views/account_viewer/services/widgets/bookings/program_booking/payment_folder/loading_black_card.dart';
import 'package:luround/views/account_viewer/services/widgets/bookings/program_booking/payment_folder/upload_receipt_widget.dart';









class PaymentScreenProgram extends StatefulWidget {
  const PaymentScreenProgram({super.key, required this.amount, required this.service_name, required this.serviceId, required this.time, required this.duration, required this.date, required this.service_provider_id, });
  final String amount;
  final String service_name;
  final String serviceId;
  final String time;
  final String duration;
  final String date;
  final String service_provider_id;

  @override
  State<PaymentScreenProgram> createState() => _PaymentScreenProgramState();
}

class _PaymentScreenProgramState extends State<PaymentScreenProgram> {

  var controller = Get.put(AccViewerServicesController());
  var service = Get.put(AccViewerService());
  var withdrawalService = Get.put(WithdrawalService());

  @override
  void initState() {
    // TODO: implement onInit
    withdrawalService.loadSavedBanksData(user_id: widget.service_provider_id)
    .then((value) {
      service.userBankAccountList.value = value;
      debugPrint("user bank accounts: ${service.userBankAccountList}");
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
                              return LoadingBlackCardAccViewer();
                            }
                          ) : LoadingBlackCardAccViewer();
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
                              controller.imageFromGallery.value = null;
                            },
                            file: controller.imageFromGallery.value,
                            text: "file uploaded",
                          )
                          :UploadReceiptWidget(
                            onPressed: () {
                              controller.pickFileForPayment(context);
                            },
                          );
                        }
                      ),
                      SizedBox(height: 10.h),
                      
                      Obx(
                        () {
                          return controller.isLoading.value ? Loader2() : SizedBox();
                        }
                      ),
          
                      //sizedbox_height
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          
                      //pay button
                      Obx(
                        () {
                          return service.isLoading.value ? Loader() : RebrandedReusableButton(
                            textColor: controller.isFileSelectedForBooking.value ? AppColor.bgColor : AppColor.darkGreyColor,
                            color: controller.isFileSelectedForBooking.value ? AppColor.mainColor : AppColor.lightPurple, 
                            text: controller.isFileSelectedForBooking.value ? "I've made payment" : "Pay N${widget.amount}", 
                            onPressed: controller.isFileSelectedForBooking.value  
                            ? () async{
                              await service.bookUserService(
                                context: context, 
                                name: controller.nameBAController.text, 
                                email: controller.emailBAController.text.trim(), 
                                service_name: widget.service_name,                  
                                serviceId: widget.serviceId, 
                                phone_number: "${controller.codeBA.value} ${controller.phoneNumberBAController.text}", 
                                appointment_type: controller.step1Appointment, 
                                date: widget.date, 
                                time: widget.time,
                                duration: widget.duration, 
                                message: controller.messageBAController.text, 
                                file: controller.paymentProofUrl.value,
                                location: controller.step1Appointment == 'Virtual' 
                                ?"The location for this service is set to be virtual." 
                                :"The location for this service is set to be physical."
                              ).whenComplete(() {
                                controller.isFileSelectedForBooking.value = false;
                                controller.imageFromGallery.value = null;
                                controller.nameBAController.clear();
                                controller.emailBAController.clear();
                                controller.phoneNumberBAController.clear();
                                controller.messageBAController.clear();
                                //1
                                setState(() {
                                  controller.codeBA.value = "";
                                  controller.paymentProofUrl.value = "";
                                  controller.curentStep = controller.curentStep - 1;
                                });
                              });
                            }
                            : () {
                              print('nothing');
                            },
                          );
                        }
                      ),
                      SizedBox(height: 10.h,),
                
                    ]
                  ),
                ),
              ],
            )
          )
  
    );
  }
}