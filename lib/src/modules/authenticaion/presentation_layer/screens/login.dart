import 'package:albaraka_management/src/modules/authenticaion/presentation_layer/bloc/auth_bloc.dart';
import 'package:albaraka_management/src/modules/authenticaion/presentation_layer/screens/forget_password.dart';
import 'package:albaraka_management/src/modules/authenticaion/presentation_layer/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/navigation_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    var bloc = AuthBloc.get(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white10,
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0.sp),
            child: Center(
              child: SingleChildScrollView(
                  child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45.sp,
                      backgroundImage:
                          const AssetImage('assets/images/logo.svg'),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    const Text(
                      'تسجيل الدخول',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'لازم تكتب ايميل';
                        }
                        return null;
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.sp)),
                        prefixIcon: const Icon(Icons.email_outlined),
                        labelText: 'الإيميل',
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: bloc.type,
                      obscureText: bloc.currentVisibility,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.sp)),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                              onPressed: () {
                                bloc.add(const ChangeVisibilityEvent());
                              },
                              icon: Icon(bloc.currentSuffix)),
                          labelText: 'كلمة السر الجديده'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك اكتب كلمة السر';
                        }
                        return null;
                      },
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              NavigationManager.push(context, ForgetPassword());
                            },
                            child: Text(
                              'نسيت كلمة السر ؟',
                              style: TextStyle(
                                color: ColorManager.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ))),
                    SizedBox(
                      height: 10.sp,
                    ),
                    if (State is! LoginLoadingAuthState)
                      MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            bloc.add(LoginEvent(
                                email: emailController.text,
                                password: passwordController.text,
                                context: context));
                          }
                        },
                        color: ColorManager.primary,
                        minWidth: double.infinity,
                        height: 25.sp,
                        elevation: 5,
                        child: Text(
                          'تسجيل الدخول',
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.sp),
                        ),
                      )
                    else
                      const CircularProgressIndicator(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('معندكش أكونت ؟ '),
                        TextButton(
                            onPressed: () {
                              NavigationManager.push(
                                  context, const RegisterScreen());
                            },
                            child: const Text('سجل دلوقت'))
                      ],
                    )
                  ],
                ),
              )),
            ),
          ),
        );
      },
    );
  }
}
