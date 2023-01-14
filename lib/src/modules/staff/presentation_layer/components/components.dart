import 'package:albaraka_management/src/modules/staff/data_layer/models/staff_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../bloc/staff_bloc.dart';

Widget ItemStaffGrid(MemberModel item, BuildContext context, int index) {
  var bloc = StaffBloc.get(context);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  emailController.text = bloc.members[index].email;
  return BlocBuilder<StaffBloc, StaffState>(
    builder: (context, state) {
      bool isVisible = bloc.currentVisibility;
      return InkWell(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
             BlocBuilder<StaffBloc, StaffState>(
              builder: (context, state) {
                    return AlertDialog(
              title: const Text('هل تريد حذف هذا الحساب ؟'),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: emailController,
                      enabled: false,
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
                      keyboardType: bloc.type,
                      obscureText: bloc.currentVisibility,
                      decoration: InputDecoration (
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.sp)),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                              onPressed: () {
                                bloc.add(const ChangeVisibilityEvent()) ;
                              },
                              icon: Icon(bloc.currentSuffix)),
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
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    passwordController.clear();
                    },
                  child: const Text('الغاء'),
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      bloc.add(DeleteMemberEvent(email: emailController.text,password: passwordController.text));
                      bloc.add(const GetAllStaffEvent());
                      passwordController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('حذف'),
                ),
              ],
            );
                    },
                ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  color: Colors.black12,
                  elevation: 7,
                  child: Container(
                      decoration: const BoxDecoration(
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