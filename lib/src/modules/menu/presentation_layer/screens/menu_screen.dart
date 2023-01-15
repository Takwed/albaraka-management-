import 'package:albaraka_management/src/modules/menu/presentation_layer/bloc/menu_bloc.dart';
import 'package:albaraka_management/src/modules/products/domain_layer/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../data_layer/models/product_model.dart';
import '../components/components.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int i = 0;
    var nameProduct = TextEditingController();
    var describeProduct = TextEditingController();
    var priceProduct = TextEditingController();
    var formKey = GlobalKey<FormState>();
    var bloc = MenuBloc.get(context);
    return BlocBuilder<MenuBloc,MenuState>(
      builder: (context, state) {
        if(i == 0) {
          bloc.add(const GetProductEvent());
        }
        i = 1;
        return DefaultTabController(
          initialIndex: 0,  //optional, starts from 0, select the tab by default
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                leading: bloc.isSelected ?IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    bloc.add(BackToDefaultBeforeSelectEvent());
                    },
                ) : IconButton(
                  icon: const Icon(Icons.arrow_back_sharp),
                  onPressed: () {
                    Navigator.of(context).pop();
                    bloc.isSelected = false;
                  },
                ),
                title: Row(
                  children: [
                    if(!bloc.isSelected)const Text("المنيو")
                    else Text("${bloc.selectProducts.length} / ${bloc.products.length}"),
                    const Spacer(),
                    if(bloc.selectProducts.isNotEmpty)
                    if(bloc.isSelected) IconButton(
                        onPressed: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BlocBuilder<MenuBloc,MenuState>(
                                    builder: (context, state) {
                                      return AlertDialog(
                                        content: bloc.selectProducts.length > 1 ?
                                        const Text("سيتم حذف هذه المنتجات ؟") :
                                        const Text("سيتم حذف هذا المنتج ؟"),
                                        actions: [
                                          TextButton(onPressed: (){
                                            Navigator.pop(context);
                                          }, child: const Text("الغاء")),
                                          TextButton(onPressed: (){
                                            bloc.add(DeleteProductEvent());
                                          }, child: const Text("حذف")),
                                        ],
                                      );

                                      }
                                );
                              }
                          );
                        },
                        icon: const Icon(Icons.delete)),
                    if(bloc.isSelected) IconButton(
                        onPressed: (){
                          bloc.add(SelectAllProductEvent());
                        },
                        icon: const Icon(Icons.select_all)),
                  ],
                ),
                bottom: const TabBar(tabs : [
                  Tab(text: 'كشري'),
                  Tab( text: 'مشويات'),
                  Tab(text: 'حلويات'),
                ] ,
                ),),
              floatingActionButton: FloatingActionButton(onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                   return BlocBuilder<MenuBloc,MenuState>(
                      builder: (context, state) {
                           return SingleChildScrollView(
                         child: AlertDialog(
                           title: const Text("اضافه منتج"),
                           content: Form(
                             key: formKey,
                             child: Column(
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 MaterialButton(
                                   onPressed: (){
                                     bloc.add(ImagePickedEvent(
                                         source: ImageSource.gallery,
                                         context: context));
                                   },
                                   child: bloc.imageFile == null? const Text("Add image "):
                                   Image.file(bloc.imageFile!)
                                 ),
                                 SizedBox(
                                   height: 20.sp,
                                 ),
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
                                 ),
                                 SizedBox(
                                   height: 20.sp,
                                 ),
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
                                 ),
                                 SizedBox(
                                   height: 20.sp,
                                 ),
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
                                 ),
                               ],
                             ),
                           ),
                           actions: [
                             TextButton(onPressed: (){
                               bloc.imageFile = null;
                               describeProduct.clear();
                               priceProduct.clear();
                               nameProduct.clear();
                               Navigator.pop(context);
                             }, child: const Text("الغاء")),
                             TextButton(onPressed: (){
                               if (formKey.currentState!.validate()) {
                                 int s = int.parse(
                                     priceProduct.text);
                                 bloc.add(AddProductEvent(
                                   price: s,
                                   describe: describeProduct.text,
                                   name: nameProduct.text,
                                 ));
                                 bloc.add(const GetProductEvent());
                                 describeProduct.clear();
                                 bloc.imageFile = null;
                                 priceProduct.clear();
                                 nameProduct.clear();
                                 Navigator.pop(context);
                               }
                             }, child: const Text("اضافة")),
                           ],
                         ),
                           );
                      },
                   );
                  }
                );
              },
                  child: const Icon(Icons.add)),
              body: state is! GetProductLoadingState ? SingleChildScrollView(
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  mainAxisSpacing: 20.sp,
                  padding: EdgeInsets.all(22.sp),
                  crossAxisCount: 2,
                  childAspectRatio: 6.5.sp / 9.0.sp,
                  crossAxisSpacing: 20.sp,
                  children: List.generate(bloc.products.length, (index) {
                    return ItemProductGrid(bloc.products[index],context,index);
                  }),
                ),
              ):const Center(child: CircularProgressIndicator(),)
          ),
        );
      }
);
  }
}