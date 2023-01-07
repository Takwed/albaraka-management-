import 'package:albaraka_management/src/modules/main/presentation_layer/bloc/main_bloc.dart';
import 'package:albaraka_management/src/modules/main/presentation_layer/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = MainBloc.get(context);
    return BlocBuilder<MainBloc,MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      child: Image.network("https://media.gemini.media/img/Original/2021/5/6/2021_5_6_12_9_18_515.jpg")),
                  GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    children: List.generate(item.length,(index)
                    {
                      return ItemGrid(item[index],context);
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    ,);
  }
}
