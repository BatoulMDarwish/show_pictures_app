import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_pictures/shared/style/color.dart';
import '../blocs/bloc/handle_pictures_bloc.dart';
import '../shared/components/components.dart';

class UnSplashScreen extends StatefulWidget {
  UnSplashScreen({super.key});


  @override
  State<UnSplashScreen> createState() => _UnSplashScreenState();
}

class _UnSplashScreenState extends State<UnSplashScreen> {
  // ignore: prefer_final_fields

  ScrollController _controller=ScrollController();
  bool isReached=true ;
  int page=1;
  var bloc;
  @override
  void initState() {
    super.initState();
    bloc = HandlePicturesBloc.get(context);
    _controller.addListener(_onScroll);
  }


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HandlePicturesBloc, HandlePicturesState>(
      listener: (context, state) {
        if(state is SaveImageSuccessState)
         {
           showToast(
             text:'Image downloaded to gallery' ,
             state: ToastStates.SUCCESS,
           );
         }else if(state is SaveImageErrorState){
          showToast(
            text:'Something wrong happened' ,
            state: ToastStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
           height: 580,
            color: Colors.grey[300],
            child: GridView.builder(
              controller: _controller,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 1.4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount: 2,),
               itemCount: !isReached
                      ? bloc.photoModel.length
                      : bloc.photoModel.length + 1,
                itemBuilder: (context, index) {
                if (index < bloc.photoModel.length) {
                  return Container(
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            image: NetworkImage(
                              bloc.photoModel[index].urls!['regular'],
                            ),
                            width: 200.0,
                            height: 200.0,
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    bloc.add(InsertDatabaseEvent(
                                        id1: bloc.photoModel[index].id!,
                                        url: bloc.photoModel[index].urls!['regular'],
                                        status: 'favorite'
                                    ));
                                  },
                                  // ignore: prefer_const_constructors
                                  icon: CircleAvatar(
                                    backgroundColor:primaryColor,
                                    radius: 15,
                                    child: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  )),
                              const SizedBox(
                                width: 3.0,
                              ),
                              IconButton(
                                  onPressed: () {
                                    String uri = bloc.photoModel[index]
                                        .urls!['regular'];
                                    bloc.add(SaveImageEvent(uri: uri));
                                    bloc.add(InsertDatabaseEvent(
                                        id1: bloc.photoModel[index].id!,
                                        url: uri,
                                        status: 'download'
                                    ));
                                  },
                                  // ignore: prefer_const_constructors
                                  icon: CircleAvatar(
                                    backgroundColor: primaryColor,
                                    radius: 15,
                                    child: const Icon(
                                      Icons.download,
                                      color: Colors.white,
                                      size: 14,
                                      //
                                    ),
                                  )),
                            ],
                          )
                        ]),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ),
        );
      },
    );
  }
  @override
  void dispose() {
    _controller..removeListener(_onScroll)
    ..dispose();
    super.dispose();
  }
 void _onScroll(){
    if(_isBottom){
      setState(() {
        isReached=true;
        page=page+1;
      });
      bloc.add(GetPhotoEvent(numberPage: page));
    }
 }
 bool get _isBottom{
    if(!_controller.hasClients) {
      setState(() {
        isReached=false;
      });
      return false;
    }
    final maxScroll=_controller.position.maxScrollExtent;
    final currentScroll=_controller.offset;
    return currentScroll>=(maxScroll*0.9);
 }
}
