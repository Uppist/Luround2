import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:luround/views/account_owner/profile/widget/edit_education/certificate_textfield.dart';
import '../../../../../controllers/account_owner/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/reusable_button.dart';
import '../../../../../utils/components/title_text.dart';
import 'education_textfield.dart';










class EditEducationPage extends StatefulWidget {
  EditEducationPage({super.key});

  @override
  State<EditEducationPage> createState() => _EditEducationPageState();
}

class _EditEducationPageState extends State<EditEducationPage> {

  //GetX dependency injection
  var profileController = Get.put(ProfilePageController());


  /////////////////////////
  
  List<Widget> textFields = []; //done
  List<TextEditingController> controllers = []; //done for certificate naems (save to db)
  List<List<TextEditingController>> subListControllersList = [];  //done for subfields (save to db)


  //List<TextEditingController> subListControllers = []; //done
  List<String> certificateHints = [
    "Issuing organization",
    "Issue date",
    "Expiration date",
    "Certificate ID",
    "Certificate URL",
  ];  //done
  List<TextInputType> textInputTypes = [
    TextInputType.text,
    TextInputType.datetime,
    TextInputType.datetime,
    TextInputType.number,
    TextInputType.url
  ];  //done
  



  ///to get all the values from the text controller (will work with this for integration)
  List<String> getControllerValues() {
    List<String> controllerValues = [];
    for (TextEditingController controller in controllers) {
      controllerValues.add(controller.text);
    }
    return controllerValues;
  }

  //for mainfield list
  

  
  //for sublist
  void extractTextValues() {
    for (int i = 0; i < subListControllersList.length; i++) {
      List<TextEditingController> controllers = subListControllersList[i];
      for (int j = 0; j < controllers.length; j++) {
        String text = controllers[j].text;
        print('Item $i, Field $j: $text');
        // You can do something with the extracted text, such as storing it in a list or performing any desired action.
      }
    }
  }
  
  //for sublist
  void clearTextValues() {
    for (int i = 0; i < subListControllersList.length; i++) {
      List<TextEditingController> controllers = subListControllersList[i];
      for (int j = 0; j < controllers.length; j++) {
        controllers[j].clear();
      }
    }
  }
  

  //for sublist
  void disposeControllers() {
    for (int i = 0; i < subListControllersList.length; i++) {
      List<TextEditingController> controllers = subListControllersList[i];
      for (int j = 0; j < controllers.length; j++) {
        controllers[j].dispose();
      }
    }
  }






  @override
  void dispose() {
    disposeControllers();

    super.dispose();
  }

  /////////////////////////////////////////////////////

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
        title: CustomAppBarTitle(text: 'Education & Certifications',),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7,
            ),
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Education & Certification',
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  InkWell(
                    onTap: () {
                      if (textFields.length < 20) {

                        if (subListControllersList.length <= textFields.length) {
                          subListControllersList.add(
                            List<TextEditingController>.generate(
                              5,(i) => TextEditingController(),
                            )
                          );
                          /////////////////////////
                          TextEditingController controller = TextEditingController(); 
                          //add a textController to the list of MainTextControllers
                          controllers.add(controller);
                          //add widget below to the list of textfields (very important)
                          textFields.add(
                            Column(
                              children: [
                                //
                                EducationTextField(
                                  onChanged: (val) {},
                                  controller: controllers[textFields.length],
                                  hintText: 'Certificate name',  //List<String>
                                  keyboardType: TextInputType.text, 
                                  textInputAction: TextInputAction.done,                      
                                ),
                                //
                              ],
                            ),
                          );
                          //log the values to keep track of them in the console
                          print("number_of_fields: ${textFields.length}");
                          print("number of mainControllers: ${controllers.length}");
                          setState(() {});
                          ////////////////////////
                        }
                      }
                      if (textFields.length >= 20) {
                        return LuroundSnackBar.errorSnackBar(message: "Maximum numbers of fields is ${textFields.length}");
                      }                   
                    },
                    child: SvgPicture.asset("assets/svg/add_icon.svg"),
                  ),
                ],
              ),
            ),
            
            //growable list that displays textfields that was added
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: textFields.length, //certified (working)
                itemBuilder: (context, index) {  //certified (working)
                  return ExpansionTile(
                    title: textFields[index],
                    leading: IconButton(
                      icon: Icon(Icons.delete_outline_rounded),
                      iconSize: 20,
                      color: AppColor.blackColor,
                      onPressed: () {
                        subListControllersList.removeAt(index);
                        textFields.removeAt(index);
                        setState(() {}); 
                      },
                    ),
                    iconColor: AppColor.blackColor,
                    collapsedIconColor: AppColor.blackColor,
                    controlAffinity: ListTileControlAffinity.trailing,
                    expandedCrossAxisAlignment: CrossAxisAlignment.center,
                    backgroundColor: AppColor.bgColor, // Set the background color to white
                    childrenPadding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                    children: List.generate(5, (i) {
                      return CertificationTextField(
                        onFocusChange: (hasFocus) {},
                        onChanged: (val) {},
                        textController: subListControllersList[index][i], //list of lists "[index][i]"
                        hintText: certificateHints[i],  // List<String>, index = i
                        keyboardType: textInputTypes[i], // List<TextInputType>, index = i
                        textInputAction: TextInputAction.next,
                      );
                    }),
                    onExpansionChanged: (bool isExpanded) {
                      // Add your code here to handle expansion changes
                      if (isExpanded) {
                        // The ExpansionTile was expanded
                        print("The ExpansionTile has expanded");
                      } else {
                        // The ExpansionTile was collapsed
                        print("The ExpansionTile has collapsed");
                      }
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 30,),  //500
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ReusableButton(
                color: AppColor.mainColor,
                text: 'Save',
                onPressed: () {},
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      )
    );
  }
}