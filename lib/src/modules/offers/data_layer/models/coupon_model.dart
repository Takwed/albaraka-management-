import 'package:albaraka_management/src/modules/offers/domain_layer/entities/coupon.dart';
import 'package:date_time/date_time.dart';

class CouponModel extends Coupon {
  CouponModel(
      {required String text, required int discount, required Date date})
      : super(date: date, discount: discount, text: text);
  Map<String, dynamic> toJson() {
    return {'text': text, 'discount': discount, 'date': date.toString()};
  }

  static Coupon fromJson(Map<String, dynamic> json)
  {
    return Coupon(
        text: json['text'], discount: json['discount'], date: Date.parse(json['date'] , format: ('dd/MM/yyyy')) );
  }
}
