import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';





class RebrandedReusableButton extends StatelessWidget {
  const RebrandedReusableButton({super.key, required this.color, required this.text, required this.onPressed, required this.textColor});
  final Color color;
  final Color textColor;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      alignment: Alignment.center,
      height: 50,
      width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: color
          )
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: textColor,
              fontSize: 18,
              //fontWeight: FontWeight.w500
            )
          )
        ),
      )
    );
  }
}