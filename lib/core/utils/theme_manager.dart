
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'values_manager.dart';
import 'font_manager.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
      textButtonTheme: TextButtonThemeData( ),
      scaffoldBackgroundColor: ColorManager.white,
      primaryColor: ColorManager.primary,

      //   primaryColorLight: ColorManager.primaryLight,
      disabledColor: ColorManager.grey1,
      appBarTheme: AppBarTheme(

        color: ColorManager.white,
        elevation: SizeManager.s4,
        centerTitle: true,
        titleSpacing: 1.1,
        titleTextStyle: getSemiBoldStyle
          (
          color: ColorManager.black,
          fontSize: FontSizeManager.s20,
        ),
        iconTheme:
        IconThemeData(color: ColorManager.primary, size: FontSizeManager.s30),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: ColorManager.primary, ),
      buttonTheme: ButtonThemeData(
        //  disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        height: SizeManager.s50,
        colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.primary, background: ColorManager.primary, ),

        shape: const StadiumBorder(),
        //textTheme: ButtonTextTheme.primary,
      ),
      cardTheme: CardTheme(
        color: ColorManager.white,
        elevation: SizeManager.s4,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      unselectedWidgetColor: ColorManager.grey1,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(
                  color: ColorManager.white, fontSize: FontSizeManager.s16),
              primary: ColorManager.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SizeManager.s15)))),
      inputDecorationTheme: InputDecorationTheme(
        // content padding
          contentPadding: const EdgeInsets.all(PaddingManager.p10),
          // hint style
          hintStyle:
          getRegularStyle(color: ColorManager.grey1, fontSize: FontSizeManager.s14),
          labelStyle:
          getMediumStyle(color: ColorManager.grey1, fontSize: FontSizeManager.s14),
          errorStyle: getRegularStyle(color: Colors.red),

          // enabled border style
          enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: ColorManager.grey2, width: SizeManager.s1_5),
              borderRadius: const BorderRadius.all(Radius.circular(SizeManager.s40))),

          // focused border style
          focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: ColorManager.primary, width:SizeManager.s1_5),
              borderRadius: const BorderRadius.all(Radius.circular(SizeManager.s40))),

          // error border style
          errorBorder: const OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.red, width: SizeManager.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(SizeManager.s40))
          ),
          // focused border style
          focusedErrorBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: ColorManager.primary, width: SizeManager.s1_5),
              borderRadius: const BorderRadius.all(Radius.circular(SizeManager.s40)))),
      iconTheme: IconThemeData(color: ColorManager.primary)
    // label style
  );
}
