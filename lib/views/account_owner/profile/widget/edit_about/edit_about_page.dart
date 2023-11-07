import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../controllers/account_owner/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/reusable_button.dart';
import '../../../../../utils/components/title_text.dart';
import 'about_textfield.dart';









class EditAboutPage extends StatefulWidget {
  EditAboutPage({super.key});

  @override
  State<EditAboutPage> createState() => _EditAboutPageState();
}

class _EditAboutPageState extends State<EditAboutPage> {
  var controller = Get.put(ProfilePageController());

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
        title: CustomAppBarTitle(text: 'Edit About',),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7,
            ),
            SizedBox(height: 20,),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //About
                      Text(
                        'About',
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      SizedBox(height: 30),
                      AboutTextField(
                        onChanged: (val) {
                          // Check if character count exceeds the maximum
                          if (val.length > controller.maxLength) {
                            // Remove extra characters       
                            controller.aboutController.text = val.substring(0, controller.maxLength);
                            debugPrint("you have reached max length");
                          } 
                          setState(() {}); // Update the UI
                        },
                        //initial value is the one causing it
                        //initialValue: controller.aboutController.text,
                        controller: controller.aboutController, 
                        hintText: 'Enter a brief summary of your experience, skills and achievements',
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,                   
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${controller.aboutController.text.length}/${controller.maxLength}',
                            style: GoogleFonts.poppins(
                              color: AppColor.textGreyColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,),  //250
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ReusableButton(
                color: AppColor.mainColor,
                text: 'Save',
                onPressed: () {},
              ),
            ),
            SizedBox(height: 20,),
          ]
        )
      )
    );
  }
}