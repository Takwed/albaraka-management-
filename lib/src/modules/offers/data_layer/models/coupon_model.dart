import 'package:albaraka_management/src/modules/offers/domain_layer/entities/coupon.dart';

class CouponModel extends Coupon {
  CouponModel(
      {required String text, required int discount, required DateTime date})
      : super(date: date, discount: discount, text: text);
  Map<String, dynamic> toJson() {
    return {'text': text, 'discount': discount, 'date': date};
  }

  static Coupon fromJson(Map<String, dynamic> json) {
    return Coupon(
        text: json['text'], discount: json['discount'], date: json['date']);
  }
}
