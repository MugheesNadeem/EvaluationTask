import 'package:flutter_app/model/data_models/task.dart';
import 'package:flutter_app/model/data_models/task_image.dart';
import 'package:flutter_app/model/data_models/user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DataBlocState {}

class InitialDataState extends DataBlocState {}

class LoadingState extends DataBlocState {}

class FailureState extends DataBlocState {
  final String error;

  FailureState({this.error});
}

class ErrorFetchingData extends DataBlocState {}

class FetchedImagesState extends DataBlocState {
  final List<TaskImage> images;
  FetchedImagesState({this.images});
}

class FetchedUserState extends DataBlocState {
  final User user;
  FetchedUserState({this.user});
}

class FetchedTaskState extends DataBlocState {
  final Task task;
  FetchedTaskState({this.task});
}

