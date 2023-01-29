import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:albaraka_management/src/core/utils/color_manager.dart';
import 'package:albaraka_management/src/core/utils/font_manager.dart';
import '../../domain_layer/entities/coupon.dart';


Widget couponBuilder({required Coupon coupon})
{
  return SizedBox (
    width: double.infinity,
    height: 130.sp,
    child: Padding (
      padding:  EdgeInsets.symmetric
        (
          horizontal: 10.0.sp ,
          vertical: 3.sp
      ),
      child: Card (
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: ColorManager.grey1,
        elevation: 7,
        child: Column
          (
          children: [
            SizedBox(height: 3.sp,),
            Expanded (
              child: Row (
                children: [
                  CircleAvatar(
                    backgroundImage:AssetImage('assets/images/logo.svg') ,
                    radius: 15.w,
                  ),
                  Padding (
                    padding: const EdgeInsets.all(.50),
                    child: SizedBox (
                      width: 1,
                      height: double.infinity,
                      child: ListView.separated(itemBuilder: (context , index) =>
                          Container (
                            height: 4.sp,
                            width: 1,
                            color: ColorManager.black,
                          ), separatorBuilder: ( context  , index)=> Container(
                        height: 1.sp,
                        color: ColorManager.white,
                      ), itemCount: 100),

                    ),
                  ) ,
                  SizedBox(width: 10.sp,),
                  Expanded(child: Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('البركــة' , style: TextStyle(fontSize: 13.sp ,
                          fontWeight: FontWeightManager.bold),)
                      ,Row (
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:
                        [
                          Text('كود خصم',style: TextStyle(fontWeight:
                          FontWeightManager.bold, fontSize: 11.sp),),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('%' ,
                                style: TextStyle( fontWeight: FontWeightManager.maxWeight ,
                                    fontSize: 12.sp, color: ColorManager.error ),),
                              Text('${coupon.discount}' ,
                                style: TextStyle( fontWeight: FontWeightManager.maxWeight ,
                                    fontSize: 20.sp, color: ColorManager.error ),),
                            ],
                          ),
                        ],
                      )
                      ,
                      Row(
                        children: [
                          Text ('صالح حتى:' , style: TextStyle( fontWeight:
                          FontWeightManager.bold , fontSize: 11.sp ),),
                          Text ('${coupon.date}',
                            style: TextStyle( fontWeight: FontWeightManager.bold ,
                                fontSize: 11.sp ),),
                        ],
                      ) ,

                    ],
                  )),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: SizedBox (
                width: 90.w,
                height: 30.sp,
                child: TextField (
                  decoration: InputDecoration
                    (
                    suffix: IconButton(onPressed: () {
                    },
                      icon: Icon(Icons.copy, size: 15.sp,),),
                    enabled: false,
                    border: OutlineInputBorder (
                      borderRadius: BorderRadius.circular(5),
                      gapPadding: 0,
                    ),



                  ),
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeightManager.bold),
                  enabled: true,
                  readOnly: true,
                  controller: TextEditingController(text: '${coupon.text}' ,),
                  textDirection: TextDirection.ltr,
                ),
              ),
            ) ,
            SizedBox (
              height: 5.sp,
            )
          ],
        ),
      ),
    ),
  ) ;
}