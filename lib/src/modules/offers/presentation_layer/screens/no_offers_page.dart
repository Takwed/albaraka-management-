import 'package:albaraka_management/src/core/utils/color_manager.dart';
import 'package:albaraka_management/src/core/utils/navigation_manager.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../menu/presentation_layer/components/components.dart';
import '../bloc/offers_bloc.dart';
import '../components/components.dart';

const List<String> list = <String>['كشري', 'مشويات', 'حلويات'];

class NoOffersScreen extends StatelessWidget
{
  const NoOffersScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int i = 0;
    var bloc = OffersBloc.get(context);

    return DefaultTabController(
      initialIndex: 0, //optional, starts from 0, select the tab by default
      length: 3,
      child: BlocBuilder <OffersBloc, OffersState>(
        builder: (context, state) {
          if(i == 1){
            bloc.add( GetMashweyatEvent());
          }
          i = 0;
          return Scaffold (
              appBar: AppBar(
                leading:  const BackButton(),
                title: Row (
                  children: [
                    const Text("قم باختيار وجبة"),
                  ],

                ),
                actions: [
                  TextButton(onPressed: (){}, child: Text('كوبونات' , style: TextStyle(color: ColorManager.white),))
                ],
              ),
              // floatingActionButton: FloatingActionButton(
              //     onPressed: () {
              //       showDialog(context: context,
              //           builder: (BuildContext context){
              //             return BlocBuilder<OffersBloc, OffersState>(builder: ( context , state) {
              //               return Container();
              //             });
              //           });
              //     },
              //     child: const Icon(Icons.add)),
              body: ContainedTabBarView (
                initialIndex: 0,
                onChange: (index){
                  if(index == 0 || bloc.koshary.isEmpty) {
                    bloc.add( GetKosharyEvent());
                  }
                  else if (index == 1 || bloc.mashweyat.isEmpty) {
                    bloc.add( GetMashweyatEvent());
                  }
                  else if (index == 2 || bloc.mashweyat.isEmpty) {
                    bloc.add( GetHalaweyatEvent());
                  }
                  bloc.add(ChangeTabBarEvent(index: index));
                },
                tabs: [
                  Text("كشري",style: TextStyle(color: ColorManager.black),),
                  Text("مشويات",style: TextStyle(color: ColorManager.black),),
                  Text("حلويات",style: TextStyle(color: ColorManager.black),),
                ],
                views: [
                  state is! GetKosharyLoadingState ?
                  RefreshIndicator(
                    onRefresh: ()async{
                      bloc.kosharyOffers.clear();
                      bloc.koshary.clear();
                      bloc.add(GetKosharyEvent());
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        mainAxisSpacing: 20.sp,
                        padding: EdgeInsets.all(22.sp),
                        crossAxisCount: 2,
                        childAspectRatio: 6.5.sp / 9.0.sp,
                        crossAxisSpacing: 20.sp,
                        children:
                        List.generate(bloc.koshary.length, (index) {
                          return offerItemBuilder(bloc.koshary[index], context, index, bloc, false, );
                        }),
                      ),
                    ),
                  ):
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  state is! GetMashweyatLoadingState ?
                  RefreshIndicator(
                    onRefresh: ()async{
                      bloc.mashweyat.clear();
                      bloc.mashweyatOffers.clear();
                      bloc.add( GetMashweyatEvent());
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: InkWell(
                        onTap: (){},
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          mainAxisSpacing: 20.sp,
                          padding: EdgeInsets.all(22.sp),
                          crossAxisCount: 2,
                          childAspectRatio: 6.5.sp / 9.0.sp,
                          crossAxisSpacing: 20.sp,
                          children:  List.generate(bloc.mashweyat.length, (index) {
                            return offerItemBuilder(bloc.mashweyat[index], context, index, bloc, false, );
                          }),
                        ),
                      ),
                    ),
                  ):
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  state is! GetHalaweyatLoadingState ?
                  RefreshIndicator(
                    onRefresh: ()async{
                      bloc.halaweyat.clear();
                      bloc.halaweyatOffers.clear();
                      bloc.add( GetHalaweyatEvent());
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        mainAxisSpacing: 20.sp,
                        padding: EdgeInsets.all(22.sp),
                        crossAxisCount: 2,
                        childAspectRatio: 6.5.sp / 9.0.sp,
                        crossAxisSpacing: 20.sp,
                        children:   List.generate(bloc.halaweyat.length, (index) {
                          return offerItemBuilder(bloc.halaweyat[index], context, index, bloc, false, );
                        }),
                      ),
                    ),):
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ));
        },
      ) ,
    );
  }
}
Widget coupon = Padding ( padding: EdgeInsets.all(15.sp),
  child: Center (
      child:  Row(
        children: [

          Stack(
            children: [
              Card (
                // clipBehavior: Clip.antiAlias,
                elevation: 7,
                child: Container
                  (
                  //  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration( color: ColorManager.primary,
                    // borderRadius: BorderRadius.circular(20.sp)
                  ),
                  width: 70.sp,
                  height: 70.sp,
                  child: Center(child: Text('40 %' , style:
                  TextStyle(color: ColorManager.white , fontSize: FontSizeManager.s30.sp , fontWeight: FontWeight.bold),)),
                ),
              ),
              SizedBox(
                child: CircleAvatar
                  (
                  backgroundColor: ColorManager.white,
                ),
              )
            ],
          ),
          // SizedBox(width: 10,) ,
          Expanded(
            child: SizedBox (
              height: 80.sp,
              width: double.infinity,
              child: Card (
                elevation: 7,
                child: Row (
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded (child:
                      Column
                        (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row
                            (
                            children: const [
                              Text('نص الكوبون: ' , style: TextStyle( fontWeight: FontWeightManager.bold  ),) ,
                              Text('TextOfCoupon'),
                            ],
                          ),
                          Row
                            (
                            children: const
                            [
                              Text('تاريخ الصلاحية: ' , style: TextStyle( fontWeight: FontWeightManager.bold  ),),

                            ],

                          ),
                          const Text ('23/2/2023 : 23/3/2023'  ,maxLines: 2 ,  overflow: TextOverflow.ellipsis),
                        ],
                      )
                      ),
                    ),
                    const Expanded(child: Icon(Icons.discount_rounded))
                  ],
                ),
              ),
            ),
          ),
        ],
      )
  ),);


