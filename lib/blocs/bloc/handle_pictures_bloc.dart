import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:show_pictures/models/photo_model.dart';
import 'package:show_pictures/services/api_services.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/search_model.dart';
import '../../screens/downloads_screen.dart';
import '../../screens/favorite_screen.dart';
import '../../screens/unsplash_screen.dart';
part 'handle_pictures_event.dart';
part 'handle_pictures_state.dart';

class HandlePicturesBloc
    extends Bloc<HandlePicturesEvent, HandlePicturesState> {
  static HandlePicturesBloc get(BuildContext context) =>
      BlocProvider.of(context);

  HandlePicturesBloc() : super(HandlePicturesInitial()) {
    on<ChangeBottomNavBarEvent>(_changeBottomNav);
    on<GetPhotoEvent>(_getPhoto);
    on<SaveImageEvent>(_saveImage);
    on<SearchItemEvent>(_searchItem);
    on<CreatDatabaseEvent>(_createDatabase);
    on<InsertDatabaseEvent>(_insertDatabase);
    on<GetDatabaseEvent>(_getDatabase);
    on<DeleteDatabaseEvent>(_deleteDatabase);
  }

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    UnSplashScreen(),
    const FavoriteScreen(),
    const DownloadsScreen(),
  ];

  //Change Bottom Navigation Bar state
  void _changeBottomNav(ChangeBottomNavBarEvent event, Emitter<HandlePicturesState> emit)
  {
    currentIndex = event.index;
    emit(ChangeBottomNavBarState());
  }

  //Get photo from Api
  List<PhotoModel> photoModel = [];
  void _getPhoto(GetPhotoEvent event, Emitter<HandlePicturesState> emit) async
  {
    emit(LoadingPhotoState());
    //for get data
    var response = await ApiServices().getMethod(
        'https://api.unsplash.com/photos/?page=${event.numberPage}&&client_id=zgMzFufnbj0PUIURafyHfa5fPo5X8VG23tQHv7kHFlw');
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        //put data in model to display it
        photoModel.addAll({PhotoModel.fromJson(element)});
      });
      emit(GetSuccessPhotoState());
    } else {
      emit(GetErrorPhotoState());
    }
  }

  //Save image in gallery
  void _saveImage(SaveImageEvent event, Emitter<HandlePicturesState> emit)
  async {
    var status = await Permission.storage.request();
    try {
      if (status.isGranted) {
        var response = await Dio()
            .get(
            event.uri,
            options: Options(responseType: ResponseType.bytes));
        final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "hello",
        );
        emit(SaveImageSuccessState());
      } else {
        print("Faild");
        emit(SaveImageErrorState());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Search of Image by name
  SearchModel? searchModel;
  void _searchItem(SearchItemEvent event, Emitter<HandlePicturesState> emit)
  async {
    emit(SearchLoadingState());
    var response = await ApiServices().getMethod(
        'https://api.unsplash.com/search/photos/?query=${event.text}&&page=${event.number}&&client_id=zgMzFufnbj0PUIURafyHfa5fPo5X8VG23tQHv7kHFlw');
    if (response.statusCode == 200) {
        searchModel = SearchModel.fromJson(response.data);
      emit(SearchSuccessState());
    }
    else {
      emit(SearchErrorState());
    }
  }

  //to store favorite and downloaded images
  Database? database;
  List<Map> favorites=[];
  List<Map> download=[];

//create database
void _createDatabase(CreatDatabaseEvent event,Emitter<HandlePicturesState> emit)
async{
 await openDatabase(
    'photo.db',
    version: 1,
    onCreate: (database, version) {
      print('database created');
      database
          .execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, id1 String,url String , status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('Error When Creating Table ${error.toString()}');
      });
    },
    onOpen: (database)
     {
       _getDatabase(GetDatabaseEvent(database: database) , emit);
     // GetDatabaseEvent(database: database);
      print('database opened');
    },
  ).then((value) {
    database = value;
   emit(CreatDatabaseState());
  });
}

//insert to database
void _insertDatabase(InsertDatabaseEvent event,Emitter<HandlePicturesState> emit)
async{
  await database!.transaction((txn) {
    return  txn
        .rawInsert(
      'INSERT INTO tasks(id1, url, status) VALUES("${event.id1}", "${event.url}", "${event.status}")',
    )
        .then((value) {
      print('$value inserted successfully');
      emit(InsertDatabaseState());
      _getDatabase(GetDatabaseEvent(database: database!) , emit);
     // GetDatabaseEvent(database: database!);
    }).catchError((error) {
      print('Error When Inserting New Record ${error.toString()}');
    });
  });
}

//get from database
void _getDatabase(GetDatabaseEvent event,Emitter<HandlePicturesState> emit)
async{
  favorites=[];
  download=[];

 emit(GetDatabaseState());


 await event.database.rawQuery('SELECT * FROM tasks').then((value){
   value.forEach((element) {

      if (element['status'] == 'download') {
        download.add(element);
      } else if (element['status'] == 'favorite') {
        favorites.add(element);
      }
    });
   emit(GetDatabaseState());
  }
  );

}

//delete from database
void _deleteDatabase(DeleteDatabaseEvent event,Emitter<HandlePicturesState> emit)
async{
  await database!.rawDelete('DELETE FROM tasks WHERE id = ?', [event.id])
      .then((value)
 {
   _getDatabase(GetDatabaseEvent(database: database!) , emit);
   // GetDatabaseEvent(database: database!);
    emit(DeleteDatabaseState());
  });
}
}
