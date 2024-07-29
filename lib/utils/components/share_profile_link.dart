import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';




Future<ShareResult> shareProfileLink({required String link}) async{

  final result = await Share.share("Please View And Book My Services On Luround Here\n\n$link"); 
  //shareUri(Uri.parse(link));  //('Check out my Luround profile. 😊\n$link');
  //print(result");
  return result;

}


Future<ShareResult> shareServiceLink({required String link}) async{

  final result = await Share.share("Please View And Book My Service On Luround Here\n\n$link"); 
  //shareUri(Uri.parse(link));  //('Check out my Luround profile. 😊\n$link');
  //print(result");
  return result;

}