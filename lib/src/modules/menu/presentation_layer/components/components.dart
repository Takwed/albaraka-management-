import 'package:albaraka_management/src/modules/menu/data_layer/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/color_manager.dart';
import '../bloc/menu_bloc.dart';

Widget ItemProductGrid(ProductModel product, context, index, MenuBloc bloc )  {

  return BlocBuilder<MenuBloc, MenuState>(
    builder: (context, state) {
      return InkWell(
        onLongPress: () {
          bloc.add(ChangeIsSelectedEvent());
          if (!bloc.isSelected) {
            bloc.selectProducts.add(product);
            bloc.productsId.add(index);
          } else {
            bloc.selectProducts = [];
            bloc.productsId = [];
          }
        },
        onTap: () {
          if (!bloc.isSelected) {
            bloc.isSelected = false;
            bloc.selectProducts = [];
            bloc.productsId = [];
            bloc.imageFile = null;
            bloc.isEdit = false;
            bloc.add(NavagationToProductsDetailsEvent(
                collectionIndex: bloc.changeTab,
                index: index,
                product: product,
                context: context));
          } else {
            if (bloc.selectProducts.contains(product)) {
              bloc.selectProducts.remove(product);
              bloc.productsId.remove(index);
            } else {
              bloc.selectProducts.add(product);
              bloc.productsId.add(index);
            }
            bloc.add(IsSelectedProductEvent());
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
                child: Stack(
                  children: [
                    Column(
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
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.sp,
                            ),
                            child: Text(
                              "${product.newPrice} ??.??",
                              style: TextStyle(
                                  color: ColorManager.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                    product.offerState == '' || product.offerState == null
                        ? Container()
                        :Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorManager.error,
                            borderRadius: BorderRadiusDirectional.only(
                                topEnd: Radius.circular(10.sp),
                                bottomEnd: Radius.circular(10.sp))),
                        child: Text('  ${product.offerState}  ',
                            style: TextStyle(color: ColorManager.white)),
                      ),
                    )
                  ],
                ),
              ),
              bloc.isSelected
                  ? IconButton(
                      onPressed: () {
                        if (bloc.selectProducts.contains(product)) {
                          bloc.selectProducts.remove(product);
                          bloc.productsId.remove(index);
                        } else {
                          bloc.selectProducts.add(product);
                          bloc.productsId.add(index);
                        }
                        bloc.add(IsSelectedProductEvent());
                      },
                      icon: bloc.selectProducts.contains(product)
                          ? const Icon(Icons.check_box)
                          : const Icon(Icons.check_box_outline_blank),
                    )
                  : Container(),
            ],
          ),
        ),
      );
    },
  );
}
