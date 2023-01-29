import 'package:albaraka_management/src/core/utils/color_manager.dart';
import 'package:albaraka_management/src/core/utils/font_manager.dart';
import 'package:albaraka_management/src/modules/menu/data_layer/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';

import '../../../menu/presentation_layer/components/components.dart';

class OffersScreen extends StatelessWidget
{
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
      appBar: AppBar (),
      body: Center (
        child: Column (
          children: [
         SizedBox(height: 22.sp,),
            SizedBox (
              width: double.infinity,
              height: 130.sp,
              child: Padding (
                padding:  EdgeInsets.symmetric
                  (
                    horizontal: 10.0.sp ,
                vertical: 3.sp),
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
                                                Text('10' ,
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
                                           Text ('22/5/2023',
                                             style: TextStyle( fontWeight: FontWeightManager.bold , fontSize: 11.sp ),),
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
                                   controller: TextEditingController(text: 'Albaraka22' ,),
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
            )
          ],
        ),
      ),

      );
  }
}
Widget coupon = Padding( padding: EdgeInsets.all(15.sp),
  child: Center (
      child:  Row(
        children: [

          Stack(
            children: [
              Card (
       // clipBehavior: Clip.antiAlias,
                elevation: 7,
                child: Container
                  (
                //  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration( color: ColorManager.primary,
                  // borderRadius: BorderRadius.circular(20.sp)
                  ),
                  width: 70.sp,
                  height: 70.sp,
                  child: Center(child: Text('40 %' , style:
                  TextStyle(color: ColorManager.white , fontSize: FontSizeManager.s30.sp , fontWeight: FontWeight.bold),)),
                ),
              ),
              SizedBox(
                child: CircleAvatar
                  (
                  backgroundColor: ColorManager.white,
                ),
              )
            ],
          ),
          // SizedBox(width: 10,) ,
          Expanded(
            child: SizedBox (
              height: 80.sp,
              width: double.infinity,
              child: Card (
                elevation: 7,
                child: Row (
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded (child:
                      Column
                        (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row
                            (
                            children: [
                              Text('نص الكوبون: ' , style: TextStyle( fontWeight: FontWeightManager.bold  ),) ,
                              Text('TextOfCoupon'),
                            ],
                          ),
                          Row
                            (
                            children: [
                              Text('تاريخ الصلاحية: ' , style: TextStyle( fontWeight: FontWeightManager.bold  ),) ,
                            ],

                          ),
                          Text ('23/2/2023 : 23/3/2023'  ,maxLines: 2 ,  overflow: TextOverflow.ellipsis),
                        ],
                      )
                      ),

                    ) ,

                    Expanded(child: Icon(Icons.discount_rounded))

                  ],
                ),
              ),
            ),
          ),
        ],
      )
  ),);


