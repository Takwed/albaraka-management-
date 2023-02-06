import '../../domain_layer/entities/member.dart';

class MemberModel extends Members
{
  MemberModel({required String name, required String phone, required String email}) : super(email: email , name: name ,  phone: phone);

  factory MemberModel.fromJson (Map <String , dynamic> json){
    return MemberModel(name: json['name'], phone: json['phone'], email: json['email']);
  }

}