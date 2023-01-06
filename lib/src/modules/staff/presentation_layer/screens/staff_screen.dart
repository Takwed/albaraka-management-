import 'package:albaraka_management/src/modules/staff/presentation_layer/bloc/staff_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../components/components.dart';

class StaffScreen extends StatelessWidget {
  StaffScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isvisible = false;
    var registerEmailController = TextEditingController();
    var registerPasswordController = TextEditingController();
    var confirmRegisterPasswordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => StaffBloc(StaffInitial()),
      child: BlocBuilder<StaffBloc, StaffState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("الاعضاء"),
            ),
            floatingActionButton: FloatingActionButton(onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: Text("اضافه عضو"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: registerEmailController,
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
                                    borderRadius: BorderRadius.circular(15.sp)),
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
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: Text('OK'),
                        ),
                      ],
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
                        children: List.generate(item.length, (index) {
                          return ItemStaffGrid(item[index], context);
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
