import 'package:albaraka_management/src/core/utils/color_manager.dart';
import 'package:albaraka_management/src/modules/main/presentation_layer/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';


import '../bloc/main_bloc.dart';
Widget ItemGrid(Item item,BuildContext context) {
  var bloc = MainBloc.get(context);
  return BlocBuilder<MainBloc,MainState>(
    builder: (context, state) {
      return InkWell(
        onTap: () {
          bloc.add(ChangeGridMainEvent(context: context,index: item.index));
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  color: Colors.black12,
                  elevation: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(color: ColorManager.black),
                      color: ColorManager.primary,
                      borderRadius: BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(8),
                          bottomStart: Radius.circular(8)
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Expanded(child: Icon(item.image , size: 40.sp, color: ColorManager.white,)),
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorManager.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
     );
}
class Item {
  Item({required this.title,required this.index, required this.image});
  final String title;
  final IconData image ;
  final int index ;

}

List<Item> items=[
  Item(title: "الأعضاء",image: Icons.groups,index: 0),
  Item(title: "المنيو",image: Icons.fastfood ,index: 1),
  Item(title: "العروض",image: Icons.local_offer_outlined,index: 2),
  Item(title: "طلبات اليوم",image: Icons.edit_calendar_outlined,index: 3),
  Item(title: "ميزانية الشهر",image: Icons.insert_chart,index: 4),
];
