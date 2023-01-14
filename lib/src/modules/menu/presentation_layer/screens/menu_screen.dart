import 'package:albaraka_management/src/modules/menu/presentation_layer/bloc/menu_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

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
          initialIndex: 1,  //optional, starts from 0, select the tab by default
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                title: const Text("المنيو"),
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
                                 ),SizedBox(
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
                                 priceProduct.clear();
                                 nameProduct.clear();
                                 Navigator.pop(context);
                               }
                             }, child: const Text("اضافة")),
                           ],
                         ),);
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
              ):Center(child: CircularProgressIndicator(),)
          ),
        );
      }
);
  }
}