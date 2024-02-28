import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/loader.dart';
import '../../../../../controllers/account_owner/profile/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/title_text.dart';
import 'notifications_empty_state.dart';






class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});

  var controller = Get.put(ProfilePageController());
  var userProfileService = Get.put(AccOwnerProfileService());

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
        title: CustomAppBarTitle(text: 'Notifications',),
      ),
      body: FutureBuilder(
        future: userProfileService.getUserNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return NotificationEmptyState(
              onPressed: () {
                userProfileService.getUserNotifications();
              }
            );
          }
          if (!snapshot.hasData) {
            print("sn-trace: ${snapshot.stackTrace}");
            print("sn-error: ${snapshot.error}");

            return NotificationEmptyState(
              onPressed: () {
                userProfileService.getUserNotifications();
              }
            );
          }
       
          if (snapshot.hasData) {
            var data = snapshot.data!;
            List<dynamic> sortedList = [];
            //clear the list then add the stream snapshot to the fetchNotification list
            data.sort((a, b) => a['created_at'].compareTo(b['created_at']));
            sortedList.clear();
            sortedList.addAll(data);
 
            return sortedList.isNotEmpty ? ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: sortedList.length,
              separatorBuilder: (context, index) => Divider(color: AppColor.darkGreyColor, thickness: 0.2,),
              itemBuilder: (context, index) { 

                final item = sortedList[index];
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                                
                    /*Container(
                      color: AppColor.greyColor,
                      width: double.infinity,
                      height: 7,
                    ),*/
                    
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.bgColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColor.mainColor,
                            radius: 30.r,
                            child: Text(
                              item['title'].toString().toUpperCase().substring(0, 1),
                              style: GoogleFonts.inter(
                                color: AppColor.bgColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),

                          SizedBox(width: 15.w),
                          
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],  //recepient name
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      overflow: TextOverflow.visible,
                                      color: AppColor.blackColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                    )
                                  )
                                ),
                                SizedBox(height: 5.h,),
                                Text(
                                  item['body'],
                                  style: GoogleFonts.inter(
                                    color: AppColor.darkGreyColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp
                                  )
                                ),
                                SizedBox(height: 5.h,),
                                Text(
                                  convertServerTimeToDate(item['created_at'] ?? 0) ,
                                  style: GoogleFonts.inter(
                                    color: AppColor.darkGreyColor.withOpacity(0.5),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.sp
                                  )
                                ),
                              ],
                            ),
                          )
                        ]
                      )
                    ),
                  ],
                );
              }
              ) : NotificationEmptyState(
                onPressed: () {
                  userProfileService.getUserNotifications();
                }
              );
            }
            return NotificationEmptyState(
              onPressed: () {
              userProfileService.getUserNotifications();
            }
          );
        }
      )
    );
  }
}