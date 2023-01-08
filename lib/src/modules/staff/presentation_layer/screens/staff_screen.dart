import 'package:albaraka_management/src/modules/staff/presentation_layer/bloc/staff_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../components/components.dart';

class StaffScreen extends StatelessWidget {
  StaffScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = StaffBloc.get(context);
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocBuilder<StaffBloc, StaffState>(
      builder: (context, state) {
       bool isVisible = bloc.currentVisibility;
       bloc.add(GetAllStaffEvent());
        return Scaffold(
          appBar: AppBar(
            title: Text("الاعضاء"),
          ),
          floatingActionButton: FloatingActionButton(onPressed: () async{
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  SingleChildScrollView(
                    child: AlertDialog(
                      title: Text("اضافه عضو"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك اكتب اسمك';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.sp)),
                                prefixIcon: const Icon(Icons.person_3_outlined),
                                labelText: 'الاسم'),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك اكتب الايميل';
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
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك اكتب رقم الهاتف';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.sp)),
                                prefixIcon: const Icon(Icons.phone),
                                labelText: 'الهاتف'),
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
                          SizedBox(
                            height: 2.5.h,
                          ),
                          TextFormField(
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isVisible ,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.sp)),
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                     bloc.add(ChangeVisibilityWhenAddMemberEvent(!isVisible));
                                    },
                                    icon: isVisible
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility)),
                                labelText: 'تأكيد الباسورد'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك اكتب الباسورد تاني';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 2.5.h,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                            emailController.clear();
                            confirmPasswordController.clear();
                            passwordController.clear();
                            nameController.clear();
                            phoneController.clear();
                            },
                          child: Text('الغاء'),
                        ),
                        TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              bloc.add(AddMemberEvent(email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text));
                            }
                            bloc.add(GetAllStaffEvent());
                            Navigator.pop(context);
                            emailController.clear();
                            confirmPasswordController.clear();
                            passwordController.clear();
                            nameController.clear();
                            phoneController.clear();
                          },
                          child: Text('اضافة'),
                        ),
                      ],
                    ),
                  ),);
          },
              child: Icon(Icons.person_add)),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      children: List.generate(bloc.members.length, (index) {
                        return ItemStaffGrid(bloc.members[index], context,index);
                      }),
                    ),
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
