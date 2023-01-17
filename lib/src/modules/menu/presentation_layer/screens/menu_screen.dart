import 'package:albaraka_management/src/core/utils/color_manager.dart';
import 'package:albaraka_management/src/modules/menu/presentation_layer/bloc/menu_bloc.dart';
import 'package:albaraka_management/src/modules/products/domain_layer/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../data_layer/models/product_model.dart';
import '../components/components.dart';

const List<String> list = <String>['كشري', 'مشويات', 'حلويات'];

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int i = 1;
    int collectionIndex = 0;
    var nameProduct = TextEditingController();
    var describeProduct = TextEditingController();
    var priceProduct = TextEditingController();
    var formKey = GlobalKey<FormState>();
    var bloc = MenuBloc.get(context);
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return DefaultTabController(
          initialIndex: 0, //optional, starts from 0, select the tab by default
          length: 3,
          child: BlocBuilder<MenuBloc, MenuState>(
            builder: (context, state) {
              if (i == 1) {
                bloc.add(const GetKosharyEvent());
                bloc.add(const GetMashweyatEvent());
                bloc.add(const GetHalaweyatEvent());
              }
              i = 0;
              int ind = DefaultTabController.of(context).index;
             // print(ind);
              return Scaffold(
                  appBar: AppBar(
                    leading: bloc.isSelected
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              bloc.add(BackToDefaultBeforeSelectEvent());
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.arrow_back_sharp),
                            onPressed: () {
                              Navigator.of(context).pop();
                              bloc.isSelected = false;
                            },
                          ),
                    title: Row(
                      children: [
                        if (!bloc.isSelected) const Text("المنيو"),
                        if (bloc.isSelected && ind == 0)
                          Text(
                              "${bloc.selectProducts.length} / ${bloc.koshary.length}"),
                        if (bloc.isSelected && ind == 1)
                          Text(
                              "${bloc.selectProducts.length} / ${bloc.mashweyat.length}"),
                        if (bloc.isSelected && ind == 2)
                          Text(
                              "${bloc.selectProducts.length} / ${bloc.halaweyat.length}"),
                        const Spacer(),
                        if (bloc.selectProducts.isNotEmpty)
                          if (bloc.isSelected)
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BlocBuilder<MenuBloc, MenuState>(
                                            builder: (context, state) {
                                          return AlertDialog(
                                            content: bloc
                                                        .selectProducts.length >
                                                    1
                                                ? const Text(
                                                    "سيتم حذف هذه المنتجات ؟")
                                                : const Text(
                                                    "سيتم حذف هذا المنتج ؟"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("الغاء")),
                                              TextButton(
                                                  onPressed: () {
                                                    if (ind == 0) {
                                                      bloc.add(
                                                          DeleteProductEvent(
                                                              bloc.koshary,
                                                              ind));
                                                    } else if (ind == 1) {
                                                      bloc.add(
                                                          DeleteProductEvent(
                                                              bloc.mashweyat,
                                                              ind));
                                                    } else if (ind == 2) {
                                                      bloc.add(
                                                          DeleteProductEvent(
                                                              bloc.halaweyat,
                                                              ind));
                                                    }
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("حذف")),
                                            ],
                                          );
                                        });
                                      });
                                },
                                icon: const Icon(Icons.delete)),
                        if (bloc.isSelected)
                          IconButton(
                              onPressed: () {
                                if (ind == 0) {
                                  bloc.add(SelectAllProductEvent(bloc.koshary));
                                } else if (ind == 1) {
                                  bloc.add(
                                      SelectAllProductEvent(bloc.mashweyat));
                                } else if (ind == 2) {
                                  bloc.add(
                                      SelectAllProductEvent(bloc.halaweyat));
                                }
                              },
                              icon: const Icon(Icons.select_all)),
                      ],
                    ),
                    bottom: TabBar(
                     // controller: DefaultTabController.of(context),
                      indicator: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(50), // Creates border
                          color: ColorManager.yellow),
                      tabs: const [
                        Tab(text: 'كشري'),
                        Tab(text: 'مشويات'),
                        Tab(text: 'حلويات'),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        bloc.value = "كشري";
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return BlocBuilder<MenuBloc, MenuState>(
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
                                                onPressed: () {
                                                  bloc.imageFile = null;
                                                  bloc.add(ImagePickedEvent(
                                                      source:
                                                          ImageSource.gallery,
                                                      context: context));
                                                },
                                                child: bloc.imageFile == null
                                                    ? const Text("Add image ")
                                                    : Image.file(
                                                        bloc.imageFile!)),
                                            DropdownButton<String>(
                                              value: bloc.value,
                                              icon: const Icon(
                                                  Icons.arrow_downward),
                                              elevation: 16,
                                              style: TextStyle(
                                                  color: ColorManager.black),
                                              underline: Container(
                                                height: 2,
                                                color: ColorManager.card,
                                              ),
                                              onChanged: (String? value) {
                                                bloc.add(ChooseCollectionEvent(
                                                    value!));
                                                for (int i = 0; i < 3; ++i) {
                                                  if (list[i] == value) {
                                                    collectionIndex = i;
                                                  }
                                                }
                                              },
                                              items: list.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                            SizedBox(
                                              height: 20.sp,
                                            ),
                                            TextFormField(
                                              controller: nameProduct,
                                              keyboardType: TextInputType.name,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.sp)),
                                                prefixIcon: const Icon(Icons
                                                    .drive_file_rename_outline),
                                                labelText: 'اسم الوجبة',
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
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
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.sp)),
                                                prefixIcon: const Icon(
                                                    Icons.set_meal_sharp),
                                                labelText: 'الوصف',
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
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
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.sp)),
                                                prefixIcon: const Icon(
                                                    Icons.attach_money),
                                                labelText: 'السعر ',
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'من فضلك اكتب السعر ! ';
                                                }
                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              bloc.imageFile = null;
                                              describeProduct.clear();
                                              priceProduct.clear();
                                              nameProduct.clear();
                                              Navigator.pop(context);
                                            },
                                            child: const Text("الغاء")),
                                        TextButton(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                double s = double.parse(
                                                    priceProduct.text);
                                                bloc.add(AddProductEvent(
                                                  oldPrice: s,
                                                  newPrice: s,
                                                  describe:
                                                      describeProduct.text,
                                                  collectionIndex:
                                                      collectionIndex,
                                                  name: nameProduct.text,
                                                ));
                                                describeProduct.clear();
                                                bloc.imageFile = null;
                                                priceProduct.clear();
                                                nameProduct.clear();
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text("اضافة")),
                                      ],
                                    ),
                                  );
                                },
                              );
                            });
                      },
                      child: const Icon(Icons.add)),
                  body: TabBarView(
                    //controller: DefaultTabController.of(context),
                    children: <Widget>[
                      state is! GetKosharyLoadingState
                          ? SingleChildScrollView(
                              child: GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                mainAxisSpacing: 20.sp,
                                padding: EdgeInsets.all(22.sp),
                                crossAxisCount: 2,
                                childAspectRatio: 6.5.sp / 9.0.sp,
                                crossAxisSpacing: 20.sp,
                                children:
                                    List.generate(bloc.koshary.length, (index) {
                                  return ItemProductGrid(
                                      bloc.koshary[index], context, index, ind);
                                }),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                      state is! GetMashweyatLoadingState
                          ? SingleChildScrollView(
                              child: GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                mainAxisSpacing: 20.sp,
                                padding: EdgeInsets.all(22.sp),
                                crossAxisCount: 2,
                                childAspectRatio: 6.5.sp / 9.0.sp,
                                crossAxisSpacing: 20.sp,
                                children: List.generate(bloc.mashweyat.length,
                                    (index) {
                                  return ItemProductGrid(bloc.mashweyat[index],
                                      context, index, ind);
                                }),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                      state is! GetHalaweyatLoadingState
                          ? SingleChildScrollView(
                              child: GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                mainAxisSpacing: 20.sp,
                                padding: EdgeInsets.all(22.sp),
                                crossAxisCount: 2,
                                childAspectRatio: 6.5.sp / 9.0.sp,
                                crossAxisSpacing: 20.sp,
                                children: List.generate(bloc.halaweyat.length,
                                    (index) {
                                  return ItemProductGrid(bloc.halaweyat[index],
                                      context, index, ind);
                                }),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ],
                  ));
            },
          ),
        );
      },
    );
  }
}
