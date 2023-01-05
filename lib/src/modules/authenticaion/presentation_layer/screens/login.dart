import 'package:albaraka_management/core/utils/color_manager.dart';
import 'package:albaraka_management/core/utils/navigation_manager.dart';
import 'package:albaraka_management/src/modules/authenticaion/presentation_layer/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    bool isvisible = false;
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
                  backgroundImage: AssetImage('assets/images/logo.svg'),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                const Text(
                  'تسجيل الدخول',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
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
                      labelText: 'الإيميل' , ),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: isvisible
                      ? TextInputType.text
                      : TextInputType.visiblePassword,
                  obscureText: isvisible ? false : true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'لازم تكتب باسورد';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.sp)),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: !isvisible
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off)),
                      labelText: 'الباسورد'),
                ),
                SizedBox(
                  height: 30.sp,
                ),
                //     state is !ShopLoginLoadingState?
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
                  height: 25.sp,
                  elevation: 5,
                  child: Text(
                    'تسجيل الدخول',

                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                )
                //     : const CircularProgressIndicator(
                //   color: Colors.deepOrange,
                // ),
                ,
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
  }
}
