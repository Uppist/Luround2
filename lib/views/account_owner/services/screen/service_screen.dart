import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';
import 'package:luround/views/account_owner/services/widget/add_service_stepper.dart';
import 'package:luround/views/account_owner/services/widget/edit_service_bottomsheet.dart';
import 'package:luround/views/account_viewer/services/widgets/services/in-person_meeting.dart';








class ServicesPage extends StatelessWidget {
  ServicesPage({super.key});

  var controller = Get.put(ServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor, //controller.isServicePresent.value ? AppColor.bgColor : AppColor.greyColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///Header Section
            Container(
              color: AppColor.bgColor,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage('assets/images/luround_logo.png'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => NotificationsPage());
                            },
                            child: SvgPicture.asset("assets/svg/notify_active.svg"),
                          ),
                          SizedBox(width: 20,),
                          InkWell(
                            onTap: () {
                              Get.to(() => AddServiceScreen());
                            },
                            child: SvgPicture.asset("assets/svg/add_service.svg"),
                          ),
                        ],
                      )
                    ]
                  ),
                  const SizedBox(height: 30,),
                  Center(
                    child: Text(
                      "Services",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  //SizedBox(height: 10,),
                ],
              ),
            ),         
            /////////////////
            

            const SizedBox(height: 20,),


            //Futurebuilder will start from here (will wrap this listview)
            //
            //controller.isServicePresent.value ? ServiceEmptyState(onPressed: () {  },) :
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0), //external paddin
                itemCount: 8,
                separatorBuilder: (context, index) => const SizedBox(height: 25,),
                itemBuilder: (context, index) {
                  return Container(
                    //height: 500,
                    width: double.infinity,
                    color: index.isEven ? AppColor.lightPink : AppColor.lightPurple,
                    alignment: Alignment.center,
                    //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.more_vert_rounded,
                                      color: AppColor.darkGreyColor,
                                    ),
                                    iconSize: 30,
                                    onPressed: () {
                                      editServiceDialogueBox(context: context, titleText: "Personal Training");
                                    }, 
                                  )
                                ],
                              ),
                              SizedBox(height: 20,),
                              //check if the account owner selected in-person or virtual
                              //VirtualContainer()  //InpersonContainer()
                              Center(
                                child: InpersonContainer(),
                              ),
                              const SizedBox(height: 40,),
                              Text(
                                "Personal Training",
                                style: GoogleFonts.inter(
                                  color: AppColor.blackColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              const SizedBox(height: 20,),
                              Text(
                                "Mon-Fri . 9:00AM - 10:00PM",
                                style: GoogleFonts.inter(
                                  color: AppColor.textGreyColor,
                                  fontSize: 15,
                                  //fontWeight: FontWeight.w500
                                ),
                              ),
                              const SizedBox(height: 20,),
                              Text(
                                "zgshxttttttttttttttttttttttthxgfhfcgjcfgjhgyuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuxs",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              const SizedBox(height: 20,),
                              //link 1
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset("assets/svg/link_icon.svg"),
                                    const SizedBox(width: 10,),
                                    Text(
                                      "https://www.link.com",
                                      style: GoogleFonts.inter(
                                        color: AppColor.blueColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20,),
                              //link 1
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset("assets/svg/link_icon.svg"),
                                    const SizedBox(width: 10,),
                                    Text(
                                      "https://www.link.com",
                                      style: GoogleFonts.inter(
                                        color: AppColor.blueColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30,),
                              //price/session
                              RichText(
                                text: TextSpan(
                                  children: [
                                    //price
                                    TextSpan(
                                      text: "N25,000",
                                      style: GoogleFonts.inter(
                                        color: AppColor.blackColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    //time
                                    TextSpan(
                                      text: "/30mins",
                                      style: GoogleFonts.inter(
                                        color: AppColor.darkGreyColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    //session
                                    TextSpan(
                                      text: " per session",
                                      style: GoogleFonts.inter(
                                        color: AppColor.textGreyColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500
                                      ),
                                    )
                                  ]
                                ),
                              ),
                              const SizedBox(height: 30,),
                            ]
                          )
                        )
                      ]                           
                      
                    ),
                  );
                }
              ),
            ),           
            ///
          ]
        )
      )
    );
  }
}