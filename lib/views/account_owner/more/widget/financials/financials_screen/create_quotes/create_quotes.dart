import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/custom_container.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/due_date_selector.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/notes_textfield.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/quote_date_selector.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/select_client_bottomsheet.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/select_client_widget.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';









class CreateQuotePage extends StatefulWidget {
  CreateQuotePage({super.key});

  @override
  State<CreateQuotePage> createState() => _CreateQuotePageState();
}

class _CreateQuotePageState extends State<CreateQuotePage> {
  var controller = Get.put(FinancialsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///Header Section/////
            Container(
              color: AppColor.bgColor,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/luround_logo.png'),
                      InkWell(
                        onTap: () {
                          Get.to(() => NotificationsPage());
                        },
                        child: SvgPicture.asset("assets/svg/notify_active.svg"),
                      ),
                    ]
                  ),
                ]
              )
            ),
            SizedBox(height: 20.h,),
            ///Navigation Section, Search TextField and Filter/////
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w,),
              //height: 70, //65
              width: double.infinity,
              color: AppColor.bgColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      CupertinoIcons.xmark,
                      color: AppColor.blackColor,
                    )
                  ),
                  SizedBox(width: 90.w,),
                  Text(
                    "Quote 000001",
                    style: GoogleFonts.inter(
                      color: AppColor.textGreyColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),

            //Epanded single child scroll view////
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //style
                    Container(
                      height: 7.h,
                      width: double.infinity,
                      color: AppColor.greyColor,
                    ),

                    //1 Header and Date Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Logged in user details
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical:10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 35.r,
                                  backgroundColor: AppColor.mainColor,
                                  //backgroundImage: ,
                                ),
                                SizedBox(width: 20.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,                       
                                    children: [
                                      Text(
                                        "Ronald Richard",
                                        style: GoogleFonts.inter(
                                          color: AppColor.darkGreyColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      SizedBox(height: 8.h,),
                                      Text(
                                        "richie@gmail.com",
                                        style: GoogleFonts.inter(
                                          color: AppColor.textGreyColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],                      
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey, thickness: 0.2,),
                          SizedBox(height: 30.h,),
                          Text(
                            "Send to*",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          //SELECT CLIENT
                          SelectClientWidget(
                            clientName: "Select a client",
                            onTap: () {
                              selectClientBottomSheet(
                                context: context,
                              );
                            },
                          ),
                          SizedBox(height: 20.h,),
                          Text(
                            "Quote Date*",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 20.h,),
                        
                          Obx(
                            () {
                              return DateContainer(
                                onTap: () {
                                  selectQuoteDateBottomSheet(
                                    context: context,
                                    onCancel: () {
                                      Get.back();
                                    },
                                    onApply: () {
                                      Get.back();
                                    },
                                  );
                                },
                                date: controller.updatedQuoteDate(initialDate: "Select Date"),
                              );
                            }
                          ),                  
                          
                          SizedBox(height: 30.h,),
                          Text(
                            "Due Date*",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Obx(
                            () {
                              return DateContainer(
                                onTap: () {
                                  selectDueDateBottomSheet(
                                    context: context,
                                    onCancel: () {
                                      Get.back();
                                    },
                                    onApply: () {
                                      Get.back();
                                    },
                                  );
                                },
                                date: controller.updatedDueDate(initialDate: "Select Date"),
                              );
                            }
                          ),
                    
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h,),
                    //style
                    Container(
                      height: 7.h,
                      width: double.infinity,
                      color: AppColor.greyColor,
                    ),
                    SizedBox(height: 20.h,),

                    //2 add services section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Add product or service*",
                                style: GoogleFonts.inter(
                                  color: AppColor.blackColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: SvgPicture.asset("assets/svg/add_icon.svg")
                              )
                            ],
                          ),
                          //Future builder list of selected services comes here
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Container(
                      height: 7.h,
                      width: double.infinity,
                      color: AppColor.greyColor,
                    ),
                    SizedBox(height: 20.h,),

                    //3 calculations
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                      child: Column(
                        children: [
                          //row1
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Subtotal",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                "N25,000",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h,),
                          //row2
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Discount",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                "-N2,000",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h,),
                          //row3
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                "N23,000",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    //style
                    Container(
                      height: 7.h,
                      width: double.infinity,
                      color: AppColor.greyColor,
                    ),
                    SizedBox(height: 20.h,),

                    //4 write notes section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notes (optional)",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          NotesTextField(
                            onChanged: (val) {
                              // Check if character count exceeds the maximum
                              if (val.length > controller.maxLength) {
                                // Remove extra characters       
                                controller.quoteNoteController.text = val.substring(0, controller.maxLength);
                                debugPrint("you have reached max length");
                              } 
                              setState(() {}); // Update the UI
                            },
                            hintText: "Write a short note for the recipient.",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            controller: controller.quoteNoteController,
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${controller.quoteNoteController.text.length}/${controller.maxLength}',
                                style: GoogleFonts.poppins(
                                  color: AppColor.textGreyColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500
                                )
                              ),
                            ]
                          ),
                        ]
                      )
                    ),
                    SizedBox(height: 20.h,),
                    //style
                    Container(
                      height: 7.h,
                      width: double.infinity,
                      color: AppColor.greyColor,
                    ),
                    SizedBox(height: 20.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: ReusableButton(
                        color: AppColor.mainColor,
                        text: 'Send Quote',
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height: 20.h,),
                  ],
                ),
              )
            )

          ]
        )
      )
    );
  }
}