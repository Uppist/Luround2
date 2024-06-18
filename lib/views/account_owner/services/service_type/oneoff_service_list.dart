import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/one-off/oneoff_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/services/user_services_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/bookings/widget/search_textfield.dart';
import 'package:luround/views/account_owner/services/screen/service_empty_state.dart';
import 'package:luround/views/account_owner/services/widget/one-off/add_service/screen/add_service_screen.dart';
import 'package:luround/views/account_owner/services/widget/one-off/edit_service/screen/edit_service_bottomsheet.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/popup_menu/popup_menu.dart';










class RegularServiceList extends StatefulWidget {
  const RegularServiceList({super.key});

  @override
  State<RegularServiceList> createState() => _RegularServiceListState();
}

class _RegularServiceListState extends State<RegularServiceList> {
  
  
  final controller = Get.put(ServicesController());
  final AccOwnerServicePageService userService = Get.put(AccOwnerServicePageService());

  // GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    //});
  }

  Future<void> fetchData() async {
    try {
      List<UserServiceModel> data = await userService.getUserOneOffServices();
      userService.filterOneoffList.clear();
      userService.filterOneoffList.addAll(data);
    } catch (error) {
      log("Error fetching data: $error");
    } finally {
      log("done");
    }
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    //wrap with column then put app the search functionality textformfield
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //search textfield
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SearchTextField(
            onFocusChanged: (val) {},
            onFieldSubmitted: (val) {},
            onChanged: (val) {
              userService.filterOneOffServices(val);          
            },
            hintText: "Search",
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            textController: userService.searchOneoffController,
            onTap: () {},
          ),
        ),

        //SizedBox(height: 20.h,),

        //list
        Obx(
          () {
            /*if (userService.isLoading.value) {
              return Expanded(child: Loader());
            }*/
            if (userService.hasError.value) {
              return Center(
                child: Text(
                  'something went wrong',
                  style: GoogleFonts.inter(
                    color: AppColor.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                ),
              );
              
              /*ServiceEmptyState(
                onPressed: () {
                  Get.to(() => const AddServiceScreen());
                },
              );*/
            }
            if (userService.filterOneoffList.isEmpty) {
              return ServiceEmptyState(
                onPressed: () {
                  Get.to(() => const AddServiceScreen());
                },
              );
            }
        
            return Expanded(
              child: RefreshIndicator.adaptive(
                color: AppColor.greyColor,
                backgroundColor: AppColor.mainColor,
                key: _refreshKey,
                onRefresh: () {
                  return _refresh();
                },
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                  itemCount: userService.filterOneoffList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 25.h),
                  itemBuilder: (context, index) {
                    final data = userService.filterOneoffList[index];
              
                    return Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                      decoration: BoxDecoration(
                        color: index.isEven ? AppColor.navyBlue : AppColor.darkMainColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  data.serviceName,
                                  style: GoogleFonts.inter(
                                    color: AppColor.bgColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  editServiceDialogueBox(
                                    service: userService,
                                    service_status: data.serviceStatus,
                                    context: context,
                                    userId: data.serviceProviderDetails.userId,
                                    email: data.serviceProviderDetails.email,
                                    displayName: data.serviceProviderDetails.displayName,
                                    serviceId: data.serviceId,
                                    service_name: data.serviceName,
                                    description: data.description,
                                    virtual_meeting_link: data.virtualMeetingLink,
                                    service_charge_in_person: data.serviceChargeInPerson,
                                    service_charge_virtual: data.serviceChargeVirtual,
                                    duration: data.duration,
                                    date: data.date,
                                    time: data.time,
                                    available_days: '',
                                  );
                                },
                                child: Icon(
                                  Icons.more_vert_rounded,
                                  color: AppColor.bgColor,
                                  size: 30.r,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          _buildRichText('Service type:  ', data.serviceType.capitalizeFirst!),
                          SizedBox(height: 25.h),
                          Text(
                            "Available on",
                            style: GoogleFonts.inter(
                              color: index.isEven ? AppColor.yellowStar : AppColor.limeGreen,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.availabilitySchedule.length,
                            separatorBuilder: (context, index) => SizedBox(height: 10.h),
                            itemBuilder: (context, indexAV) {
                              final availData = data.availabilitySchedule[indexAV];
                              return _buildRichText('${availData.availability_day}:  ', '${availData.from_time} - ${availData.to_time}');
                            },
                          ),
                          SizedBox(height: 30.h),
                          _buildPricingSection(data, index),
                          SizedBox(height: 40.h),
                          Text(
                            data.description,
                            style: GoogleFonts.inter(
                              color: AppColor.bgColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  RichText _buildRichText(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: GoogleFonts.inter(
              color: AppColor.whiteTextColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: value,
            style: GoogleFonts.inter(
              color: AppColor.bgColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildPricingSection(UserServiceModel data, int serviceIndex) {
    // Ensure you have a unique identifier for each service, like data.serviceId
    int selectedDurationIndex = controller.selectedDurationIndexes[data.serviceId] ?? 0; // Default to 0 if not set

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Pricing:',
              style: GoogleFonts.inter(
                color: AppColor.whiteTextColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(width: 3.w),
            PopupMenuFilterInt(
              index: serviceIndex, // Use serviceIndex here
              selectedValue: selectedDurationIndex,
              onChanged: (p0) {
                // Update selected index for this service
                controller.selectedDurationIndexes[data.serviceId] = p0!;
                log(controller.selectedDurationIndexes.toString());

                // Optionally, you can update state here if needed
                setState(() {
                  selectedDurationIndex = p0;
                  controller.selectedDurationString.value = data.pricing[selectedDurationIndex].time_allocation;
                  log(controller.selectedDurationString.value);
                });
            
              },
              items: List.generate(data.pricing.length, (index) {
                return DropdownMenuItem<int>(
                  value: index, // Ensure index is unique for each item
                  child: Text(
                    data.pricing[index].time_allocation,
                    style: GoogleFonts.inter(
                      color: AppColor.bgColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PopupMenuFilterStr(
                index: serviceIndex,
                selectedValue: controller.selectedFieldIndex,
                onChanged: (p0) {
                  controller.selectedFieldIndex.value = p0!;
                  log(controller.selectedFieldIndex.value);
                },
                items: <String>['Virtual', 'In-person'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.inter(
                        color: AppColor.bgColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 5.h),
              Obx(() {
                return Text(
                  controller.selectedFieldIndex.value == 'Virtual'
                  ? data.pricing[selectedDurationIndex].virtual_pricing.isNotEmpty
                  ? "${currency(context).currencySymbol}${data.pricing[selectedDurationIndex].virtual_pricing}"
                  : "FREE"
                  : data.pricing[selectedDurationIndex].in_person_pricing.isNotEmpty
                  ? "${currency(context).currencySymbol}${data.pricing[selectedDurationIndex].in_person_pricing}"
                  : "FREE",
                  style: GoogleFonts.inter(
                    color: AppColor.bgColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                );
              }
            ),
            
            SizedBox(height: 5.h),
          
            Text(
              "for ${data.pricing[selectedDurationIndex].time_allocation} session",
              style: GoogleFonts.inter(
                color: AppColor.whiteTextColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            )
            
      
          ],
        ),
      ),
    ],
  );
}

  
}


