import '../../domain_layer/entities/member.dart';

class MemberModel extends Members
{
  MemberModel({required super.name, required super.phone});

  factory MemberModel.fromJson (Map <String , dynamic> json){
    return MemberModel(name: json['name'], phone: json['phone']);
  }

}