
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class ChangeButtonAuthenticationEvent extends AuthEvent {
  final int index;

  const ChangeButtonAuthenticationEvent({required this.index});
  @override
  List<Object?> get props => [index];
}

class LoginEvent extends AuthEvent {
  String email;
  String password;
  final context;
  LoginEvent(
      {required this.email, required this.password, required this.context});

  @override
  List<Object?> get props => [email, password, context];
}

class RegisterEvent extends AuthEvent {
  String email;
  String password;
  String name;
  final BuildContext context;
  RegisterEvent(
      {required this.email,
      required this.password,
      required this.name,
      required this.context});
  @override
  List<Object?> get props => [email, password, context];
}

class ChangeVisibilityEvent extends AuthEvent {
  const ChangeVisibilityEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ForgetPasswordAuthEvent extends AuthEvent {
  final String email;
  const ForgetPasswordAuthEvent({required this.email});
  @override
  List<Object?> get props => [email];
}
