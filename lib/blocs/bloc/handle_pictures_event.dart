part of 'handle_pictures_bloc.dart';

@immutable
abstract class HandlePicturesEvent {}

class ChangeBottomNavBarEvent extends HandlePicturesEvent {
  int index;
  ChangeBottomNavBarEvent({required this.index});
}

class GetPhotoEvent extends HandlePicturesEvent {
  int numberPage;
  GetPhotoEvent({required this.numberPage});
}

class SearchItemEvent extends HandlePicturesEvent {
  int number;
  String? text;
  SearchItemEvent({
    required this.text,
    required this.number
  });
}

class SaveImageEvent extends HandlePicturesEvent {
  String uri;
  SaveImageEvent({
    required this.uri,
  });
}

class CreatDatabaseEvent extends  HandlePicturesEvent{}

class InsertDatabaseEvent extends HandlePicturesEvent{
  String id1;
  String url;
  String status;
  InsertDatabaseEvent({
    required this.id1,
    required this.url,
    required this.status,
});
}

class GetDatabaseEvent extends HandlePicturesEvent{
  Database database;
  GetDatabaseEvent({required this.database});
}

class DeleteDatabaseEvent extends HandlePicturesEvent{
  int id;
  DeleteDatabaseEvent({required this.id});
}


