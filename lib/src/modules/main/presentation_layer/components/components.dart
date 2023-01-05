import 'package:albaraka_management/src/modules/main/presentation_layer/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
              // image
              // Expanded(
              //
              // ),
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
                    child: Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
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