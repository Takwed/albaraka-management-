import 'package:albaraka_management/src/modules/staff/data_layer/models/staff_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../bloc/staff_bloc.dart';

Widget ItemStaffGrid(MemberModel item, BuildContext context) {
  var bloc = StaffBloc.get(context);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isVisible = bloc.currentVisibility;
  return BlocBuilder<StaffBloc, StaffState>(
    builder: (context, state) {
      return InkWell(
        onLongPress: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('هل تريد حذف هذا الحساب ؟'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك اكتب الايميل ';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.sp)),
                        prefixIcon: const Icon(Icons.email_outlined),
                        labelText: 'الايميل'),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isVisible,
                    decoration: InputDecoration (
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.sp)),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                            onPressed: () {
                              bloc.add(ChangeVisibilityWhenAddMemberEvent(isVisible)) ;
                            },
                            icon: isVisible
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility)),
                        labelText: 'الباسورد'),
                    validator: (value) {
                      if (value!.isEmpty)
                      {
                        return 'من فضلك اكتب الباسورد';
                      }
                      return null;
                    },
                  ),

                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
         //bloc.add(ChangeGridStaffEvent(index: item.index));
        },
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  color: Colors.black12,
                  elevation: 7,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(8),
                            bottomStart: Radius.circular(8)
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 17.sp),
                          ),
                          Text(
                            item.phone,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.sp),
                          ),
                        ],
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class ItemStaff {
  ItemStaff({required this.name, required this.index, required this.phone,});

  final String name;
  final String phone;
  final int index;
}

List<ItemStaff> item = [
  ItemStaff(name: "محمد اشرف", phone: "01551677738", index: 0,),
  ItemStaff(name: "محمود عاطف", phone: "01028499657", index: 1,),
];
