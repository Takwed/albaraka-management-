import 'package:equatable/equatable.dart';

class Members extends Equatable{
  late String name;
  late String phone;
  late String email;
  Members({
    required this.name,
    required this.phone,
    required this.email,
  });

  @override
  List<Object?> get props => [name,phone,email];

}