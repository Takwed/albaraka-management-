import 'package:albaraka_management/src/modules/menu/data_layer/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';
import '../bloc/menu_bloc.dart';
import '../screens/menu_screen.dart';

Widget ItemProductGrid(ProductModel product,context,index) {
  return BlocBuilder<MenuBloc, MenuState>(
    builder: (context, state) {
      bool isSelected = false;
      return InkWell(
        onLongPress: (){

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
                  borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(8),
                      bottomStart: Radius.circular(8)
                  ),),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                     height: 105.sp,
                     width: double.infinity,
                     decoration: BoxDecoration(
                       color: Colors.grey[400],
                       image: DecorationImage(
                         image: NetworkImage(product.image!,),
                         fit: BoxFit.cover,
                       ),
                     ),),
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
                      padding: EdgeInsets.symmetric(horizontal: 10.sp,),
                      child: Text(
                        "${product.price}\$",
                        style: TextStyle(
                            color: ColorManager.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
              ),
              isSelected? IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.check_box_outline_blank_rounded),
              ) : Container(),
            ],
          ),
        ),
      );
    },
  );
}