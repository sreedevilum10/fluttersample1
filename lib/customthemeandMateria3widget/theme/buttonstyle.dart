import 'package:flutter/material.dart';
import 'package:fluttersample1/customthemeandMateria3widget/theme/appcolors.dart';

class AppButtonStyle{
  static final elevatedButton = ElevatedButton.styleFrom(
    backgroundColor:  AppColors.background,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
    padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15)
  );

  static final textButton = TextButton.styleFrom(
    foregroundColor: AppColors.primaryPurple,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10)
  );


}