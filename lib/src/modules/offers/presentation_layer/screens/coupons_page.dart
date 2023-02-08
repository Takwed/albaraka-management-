import 'package:albaraka_management/src/core/utils/font_manager.dart';
import 'package:albaraka_management/src/modules/offers/data_layer/models/coupon_model.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/coupon.dart';
import 'package:albaraka_management/src/modules/offers/presentation_layer/bloc/offers_bloc.dart';
import 'package:albaraka_management/src/modules/offers/presentation_layer/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:date_time/date_time.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/navigation_manager.dart';

class CouponsScreen extends StatelessWidget {
  OffersBloc bloc;

  CouponsScreen({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    bloc.add(GetCouponsEvent());

    List<Coupon> coupons = bloc.coupons;
    TextEditingController textController = TextEditingController();
    TextEditingController discountController = TextEditingController();
    TextEditingController dateController = TextEditingController();
   late Date date  ;
    return BlocBuilder<OffersBloc, OffersState>(
      buildWhen: (context, state) {
       return (coupons != bloc.coupons || bloc.state is GetCouponsSuccessState);
      },
      bloc: bloc..add(GetCouponsEvent()),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('الكوبونات'),
          ),
          body: ListView.separated(
              itemBuilder: (context, index) =>
                  couponBuilder(coupon: bloc.coupons[index] ,bloc:  bloc ,  context: context),
              separatorBuilder: (context, index) => SizedBox(
                    height: 20.sp,
                  ),
              itemCount: coupons.length),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Form(
                        key: formKey,
                        child: AlertDialog(
                          content: Text(
                            'اضافة كوبون خصم',
                            style: TextStyle(
                              fontWeight: FontWeightManager.semiBold,
                              fontSize: 17.sp,
                            ),
                          ),
                          actions: [
                            TextFormField(
                              controller: textController,
                              keyboardType:
                              TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        15.sp)),
                                prefixIcon: const Icon(
                                    Icons.text_fields ),
                                labelText: 'نص الكوبون  ',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'من فضلك اكتب نص الكوبون';
                                }
                                return null;
                              },
                            ) ,
                            SizedBox(height: 20.sp),
                            TextFormField(
                              controller: discountController,
                              keyboardType:
                              TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        15.sp)),
                                prefixIcon: const Icon (
                                    Icons.discount_outlined ),
                                labelText: 'قيمة الخصم',
                              ),
                              validator: (value) {
                                if (value!.isEmpty || int.parse(value) > 100 ) {
                                  return 'من فضلك اكتب قيمة خصم صحيحة ';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.sp),
                            TextFormField(
                              controller: dateController,
                              keyboardType:
                              TextInputType.datetime,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        15.sp)),
                                prefixIcon:  IconButton(icon: Icon(Icons.date_range),
                                onPressed: (){
                                  showDatePicker(context: context, initialDate: DateTime.now(),
                                      firstDate: DateTime.now(), lastDate: DateTime.utc(2060),
                                  ).then((value)
                                  {
                                    dateController.text = Date.from(value!).toString();
                                    date = value.date ;
                                  });

                                },),
                                labelText: 'تاريخ الصلاحية ',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'من فضلك اكتب تاريخ الصلاحية';
                                }
                                return null;
                              },
                            ) ,
                            SizedBox(height: 20.sp),
                            MaterialButton (
                              onPressed: () {
                                if(formKey.currentState!.validate()){
                                  CouponModel coupon = CouponModel(text: textController.text, discount: int.parse(discountController.text)
                                      , date: date );
                                  bloc.add(AddCouponEvent(coupon ));
                                  NavigationManager.pop(context);
                                }
                              },
                              child: Text(
                                'تأكيد',
                                style: TextStyle(color: ColorManager.white),
                              ),
                              color: ColorManager.primary,
                            )
                          ],
                        ),
                      );
                    });
              },
              child: const Icon(Icons.add)),
        );
      },
    );
  }
}
