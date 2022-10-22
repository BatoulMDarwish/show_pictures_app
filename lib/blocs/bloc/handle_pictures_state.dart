part of 'handle_pictures_bloc.dart';

@immutable
abstract class HandlePicturesState {}

class HandlePicturesInitial extends HandlePicturesState {}

class ChangeBottomNavBarState extends HandlePicturesState {}

class LoadingPhotoState extends HandlePicturesState {}

class GetSuccessPhotoState extends HandlePicturesState {}

class GetErrorPhotoState extends HandlePicturesState {}

class SaveImageSuccessState extends HandlePicturesState {}

class SaveImageErrorState extends HandlePicturesState {}

class SearchLoadingState extends HandlePicturesState {}

class SearchSuccessState extends HandlePicturesState {}

class SearchErrorState extends HandlePicturesState {}

class CreatDatabaseState extends HandlePicturesState{}

class InsertDatabaseState extends HandlePicturesState{}

class GetDatabaseState extends HandlePicturesState{}

class DeleteDatabaseState extends HandlePicturesState{}