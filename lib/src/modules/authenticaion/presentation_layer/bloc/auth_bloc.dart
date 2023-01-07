import 'package:albaraka_management/src/core/local/shared_prefrences.dart';
import 'package:albaraka_management/src/core/utils/navigation_manager.dart';
import 'package:albaraka_management/src/modules/authenticaion/presentation_layer/components/components.dart';
import 'package:albaraka_management/src/modules/authenticaion/presentation_layer/screens/login.dart';
import 'package:albaraka_management/src/modules/main/presentation_layer/screens/main_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/dep_injection.dart';
import '../../domain_layer/use_cases/forget_password_usecase.dart';
import '../../domain_layer/use_cases/login_with_email&pass_usecase.dart';
import '../../domain_layer/use_cases/register_with_email&pass_usecase.dart';
import '../screens/register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static AuthBloc get(BuildContext context) =>
      BlocProvider.of<AuthBloc>(context);
  List<Widget> pages = [
    const LoginScreen(),
    const RegisterScreen(),
  ];
  int currentIndex = 0;


  Widget currentPages = const LoginScreen();

  /// change visibility
  bool currentVisibility = false;
  IconData currentSuffix = Icons.visibility;
  TextInputType type = TextInputType.visiblePassword;
  void changeVisibility()
  {
    currentVisibility = !currentVisibility;
    currentSuffix = currentVisibility ? Icons.visibility : Icons.visibility_off;
    type = currentVisibility ? TextInputType.text : TextInputType.visiblePassword;
  }

  AuthBloc(AuthInitial authInitial) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is ChangeButtonAuthenticationEvent) {
        currentPages = pages[event.index];
        currentIndex = event.index;
        emit(ChangeButtonAuthState(index: event.index));
      }
      else if (event is ChangeVisibilityEvent) {
        changeVisibility();
        emit(ChangeVisibilityAuthState(isVisible: currentVisibility));
      }
      else if (event is LoginEvent) {
        emit(LoginLoadingAuthState());
        final result = await LoginWithEmailAndPassUseCase(sl()).excute(
          email: event.email,
          password: event.password,
        );
        String ? id = await CacheHelper.getData(key: 'uid');
        result.fold((l) {
          errorToast(msg: l.message!);
          emit(LoginErrorAuthState());
        }, (r)  {
          NavigationManager.push(event.context, MainScreen());
          defaultToast(msg: "Login Successfully");
          // await    CacheHelper.saveData(key: 'uid', value: r!.user!.uid);
          emit(LoginSuccessfulAuthState(context: event.context , uid: id!));
        });
      } else if (event is RegisterEvent)
      {
        emit(RegisterLoadingAuthState());
        final result = await RegisterWithEmailAndPassUseCase(sl()).excute(
            email: event.email, password: event.password, name: event.name);
        String   id = await CacheHelper.getData(key: 'uid') ?? '' ;
        result.fold((l) {
          print(l);
          errorToast(msg: l.message!);
          emit(RegisterErrorAuthState());
        }, (r)  {
          defaultToast(msg: "Account Created Successfully");
          emit(RegisterSuccessfulAuthState(context: event.context ,  uid: id));
        });
      } else if (event is ForgetPasswordAuthEvent)
      {
        final result = await ForgetPasswordUseCase(sl()).excute(email: event.email).catchError((e)
        {
         // print("forgetPassword from bloc error " + e.toString());
        });
        result.fold((l) {
          errorToast(msg: l.message!);
        }, (r) {
          defaultToast(msg: "Please Check Your Mail");
        });
      }
    });
  }
}