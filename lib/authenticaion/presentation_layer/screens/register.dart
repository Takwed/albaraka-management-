// ignore_for_file: dead_code

import 'package:albaraka_management/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isvisible = false;
    var registerEmailController = TextEditingController();
    var registerPasswordController = TextEditingController();
    var confirmRegisterPasswordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0.sp),
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 45.sp,
                        backgroundImage: AssetImage('assets/images/logo.svg'),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Text(
                        'اكونت جديد',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      TextFormField(
                        controller: registerEmailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'لازم تكتب ايميل';
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
                        controller: registerPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isvisible ? false : true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.sp)),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  isvisible = isvisible;
                                },
                                icon: isvisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility)),
                            labelText: 'الباسورد'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'لازم تكتب باسورد';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      TextFormField(
                        controller: confirmRegisterPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isvisible ? false : true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  isvisible = isvisible;
                                },
                                icon: isvisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility)),
                            labelText: 'اكتب الباسورد تاني'),
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
                      MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // ShopCubit.get(context).userLogin(
                            //     email: emailController.text,
                            //     password: passwordController.text, context: context);
                          }
                        },
                        color: ColorManager.primary,
                        minWidth: double.infinity,
                        height: 1.h,
                        elevation: 5,
                        child: Text(
                          'تسجيل الحساب',
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.sp),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ));
  }
}
