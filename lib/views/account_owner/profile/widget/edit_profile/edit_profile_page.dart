import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../controllers/account_owner/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/reusable_button.dart';
import '../../../../../utils/components/title_text.dart';
import 'edit_photo_dialogue_box.dart';
import 'name_textfield.dart';
import 'occupation_textfield.dart';









class EditPhotoPage extends StatelessWidget {
  EditPhotoPage({super.key});

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
        title: CustomAppBarTitle(text: 'Edit Photo & Intro',),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7,
              ),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //User Photo
                    Container(
                      alignment: Alignment.bottomRight,
                      height: 300,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: controller.isEmpty ? AppColor.emptyPic : AppColor.greyColor,
                        image: DecorationImage(
                          image: AssetImage('assets/images/man_pics.png'),  //controller.isEmpty ? AssetImage('assets/images/empty_pic.png',)
                          fit: BoxFit.cover
                        )
                      ),
                      child: InkWell(
                        onTap: () {
                          editPhotoDialogueBox(context: context);
                        },
                        child: SvgPicture.asset("assets/svg/edit_photo_icon.svg"),
                      )
                    ),
                    SizedBox(height: 40,),
                    //Personal Details
                    Text(
                      'Personal Details',
                      style: GoogleFonts.poppins(
                        color: AppColor.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    SizedBox(height: 20,),
                    //name textfield
                    NameTextField(
                      onChanged: (val) {},
                      controller: controller.nameController,
                      hintText: 'Enter your name',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 10,),
                    OccupationTextField(
                      onChanged: (val) {},
                      controller: controller.occupationController,
                      hintText: 'What do you do ?',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 200,),  //160
                    ReusableButton(
                      color: AppColor.mainColor,
                      text: 'Save',
                      onPressed: () {},
                    ),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            ]
          )
        )
      )
    );
  }
}