import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                children: List.generate(item.length,(index) {
                  return ItemGrid(item[index]);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget ItemGrid(Item item) {
  return InkWell(
    onTap: (){},
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

class Item {
  Item({required this.title, required this.image});
  final String title;
  final String image ;
}

List<Item> item=[
  Item(title: "الأعضاء",image: ""),
  Item(title: "المنيو",image: ""),
  Item(title: "العروض",image: ""),
  Item(title: "طلبات اليوم",image: ""),
  Item(title: "فاضية مؤثتا ",image: ""),
];
