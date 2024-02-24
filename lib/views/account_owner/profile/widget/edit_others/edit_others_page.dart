import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/profile/widget/edit_others/country_code_widget.dart';
import 'package:luround/views/account_owner/profile/widget/edit_others/custom_tap_icon.dart';
import 'package:luround/views/account_owner/profile/widget/edit_others/phone_number_textfield.dart';
import 'package:luround/views/account_owner/profile/widget/edit_others/special_widget/special.dart';
import 'package:luround/views/account_owner/profile/widget/edit_others/view_model.dart';
import '../../../../../controllers/account_owner/profile/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/reusable_button.dart';
import '../../../../../utils/components/title_text.dart';
import 'field_widget.dart';
import 'reusable_custom_textfield.dart';









class EditOthersPage extends StatefulWidget {
  EditOthersPage({super.key});

  @override
  State<EditOthersPage> createState() => _EditOthersPageState();
}

class _EditOthersPageState extends State<EditOthersPage> {

  var controller = Get.put(ProfilePageController());
  var profileService = Get.put(AccOwnerProfileService());
  void nothing() {
    print("nun fam");
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
            //Get.back();
            Get.offAll(() => MainPage());
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColor.blackColor,
          )
        ),
        title: CustomAppBarTitle(text: 'Others',),
        actions: [
          InkWell(
            onTap: () {

              //I JUST WANT TO BE SURE I'M SEEING THE OUTPUT
              for (ViewModel viewModelSet in controller.viewItems) {
                print("link: ${viewModelSet.linkController.text}");
                print("name: ${viewModelSet.name}");
                print("icon: ${viewModelSet.icon}");
              }
              ////////////
            
              profileService.updateMediaLinks(
                context: context,
                viewModelList: controller.viewItems
              ).whenComplete(() {
                controller.viewTextfields.clear();//remove(field);
                controller.viewItems.clear();
                print("textfield_list: ${controller.viewTextfields}");
                print("controller_list_length: ${controller.viewItems.length}");
                //Get.back();
                Get.offAll(() => MainPage());
              });

            },
            child: SvgPicture.asset("assets/svg/save_button.svg")
          ),
          /*SaveButton(
            onPressed: () {},
            text: 'Save',
          ),*/
          SizedBox(width: 20.w,),
        ],
      ),
      body: Obx(
        () {
          return profileService.isLoading.value ? Loader() : SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10.h),
                  Container(
                    color: AppColor.greyColor,
                    width: double.infinity,
                    height: 7.h,
                  ),
                  SizedBox(height: 30.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        //Text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Others',
                              style: GoogleFonts.inter(
                                color: AppColor.blackColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600
                              )
                            ),
                            Text(
                              'Hold field to re-order',
                              style: GoogleFonts.inter(
                                color: AppColor.yellowStar,
                                //fontWeight: FontWeight.w500,
                                fontSize: 15.sp
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 20.h,),

                        //(Reorderable)growable list that displays custom textfields that was added
                        ListView.builder(
                          //onReorder: (oldIndex, newIndex) => controller.reorderList(oldIndex, newIndex) ,
                          itemCount: controller.viewTextfields.length,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                        
                            //ViewModel controllerSet = controller.viewItems[index];
                            if(controller.viewTextfields.isEmpty) {
                              print("list is emptyyy fammm!!");
                            }
                            //return controller.viewTextfields[index];
                            return MySpecialWidget(
                              // Now displaying a Widget directly
                              leading: controller.viewTextfields[index],
                              trailing: IconButton(
                                icon: Icon(
                                  CupertinoIcons.xmark,
                                  color: AppColor.darkGreyColor
                                ),
                                onPressed: () {
                        
                                  setState(() {
                                    controller.deleteBoth(index);
                                  });
                                  
                                }
                              ),
                            );
                          }
                        ),
                        ////////////////////////////////
                        
                        SizedBox(height: 40.h),
                        Text(
                          'Tap on icon to add',
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600
                          )
                        ),

                        SizedBox(height: 40),


                        //tap an icon custom row grid here///////////////////////////
                        //1
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTapIcon(
                              svgAssetName: "assets/svg/location_icon.svg",
                              iconTitle: 'Location',
                              onTap: () {
                                
                                setState(() {
                                ViewModel viewModel = ViewModel(
                                  icon: "assets/svg/location_icon.svg",
                                  name: "Location",
                                  //index: 0, //i put the index for value key sake
                                );
      
                                //to just update widget
                                controller.addItem(
                                  BuildTextFieldWidget(
                                    icon: "assets/svg/location_icon.svg",
                                    fieldName: "Location",
                                    hintText: "Enter your location",
                                    keyboardType: TextInputType.text,
                                    textController: viewModel.linkController,
                                    controller: controller,
                                    key: ValueKey("locay"),
                                  ),
                                  viewModel
                                );
                                });
                                print(controller.viewTextfields);
                                print(controller.viewItems);
                              },
                            ),
                            //SizedBox(width: 118,), //120
                            CustomTapIcon(
                              svgAssetName: "assets/svg/call_icon.svg",
                              iconTitle: 'Mobile',
                              onTap: () {

                                setState(() {
                                ViewModel viewModel = ViewModel(
                                  icon: "assets/svg/call_icon.svg",
                                  name: "Mobile",
                                );
              
                                //to just update widget
                                controller.addItem(
                                  BuildTextFieldWidget(
                                    icon: "assets/svg/call_icon.svg",
                                    fieldName: "Mobile",
                                    hintText: "Enter your mobile number",
                                    keyboardType: TextInputType.phone,
                                    textController: viewModel.linkController,
                                    controller: controller,
                                    key: ValueKey("mobile"),
                                  ),
                                  viewModel
                                );
                                });
                                print(controller.viewTextfields);
                                print(controller.viewItems);
                            
                              },
                            ),
                            //SizedBox(width: 140,),
                            CustomTapIcon(
                              svgAssetName: "assets/svg/email_icon.svg",
                              iconTitle: 'Email',
                              onTap: () {
                                setState(() {
                                ViewModel viewModel = ViewModel(
                                  icon: "assets/svg/email_icon.svg",
                                  name: "Email",
                                );
                                //to be sent to db
                                //to just update widget
                                controller.addItem(
                                  BuildTextFieldWidget(
                                    icon: "assets/svg/email_icon.svg",
                                    fieldName: "Email",
                                    hintText: "Enter your email address",
                                    keyboardType: TextInputType.emailAddress,
                                    textController: viewModel.linkController,
                                    controller: controller,
                                    key: ValueKey("email"),
                                  ),
                                  viewModel
                                );
                                });
                                print(controller.viewTextfields);
                                print(controller.viewItems);
                              
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 60.h,),
                        //2
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomTapIcon(
                              svgAssetName: "assets/svg/site_icon.svg",
                              iconTitle: 'Website',
                              onTap: () {
                                setState(() {
                                ViewModel viewModel = ViewModel(
                                  icon: "assets/svg/site_icon.svg",
                                  name: "Website",
                                );
                                
                                //to just update widget
                                controller.addItem(
                                  BuildTextFieldWidget(
                                    icon: "assets/svg/site_icon.svg",
                                    fieldName: "Website",
                                    hintText: "Paste url to your website",
                                    keyboardType: TextInputType.url,
                                    textController: viewModel.linkController,
                                    controller: controller,
                                    key: ValueKey("web"),
                                  ),
                                  viewModel
                                );
                                });
                                print(controller.viewTextfields);
                                print(controller.viewItems);
                              },
                            ),
                            //SizedBox(width: 60,),
                            CustomTapIcon(
                              svgAssetName: "assets/svg/linkedin_icon.svg",
                              iconTitle: 'LinkedIn',
                              onTap: () {

                                setState(() {
                                ViewModel viewModel = ViewModel(
                                  icon: "assets/svg/linkedin_icon.svg",
                                  name: "LinkedIn",
                                );
                                //to be sent to db
                                //to just update widget
                                controller.addItem(
                                  BuildTextFieldWidget(
                                    icon: "assets/svg/linkedin_icon.svg",
                                    fieldName: "LinkedIn",
                                    hintText: "Paste url to your linkedIn profile",
                                    keyboardType: TextInputType.url,
                                    textController: viewModel.linkController,
                                    controller: controller,
                                    key: ValueKey("linkedIn"),
                                  ),
                                  viewModel
                                );
                                });

                                print(controller.viewTextfields);
                                print(controller.viewItems);
                              
                              },
                            ),
                            //SizedBox(width: 50,),
                            CustomTapIcon(
                              svgAssetName: "assets/svg/github.svg", //"assets/svg/facebook_icon.svg",
                              iconTitle: 'Github',
                              onTap: () {
                                setState(() {
                                ViewModel viewModel = ViewModel(
                                  icon: "assets/svg/github.svg",
                                  name: "Github",
                                );
                                //to just update widget
                                controller.addItem(
                                  BuildTextFieldWidget(
                                    icon: "assets/svg/github.svg",
                                    fieldName: "Github",
                                    hintText: "Paste url to your github profile",
                                    keyboardType: TextInputType.url,
                                    textController: viewModel.linkController,
                                    controller: controller,
                                    key: ValueKey("github"),
                                  ),
                                  viewModel
                                );
                                });
                                print(controller.viewTextfields);
                                print(controller.viewItems);
                              
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 60.h,),
                        //3
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomTapIcon(
                              svgAssetName: "assets/svg/twitter_icon.svg",
                              iconTitle: 'Twitter',
                              onTap: () {
                                setState(() {
                                ViewModel viewModel = ViewModel(
                                  icon: "assets/svg/twitter_icon.svg",
                                  name: "Twitter",
                                );
                                
                                //to just update widget
                                controller.addItem(
                                  BuildTextFieldWidget(
                                    icon: "assets/svg/twitter_icon.svg",
                                    fieldName: "Twitter",
                                    hintText: "Paste url to your twitter profile",
                                    keyboardType: TextInputType.url,
                                    textController: viewModel.linkController,
                                    controller: controller,
                                    key: ValueKey("twitter"),
                                  ),
                                  viewModel
                                );
                                });
                                print(controller.viewTextfields);
                                print(controller.viewItems);
                              },
                            ),
                            //SizedBox(width: 60,),
                            CustomTapIcon(
                              svgAssetName: "assets/svg/instagram_icon.svg",
                              iconTitle: 'Instagram',
                              onTap: () {

                                setState(() {
                                ViewModel viewModel = ViewModel(
                                  icon: "assets/svg/instagram_icon.svg",
                                  name: "Instagram",
                                );
                                //to be sent to db
                                //to just update widget
                                controller.addItem(
                                  BuildTextFieldWidget(
                                    icon: "assets/svg/instagram_icon.svg",
                                    fieldName: "Instagrm",
                                    hintText: "Paste url to your instagram profile",
                                    keyboardType: TextInputType.url,
                                    textController: viewModel.linkController,
                                    controller: controller,
                                    key: ValueKey("instagram"),
                                  ),
                                  viewModel
                                );
                                });

                                print(controller.viewTextfields);
                                print(controller.viewItems);
                              
                              },
                            ),
                            //SizedBox(width: 50,),
                            CustomTapIcon(
                              svgAssetName: "assets/svg/facebook_icon.svg", //"assets/svg/facebook_icon.svg",
                              iconTitle: 'Facebook',
                              onTap: () {
                                setState(() {
                                ViewModel viewModel = ViewModel(
                                  icon: "assets/svg/facebook_icon.svg",
                                  name: "Facebook",
                                );
                                //to just update widget
                                controller.addItem(
                                  BuildTextFieldWidget(
                                    icon: "assets/svg/facebook_icon.svg",
                                    fieldName: "Facebook",
                                    hintText: "Paste url to your facebook profile",
                                    keyboardType: TextInputType.url,
                                    textController: viewModel.linkController,
                                    controller: controller,
                                    key: ValueKey("facebook"),
                                  ),
                                  viewModel
                                );
                                });
                                print(controller.viewTextfields);
                                print(controller.viewItems);
                              
                              },
                            )
                          ],
                        ),
                        ///////////////////////////////////////////////////////
                        ///[ADD MORE ICONS IF YOU WISH]///


                        SizedBox(height: 20.h,),
                      ]
                    )
                  )
                ]
              )
            )
          );
        }
      )
    );
  }


}




//MAIN BUILD FIELD 
class BuildTextFieldWidget extends StatefulWidget {
  const BuildTextFieldWidget({
    super.key, 
    required this.controller, 

    required this.icon, 
    required this.fieldName, 
    required this.hintText, 
    required this.keyboardType, required this.textController,
  });

  final ProfilePageController controller;
  final String icon;
  final String fieldName;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController textController;

  @override
  State<BuildTextFieldWidget> createState() => _BuildTextFieldWidgetState();
}

class _BuildTextFieldWidgetState extends State<BuildTextFieldWidget> {

  //int get index => widget.index;

  @override
  Widget build(BuildContext context) {
    return CustomFieldWidget(        
      svgAssetName:  widget.icon, 
      fieldName:  widget.fieldName, 
      onCancel: () {
        /*setState(() {
          //controller.deleteItem(index);
          //controller.deleteViewModel(index);
          controller.viewItems.clear();
          controller.viewTextfields.clear();
        });*/
      }, 
      fieldWidget: ReusableTextField(
      onChanged: (val){},
      onFocusChanged: (hasFocus) {},
      hintText:  widget.hintText,
      keyboardType: widget.keyboardType,
      textController: widget.textController,
      textInputAction: TextInputAction.next,
      )
    );
  }
}