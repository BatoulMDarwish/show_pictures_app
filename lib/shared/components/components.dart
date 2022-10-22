import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:show_pictures/blocs/bloc/handle_pictures_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../style/color.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));



Widget ImageBuilder({required List<Map> images,bool download=true})
=>ConditionalBuilder(
    condition: images.isNotEmpty,
    builder:(context)=>SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1 / 1.4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount: 2,
              children: List.generate(
                images.length,
                  (index) => buildImageItem(images[index], context,download)
              )
            ),
          ),
        ],
      ),
    ),
    fallback: (context)=>Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.menu,
            size: 100.0,
            color: Colors.grey,
          ),
          Text(
            'No Images Yet',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
);



Widget buildImageItem(Map model,context,bool dwonload)
=>Container(
  color: Colors.white,
 child:dwonload?
 Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   children: [
     Image(
        image: NetworkImage(
          model['url'],
        ),
        width: 200.0,
        height: 200.0,
      ),
     Row(
       children: [
         IconButton(
             onPressed: () {
               HandlePicturesBloc.get(context).add(DeleteDatabaseEvent(id: model['id']));
             },
             // ignore: prefer_const_constructors
             icon: CircleAvatar(
               backgroundColor:primaryColor,
               radius: 15,
               child: const Icon(
                 Icons.delete,
                 color: Colors.white,
                 size: 14,
               ),
             )),
         const Text(
           'Remove',
           style: TextStyle(
             fontWeight: FontWeight.bold,
             color: primaryColor
           ),
         ),
       ],
     ),
   ],
 )
     :CachedNetworkImage(
      imageUrl:model['url'],
      width: 100,
      height: 100,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
),


  );



void showToast({
  required String text,
  required ToastStates state,
})=>  Fluttertoast.showToast(
  msg:text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);



enum ToastStates{SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color =Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.amber;
      break;
  }
  return color;
}

