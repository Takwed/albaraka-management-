import 'package:albaraka_management/src/core/utils/navigation_manager.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/discount.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:albaraka_management/src/core/utils/color_manager.dart';
import 'package:albaraka_management/src/core/utils/font_manager.dart';
import '../../../menu/data_layer/models/product_model.dart';
import '../../domain_layer/entities/coupon.dart';
import '../bloc/offers_bloc.dart';


Widget couponBuilder({required Coupon coupon}) {
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

Widget offerItemBuilder(ProductModel product, context, index , OffersBloc bloc , bool containOffer ,    )
{
  return BlocBuilder<OffersBloc, OffersState>(
    builder: (context, state) {
      return InkWell(
        onLongPress: () {
          if (containOffer) {
            showDialog
              (
                context: context,
                builder: (BuildContext context) {
                  return BlocBuilder<OffersBloc, OffersState>(
                      builder: (context, state) {
                        return AlertDialog(
                          content:
                              const Text(
                              "سيتم حذف هذا العرض "),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("الغاء")),
                            TextButton(
                                onPressed: () {
                                  if (bloc.tabIndex == 0) {
                                        bloc.add(RemoveOfferEvent(id: index, productModel: product, collectionIndex: 0));
                                  }
                                  else if (bloc.tabIndex == 1) {
                                    bloc.add(RemoveOfferEvent(id: index, productModel: product, collectionIndex: 1));
                                  } else if (bloc.tabIndex == 2) {
                                    bloc.add(RemoveOfferEvent(id: index, productModel: product, collectionIndex: 2));
                                  }
                                  Navigator.pop(context);
                                },
                                child: const Text("تأكيد")),
                          ],
                        );
                      });
                });
          }
        },
        onTap: () {
          if (!containOffer) {
            int typeIndex = bloc.selectedOfferTypeIndex;
            showDialog(context: context, builder: (context){
              return BlocBuilder<OffersBloc, OffersState>(
  builder: (context, state) {
    return AlertDialog( content: Text('نوع العرض', style: TextStyle(
                 fontWeight: FontWeightManager.bold,
              ),
              textAlign: TextAlign.center,
              ),
                actions: [
                   Center(child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Expanded(child: MaterialButton(onPressed: (){
                         bloc.add(ChangeOfferTypeEvent(index: 0));
                         typeIndex = bloc.selectedOfferTypeIndex;
                         print(typeIndex);
                         print(bloc.selectedOfferTypeIndex);
                       },color: bloc.selectedOfferTypeIndex == 0
                           ? ColorManager.primary : ColorManager.white, child: Text('خصم' ,
                         style: TextStyle(color:  bloc.selectedOfferTypeIndex ==0 ? ColorManager.white : ColorManager.black


                       ),) ),),
                       Expanded(child: MaterialButton(onPressed: ()
                       {
                         bloc.add(ChangeOfferTypeEvent(index: 1 ));
                         typeIndex = bloc.selectedOfferTypeIndex;
                         print(typeIndex);
                         print(bloc.selectedOfferTypeIndex);

                       }, child: Text('هدية' ,
                           style: TextStyle(
                               color:  bloc.selectedOfferTypeIndex == 1
                                   ? ColorManager.white : ColorManager.black

                           )),
                           color: bloc.selectedOfferTypeIndex ==1
                               ? ColorManager.primary : ColorManager.white
                       )),
                     ],

                   )),
                  MaterialButton(onPressed: (){
                    if (bloc.selectedOfferTypeIndex ==0) {
NavigationManager.pop(context);
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          content: Text('قبل الخصم : 100 جنيه', style: TextStyle (
                              fontWeight: FontWeightManager.bold,
                              fontSize: 17.sp
                          ),
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                        //    Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text('السعر بعد الخصم  ', style: TextStyle (
                        //       fontWeight: FontWeightManager.bold,
                        //     ),
                        //       textAlign: TextAlign.center,
                        //     ),
                        //     SizedBox (
                        //         height: 25.sp,
                        //         width: 15.w,
                        //         child: Text('100')
                        //     ),
                        //
                        //   ],
                        // ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('قيمة الخصم', style: TextStyle (
                                    fontSize: 17.sp
                                  ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding:  EdgeInsetsDirectional.only(start: 20.sp),
                                    child: SizedBox (
                                        height: 25.sp,
                                      width: 15.w,
                                        child: TextField()),
                                  ),
                                  Text(' % ' , style: TextStyle (
                                      fontWeight: FontWeightManager.bold,
                                      fontSize: 18.sp
                                  ),)

                                ],
                              ),
                            )
                            , Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('السعر بعد الخصم:', style: TextStyle (
                                   // fontWeight: FontWeightManager.bold,
                                    fontSize: 16.sp
                                ),
                                  textAlign: TextAlign.center,
                                ),
                                Spacer(),
                                SizedBox (
                                    height: 25.sp,
                                    width: 20.w,
                                    child: TextField(
                                      decoration: InputDecoration(border: InputBorder.none),
                                    )

                                ),


                              ],
                            ),
                            // Row( children: [
                            //   Expanded(child: Text('الخصم')),
                            //   TextField()
                            // ]),
                            // Row(),
                            MaterialButton(onPressed: (){}, child:   Text('تأكيد', style: TextStyle(color: ColorManager.white),),
                            color: ColorManager.primary,)
                          ],
                        ) ;
                      });
                    }
                    else {
                      NavigationManager.pop(context);
                    }
                    
                  }, child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('التالي'),
                      Icon(Icons.arrow_forward)
                    ],
                  ),),
                ],
              );
  },
);

            });
          }

        },
        child: Card(
          elevation: 7,
          color: ColorManager.card,
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: const BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(8),
                      bottomStart: Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 105.sp,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorManager.card,
                        image: product.image == ''
                            ? null
                            : DecorationImage(
                          image: NetworkImage(
                            product.image!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      child: Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: ColorManager.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 17.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                      ),
                      child: Text(
                        "${product.oldPrice}\$",
                        style: TextStyle(
                            color: ColorManager.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      );
    },
  );
}
