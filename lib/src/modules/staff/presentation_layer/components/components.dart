import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
Widget ItemStaffGrid(ItemStaff item,BuildContext context) {
//  var bloc = MainBloc.get(context);
  return InkWell(
    onTap: () {
   //  bloc.add(ChangeGridMainEvent(context: context,index: item.index));
    },
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
            child: Card(
              color: Colors.black12,
              elevation: 7,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(8),
                      bottomStart: Radius.circular(8)
                  ),
                ),
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.sp),
                    ),
                    Text(
                      item.phone,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.sp),
                    ),
                  ],
                )
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
class ItemStaff {
  ItemStaff({required this.name,required this.index,required this.phone,});
  final String name;
  final String phone;
  final int index ;
}

List<ItemStaff> item=[
  ItemStaff(name: "محمد اشرف",phone: "01551677738",index: 0,),
  ItemStaff(name: "محمود عاطف",phone: "01028499657",index: 1,),
];
