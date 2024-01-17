


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/crm/crm_service.dart';
import 'package:luround/views/account_owner/bookings/widget/search_textfield.dart';
import 'package:luround/views/account_owner/more/widget/crm/add_contact_screen.dart';
import 'package:luround/views/account_owner/more/widget/crm/crm_empty_state.dart';
import '../../../../../controllers/account_owner/profile/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/title_text.dart';








class ContactScreen extends StatefulWidget {
  ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  var service = Get.put(CRMService());

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
        title: CustomAppBarTitle(text: 'Contacts',),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => AddContactScreen());
            }, 
            child: Text(
              "+ Add new",
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: AppColor.mainColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
                decoration: TextDecoration.underline,
                decorationColor: AppColor.mainColor
              ),
            ),
          ),
          SizedBox(width: 12.w,)
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[ 
              //SizedBox(height: 10.h,),         
              /*Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7,
              ),*/

              //search textfield
              SearchTextField(
                onFocusChanged: (val) {},
                onFieldSubmitted: (val) {
                  setState(() {
                    service.filterContacts(val);
                  });
                },
                hintText: "Search",
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                textController: service.searchContactController,
                onTap: () {},
              ),

              SizedBox(height: 30.h,),

            
              //listview.builder
              Obx(
                () {
                  return service.filteredContactList.isNotEmpty ? ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: service.filteredContactList.length,
                    separatorBuilder: (context, index) => Divider(color: AppColor.darkGreyColor, thickness: 0.5,),
                    itemBuilder: (context, index) {
                      final item = service.filteredContactList[index];
                      if(service.filteredContactList.isEmpty) {
                        return CRMEmptyState(
                          onPressed: () {},
                        );
                      }
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (service.selectedIndex == index) {
                              // Collapse the selected item.
                              service.selectedIndex = -1;
                            } 
                            else {
                              // Expand the selected item.
                              service.selectedIndex = index; 
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.bgColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColor.mainColor,
                                    radius: 30.r,
                                    child: Text(
                                      item.client_name.substring(0, 1),
                                      style: GoogleFonts.inter(
                                        color: AppColor.bgColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item.client_name,  //recepient name
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: AppColor.blackColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                            )
                                          )
                                        ),
                                        service.selectedIndex == index ?
                                        Icon(
                                          CupertinoIcons.chevron_down,
                                          color: AppColor.blackColor,
                                        )
                                        :Icon(
                                          CupertinoIcons.chevron_forward,
                                          color: AppColor.blackColor,
                                        )                    
                                      ],
                                    ),
                                  )
                                ]
                              ),
                              SizedBox(height: 20.h,),
                                          
                              //client email and mobile number column (expandable)
                              service.selectedIndex == index ?
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //row 1
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        CupertinoIcons.mail,
                                        color: AppColor.textGreyColor,
                                      ),
                                      SizedBox(width: 10.w,),
                                      Text(
                                          item.client_email,
                                          style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: AppColor.textGreyColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                          )
                                        )
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        CupertinoIcons.phone,
                                        color: AppColor.textGreyColor,
                                      ),
                                      SizedBox(width: 10.w,),
                                      Text(
                                          item.client_phone_number,
                                          style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: AppColor.textGreyColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                          )
                                        )
                                      ),
                                    ],
                                  )
                                ],
                              ) : SizedBox(),
                            ]
                          )
                        ),
                      );
                    }
                  ): CRMEmptyState(
                    onPressed: () {},
                  );
                }
              )
              //////////////////
            ]
          )
        )
      )
    );
  }
}