import 'package:equatable/equatable.dart';

class Members extends Equatable{
  late String name;
  late String phone;

  Members({
    required this.name,
    required this.phone,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name,phone];

}