import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_viewer/services/widgets/in-person_meeting.dart';

import '../widgets/virtual_meeting.dart';






class AccViewerServicesPage extends StatelessWidget {
  AccViewerServicesPage({super.key});

  var controller = Get.put(AccViewerServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(), //BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ///Header Section
              Container(
                color: AppColor.bgColor,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage('assets/images/luround_logo.png'),
                        ),
                      ]
                    ),
                    SizedBox(height: 30,),
                    Center(
                      child: Text(
                        "Services",
                        style: GoogleFonts.poppins(
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
              ///
              SizedBox(height: 20,),

              //Futurebuilder will start from here (will wrap this listview)
              ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), //external paddin
                itemCount: 8,
                separatorBuilder: (context, index) => SizedBox(height: 20,),
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
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //check if the account owner selected in-person or virtual
                              Center(child: InpersonContainer()),

                            ],
                          ),
                        ),
                        //
                        Container(
                          height: 100,
                          width: double.infinity,
                          color: AppColor.bgColor,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: ReusableButton(
                            onPressed: () {},
                            color: AppColor.mainColor,
                            text: "Book Now",
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
              
              ///
            ]
          )
        )
      )
    );
  }
}