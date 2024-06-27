import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/services/user_services_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/bookings/widget/search_textfield.dart';
import 'package:luround/views/account_owner/services/screen/service_empty_state.dart';
import 'package:luround/views/account_owner/services/widget/event/add_event/screen/add_event_screen.dart';
import 'package:luround/views/account_owner/services/widget/event/edit_event/screen/edit_event_bottomsheet.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/popup_menu/popup_menu.dart';







class EventServiceList extends StatefulWidget {
  const EventServiceList({super.key});

  @override
  State<EventServiceList> createState() => _EventServiceListState();
}

class _EventServiceListState extends State<EventServiceList> {
  final controller = Get.put(ProgramServiceController());
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
      List<UserServiceModel> data = await userService.getUserEventServices();
      userService.filterEventsList.clear();
      userService.filterEventsList.addAll(data);
    } catch (error) {
      log("Error fetching data: $error");
      //controller.setError(true);
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
              userService.filterEventServices(val);          
            },
            hintText: "Search",
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            textController: userService.searchEventController,
            onTap: () {},
          ),
        ),
        //SizedBox(height: 20.h,),
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
              /*return ServiceEmptyState(
                onPressed: () {
                  Get.to(() => const AddEventScreen());
                },
              );*/
            }
            if (userService.filterEventsList.isEmpty) {
              return ServiceEmptyState(
                onPressed: () {
                  Get.to(() => const AddEventScreen());
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
                  itemCount: userService.filterEventsList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 25.h),
                  itemBuilder: (context, index) {
                    final data = userService.filterEventsList[index];
              
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
                                  editEventDialogueBox(
                                    serviceLink: data.serviceLink,
                                    service_status: data.serviceStatus,
                                    service: userService,
                                    context: context,
                                    userId: data.serviceProviderDetails.userId,
                                    email: data.serviceProviderDetails.email,
                                    displayName: data.serviceProviderDetails.displayName,
                                    serviceId: data.serviceId,
                                    service_name: data.serviceName,
                                    description: data.description,
                                    meetingLink: data.virtualMeetingLink,
                                    location: data.physicalLocationAddress,
                                    inPersonFee: data.serviceChargeInPerson,
                                    virtualFee: data.serviceChargeVirtual,
                                    service_charge_in_person: data.serviceChargeInPerson,
                                    service_charge_virtual: data.serviceChargeVirtual,
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
                          _buildRichText('Service type: ', data.serviceType.capitalizeFirst!),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              data.eventType == "Single date"
                                  ? _buildSingleDateEvent(data, index)
                                  : _buildMultipleDateEvent(data, index),
                              _buildPricingSection(data, index),
                            ],
                          ),
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

  Widget _buildSingleDateEvent(UserServiceModel data, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Event schedule",
          style: GoogleFonts.inter(
            color: index.isEven ? AppColor.yellowStar : AppColor.limeGreen,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          data.date,
          style: GoogleFonts.inter(
            color: AppColor.bgColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        _buildRichText('Start time: ', data.startTime),
        SizedBox(height: 5.h),
        _buildRichText('Stop time: ', data.endTime),
      ],
    );
  }

  Widget _buildMultipleDateEvent(UserServiceModel data, int index) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Event schedule",
            style: GoogleFonts.inter(
              color: index.isEven ? AppColor.yellowStar : AppColor.limeGreen,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.h),
          ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.eventSchedule.length,
            separatorBuilder: (context, index) => SizedBox(height: 10.h),
            itemBuilder: (context, indexES) {
              final eventData = data.eventSchedule[indexES];
              return _buildRichText('${eventData.date}: ', '${eventData.time} - ${eventData.end_time}');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection(UserServiceModel data, int index) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        PopupMenuFilterStr(
          index: index,
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
                ? data.serviceChargeVirtual.isNotEmpty
                    ? currency(context).currencySymbol + data.serviceChargeVirtual
                    : "Unavailable"
                : data.serviceChargeInPerson.isNotEmpty
                    ? currency(context).currencySymbol + data.serviceChargeInPerson
                    : "Unavailable",
            style: GoogleFonts.inter(
              color: AppColor.bgColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          );
        }),
      ],
    );
  }
}


