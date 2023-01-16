import 'package:albaraka_management/src/core/utils/color_manager.dart';
import 'package:albaraka_management/src/modules/menu/data_layer/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/navigation_manager.dart';
import '../bloc/menu_bloc.dart';

class ProductDetails extends StatelessWidget {
  ProductModel product;
  int index;
  ProductDetails(this.index,this.product, {super.key});
  @override
  Widget build(BuildContext context) {
    var bloc = MenuBloc.get(context);
    var nameProduct = TextEditingController();
    var describeProduct = TextEditingController();
    var priceProduct = TextEditingController();
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
    nameProduct.text = product.name;
    describeProduct.text = product.describe;
    double k = product.oldPrice;
    priceProduct.text = k.toString();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 320.sp,
                          decoration: BoxDecoration(
                              color: ColorManager.card,
                              image: bloc.imageFile == null?
                              DecorationImage(
                                  image: NetworkImage(product.image!), fit: BoxFit.cover) :
                              DecorationImage(
                                  image: FileImage(bloc.imageFile!),
                                  fit: BoxFit.cover)
                          ),
                        ),
                        Container(
                          width: 30.sp,
                          height: 30.sp,
                          decoration: BoxDecoration(
                            color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: IconButton(
                          icon: Icon(Icons.arrow_back_sharp,
                            color: ColorManager.white,
                          size: 17.sp,),
                          onPressed: () {
                            bloc.isEdit = false;
                            bloc.imageFile = null;
                            bloc.add(const GetProductEvent());
                            NavigationManager.pop(context);
                          }
                          ),
                        )
                      ],
                    ) ,
                    bloc.isEdit ? Container(
                      width: 30.sp,
                      height: 30.sp,
                      decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: IconButton(
                          icon: Icon(Icons.add_a_photo,
                            color: ColorManager.white,
                            size: 17.sp,),
                          onPressed: () {
                            bloc.add(ImagePickedEvent(
                                source: ImageSource.gallery,
                                context: context));
                          }
                      ),
                    ):Container()
                  ],
                ),
                SizedBox(
                  height: 10.sp,
                ),
                bloc.isEdit ?
                TextFormField(
                  controller: nameProduct,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration (
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.sp)),
                    prefixIcon:  const Icon(Icons.drive_file_rename_outline),
                    labelText: 'اسم الوجبة',),
                  validator: (value) {
                    if (value!.isEmpty)
                    {
                      return 'من فضلك اكتب اسم الوجبة';
                    }
                    return null;
                  },
                ): Text(product.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800
                )),
                SizedBox(
                  height: 10.sp,
                ),
                bloc.isEdit ?
                TextFormField(
                  controller: priceProduct,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration (
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.sp)),
                    prefixIcon:  const Icon(Icons.attach_money),
                    labelText: 'السعر ',),
                  validator: (value) {
                    if (value!.isEmpty)
                    {
                      return 'من فضلك اكتب السعر ! ';
                    }
                    return null;
                  },
                ): Text("${product.oldPrice}\$",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800
                    )),
                SizedBox(
                  height: 10.sp,
                ),
                bloc.isEdit ?
                TextFormField(
                  controller: describeProduct,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration (
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.sp)),
                    prefixIcon:  const Icon(Icons.set_meal_sharp),
                    labelText: 'الوصف',),
                  validator: (value) {
                    if (value!.isEmpty)
                    {
                      return 'من فضلك اكتب وصف الوجبة';
                    }
                    return null;
                  },
                ): Text(product.describe,
                    style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),),
                SizedBox(height: 30.sp,),
                bloc.isEdit ?
                state is! EditProductLoadingStates ?Container(
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: (){
                      double s = double.parse(priceProduct.text);
                      bloc.add(EditProductEvent(
                          context: context,
                          name:nameProduct.text,
                          oldPrice: s,
                          newPrice: s,
                          describe: describeProduct.text,
                          id: index,
                      ));
                    },
                    child: Text("تم ",
                    style: TextStyle(
                      color: ColorManager.white,
                    ),),
                 ),
                ):const Center(child: CircularProgressIndicator()): Container(
                  decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: (){
                      bloc.add(IsEditProductEvent());
                    },
                    child: Text("تعديل ",
                      style: TextStyle(
                        color: ColorManager.white,
                      ),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
