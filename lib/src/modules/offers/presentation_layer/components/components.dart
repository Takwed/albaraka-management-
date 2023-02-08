import 'package:albaraka_management/src/core/utils/navigation_manager.dart';
import 'package:albaraka_management/src/modules/authenticaion/presentation_layer/components/components.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/discount.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/free_product.dart';
import 'package:bloc/bloc.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:albaraka_management/src/core/utils/color_manager.dart';
import 'package:albaraka_management/src/core/utils/font_manager.dart';
import '../../../menu/data_layer/models/product_model.dart';
import '../../domain_layer/entities/coupon.dart';
import '../bloc/offers_bloc.dart';

Widget couponBuilder({required Coupon coupon , required context , required OffersBloc bloc}) {
  return InkWell(
    onLongPress: ()
    {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return BlocBuilder<OffersBloc, OffersState>(
                builder: (context, state) {
                  return AlertDialog(
                    content: const Text("سيتم حذف هذا الكوبون "),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("الغاء")),
                      TextButton(
                          onPressed: () {
                             bloc.add(RemoveCouponEvent(coupon.text));
                            Navigator.pop(context);
                          },
                          child: const Text("تأكيد")),
                    ],
                  );
                });
          });
    },
    child: SizedBox(
      width: double.infinity,
      height: 20.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.sp, vertical: 3.sp),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: ColorManager.white,
          elevation: 7,
          child: Column(
            children: [
              SizedBox(
                height: 3.sp,
              ),
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: const AssetImage('assets/images/logo.svg'),
                      radius: 15.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(.50),
                      child: SizedBox(
                        width: 1,
                        height: double.infinity,
                        child: SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'البركــة',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeightManager.bold),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'كود خصم',
                                  style: TextStyle(
                                      fontWeight: FontWeightManager.bold,
                                      fontSize: 11.sp),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '%',
                                      style: TextStyle(
                                          fontWeight: FontWeightManager.maxWeight,
                                          fontSize: 12.sp,
                                          color: ColorManager.error),
                                    ),
                                    Text(
                                      '${coupon.discount}',
                                      style: TextStyle(
                                          fontWeight: FontWeightManager.maxWeight,
                                          fontSize: 20.sp,
                                          color: ColorManager.error),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'صالح حتى:',
                                  style: TextStyle(
                                      fontWeight: FontWeightManager.bold,
                                      fontSize: 11.sp),
                                ),
                                Text(
                                  '${coupon.date}',
                                  style: TextStyle(
                                      fontWeight: FontWeightManager.bold,
                                      fontSize: 11.sp),
                                ),
                              ],
                            ),
                            Padding (
                              padding:  EdgeInsetsDirectional.only(end: 10.sp),
                              child: Align(
                                alignment: AlignmentDirectional.bottomCenter,
                                child: SizedBox (
                                  width: 90.w,
                                  height: 30.sp,
                                  child: InkWell(
                                    onLongPress: (){
                                      FlutterClipboard.copy(coupon.text).then((value) {
                                        defaultToast(msg: 'تم النسخ الى الحافظة');
                                      });
                                    },
                                    child: TextField(
                                      enableInteractiveSelection: false,
                                      decoration: InputDecoration(

                                        prefix: IconButton (

                                          onPressed: () {
                                            FlutterClipboard.copy(coupon.text).then((value) {
                                              defaultToast(msg: 'تم النسخ الى الحافظة');
                                            });
                                          },
                                          icon: Icon(
                                            Icons.copy,
                                            size: 15.sp,
                                          ),
                                        ),
                                        enabled: false,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          gapPadding: 0,
                                        ),
                                      ),
                                      maxLines: 1,
                                      style: const TextStyle(fontWeight: FontWeightManager.bold),
                                      enabled: false,
                                      readOnly: true,
                                      controller: TextEditingController(
                                        text: '${coupon.text}',
                                      ),
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    ),
  );
}
/*

 */
Widget offerItemBuilder(ProductModel product, context, index, OffersBloc bloc,
    bool containOffer, collectionIndex) {
  return BlocBuilder<OffersBloc, OffersState>(
    builder: (context, state) {
      return InkWell(
        onLongPress: () {
          if (containOffer) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BlocBuilder<OffersBloc, OffersState>(
                      builder: (context, state) {
                    return AlertDialog(
                      content: const Text("سيتم حذف هذا العرض "),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("الغاء")),
                        TextButton(
                            onPressed: () {
                              if (bloc.tabIndex == 0) {
                                bloc.add(RemoveOfferEvent(
                                    id: index,
                                    productModel: product,
                                    collectionIndex: 0));
                              } else if (bloc.tabIndex == 1) {
                                bloc.add(RemoveOfferEvent(
                                    id: index,
                                    productModel: product,
                                    collectionIndex: 1));
                              } else if (bloc.tabIndex == 2) {
                                bloc.add(RemoveOfferEvent(
                                    id: index,
                                    productModel: product,
                                    collectionIndex: 2));
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
            showDialog(
                context: context,
                builder: (context) {
                  return BlocBuilder<OffersBloc, OffersState>(
                    builder: (context, state) {
                      return AlertDialog(
                        content: const Text(
                          'نوع العرض',
                          style: TextStyle(
                            fontWeight: FontWeightManager.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: MaterialButton(
                                    onPressed: () {
                                      bloc.add(ChangeOfferTypeEvent(index: 0));
                                      typeIndex = bloc.selectedOfferTypeIndex;
                                      print(typeIndex);
                                      print(bloc.selectedOfferTypeIndex);
                                    },
                                    color: bloc.selectedOfferTypeIndex == 0
                                        ? ColorManager.primary
                                        : ColorManager.white,
                                    child: Text(
                                      'خصم',
                                      style: TextStyle(
                                          color:
                                              bloc.selectedOfferTypeIndex == 0
                                                  ? ColorManager.white
                                                  : ColorManager.black),
                                    )),
                              ),
                              Expanded(
                                  child: MaterialButton(
                                      onPressed: () {
                                        bloc.add(
                                            ChangeOfferTypeEvent(index: 1));
                                        typeIndex = bloc.selectedOfferTypeIndex;
                                        print(typeIndex);
                                        print(bloc.selectedOfferTypeIndex);
                                      },
                                      child: Text('هدية',
                                          style: TextStyle(
                                              color:
                                                  bloc.selectedOfferTypeIndex ==
                                                          1
                                                      ? ColorManager.white
                                                      : ColorManager.black)),
                                      color: bloc.selectedOfferTypeIndex == 1
                                          ? ColorManager.primary
                                          : ColorManager.white)),
                            ],
                          )),
                          MaterialButton(
                            onPressed: () {

                                NavigationManager.pop(context);
                                showOfferDialog(
                                  context: context,
                                  bloc: bloc,
                                  collectionIndex: collectionIndex,
                                  product: product,
                                  id: index,
                                  offerType: bloc.selectedOfferTypeIndex
                                );

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('التالي'),
                                const Icon(Icons.arrow_forward)
                              ],
                            ),
                          ),
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
                    Expanded(
                      child: Padding(
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
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.sp,
                        ),
                        child: Text(
                          "${product.newPrice} ج.م",
                          maxLines: 2,
                          style: TextStyle(
                              color: ColorManager.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             product.offerState != null ? Align(
               alignment: AlignmentDirectional.topStart,
               child: Container(
                decoration: BoxDecoration(  color:  ColorManager.error,
                borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(10.sp) , bottomEnd: Radius.circular(10.sp) )),
                  child: Text('  ${product.offerState}  ' , style: TextStyle(color: ColorManager.white)),
                ),
             ) : const SizedBox()
            ],
          ),
        ),
      );
    },
  );
}

showOfferDialog(
    {required context,
    required ProductModel product,
    required OffersBloc bloc,
    required int id,
    required int collectionIndex , 
  required  int offerType }) {
switch (offerType) {
  case 0 : {
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController discountController = TextEditingController();

          TextEditingController newPriceController = TextEditingController();
          return AlertDialog(
            content: Text(
              'قبل الخصم : ${product.oldPrice} جنيه',
              style:
              TextStyle(fontWeight: FontWeightManager.bold, fontSize: 17.sp),
              textAlign: TextAlign.center,
            ),
            actions: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'قيمة الخصم',
                      style: TextStyle(fontSize: 17.sp),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    SizedBox(
                        height: 25.sp,
                        width: 15.w,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            newPriceController.text = (product.oldPrice -
                                (product.oldPrice *
                                    double.parse(value) /
                                    100))
                                .toString();
                          },
                          controller: discountController,
                        )),
                    Text(
                      ' % ',
                      style: TextStyle(
                          fontWeight: FontWeightManager.bold, fontSize: 18.sp),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'السعر بعد الخصم',
                    style: TextStyle(fontSize: 17.sp),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 20.sp),
                    child: SizedBox(
                        height: 25.sp,
                        width: 15.w,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: newPriceController,
                          onChanged: (value) {
                            discountController.text = ((-100 *
                                (double.parse(value) -
                                    product.oldPrice)) /
                                product.oldPrice)
                                .toString();
                          },
                        )),
                  ),
                  Text(
                    'ج.م',
                    style: TextStyle(
                        fontWeight: FontWeightManager.bold, fontSize: 16.sp),
                  )
                ],
              ),
              bloc.state is! AddDiscountLoadingState
                  ? MaterialButton(
                onPressed: () {

                  Discount discount = Discount(
                      discount: double.parse(discountController.text).toInt(),
                      productModel: product,
                      state: discountController.text + ' % ');
                  bloc.add(AddDiscountEvent(
                      discount: discount,
                      id: id,
                      collectionIndex: collectionIndex));
                  print (bloc.state);
                  if (bloc.state is AddDiscountSuccessState)
                    NavigationManager.pop(context);
                },
                child: Text(
                  'تأكيد',
                  style: TextStyle(color: ColorManager.white),
                ),
                color: ColorManager.primary,
              )
                  : const CircularProgressIndicator()
            ],
          );
        });
    break;
  } 
  case 1 : {
    showDialog(context: context, builder: (context) {
      TextEditingController quantityController = TextEditingController();
       TextEditingController giftController = TextEditingController();
      return AlertDialog (
        title: const Text('اضافة هدية'),
     //   alignment: AlignmentDirectional.centerStart,
        actions: [

          Row (
            mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text (
                'الكمية',
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeightManager.bold),
                textAlign: TextAlign.center,
              ),
              
              Padding(
                padding:  EdgeInsets.all(10.sp),
                child: SizedBox
                  (
                    height: 30.sp,
                    width: 15.w,
                    child: TextField(
                      maxLines: 1,
                      decoration: const InputDecoration(border: OutlineInputBorder(

                      ),


                      ),

                      keyboardType: TextInputType.number,
                      controller : quantityController,
                    )),
              ),
           
            ],
          ) ,
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'الهدية',
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeightManager.bold),
                textAlign: TextAlign.center,
              ),

              Expanded (
                child: Padding(
                  padding:  EdgeInsets.all(10.sp),
                  child: SizedBox
                    (
                      height: 30.sp,

                      child: TextField(
                        decoration: const InputDecoration(border: OutlineInputBorder(

                        ),
                          //      hintText: 'الكمية المطلوبة للحصول على الهدية '

                        ),

                        keyboardType: TextInputType.text,
                        controller : giftController,
                      )),
                ),
              ),

            ],
          ) ,
          MaterialButton (
            onPressed: () {
                 FreeProduct freeProduct = FreeProduct(product: product, quantity: int.parse(quantityController.text),
                     state: '',
                     offerDetails: giftController.text);
                 bloc.add(AddFreeProductEvent(id: id, freeProduct: freeProduct, collectionIndex: collectionIndex));
                 if (bloc.state is AddFreeProductSuccessState)
                   NavigationManager.pop(context);
            },
            child: Text(
              'تأكيد',
              style: TextStyle(color: ColorManager.white),
            ),
            color: ColorManager.primary,
          )
        ],
      );
    }) ;
  }
}
}
Widget old =    Card (
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

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Row(
                  children: [
                    // IconButton (onPressed: (){}, icon: Icon(Icons.copy) ,),
                    Expanded(
                      child: Text(
                        ' }',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: ColorManager.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 17.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.sp,
                ),
                child: Row(
                  children: [
                    Icon(Icons.watch_later_outlined) ,
                    Expanded(

                      child: Text(
                        " }",
                        maxLines: 2,
                        style: TextStyle(
                            color: ColorManager.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    ],
  ),
);
/*
   Card (
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
                      child:      Center(
                        child: Row (
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '%',
                              style: TextStyle(
                                  fontWeight: FontWeightManager.maxWeight,
                                  fontSize: 16.sp,
                                  color: ColorManager.error),
                            ),
                            Text(
                              '${coupon.discount}',
                              style: TextStyle(
                                  fontWeight: FontWeightManager.maxWeight,
                                  fontSize: 30.sp,
                                  color: ColorManager.error),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.white,

                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Row(
                          children: [
                            // IconButton (onPressed: (){}, icon: Icon(Icons.copy) ,),
                            Expanded(
                              child: Text(
                                ' ${coupon.text}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: ColorManager.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.sp,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.watch_later_outlined) ,
                            Expanded(

                              child: Text(
                                " ${coupon.date}",
                                maxLines: 2,
                                style: TextStyle(
                                    color: ColorManager.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        )
 */