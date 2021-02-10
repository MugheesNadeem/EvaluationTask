import 'file:///D:/TestApp/EvaluationTask/lib/model/data_models/task.dart';
import 'file:///D:/TestApp/EvaluationTask/lib/model/data_models/user.dart';
import 'package:flutter_app/model/data_models/task_image.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DataState {}

class InitialDataState extends DataState {}

class LoadingState extends DataState {}

class FailureState extends DataState {
  final String error;

  FailureState({this.error});
}

class ErrorFetchingData extends DataState {}

class FetchedImagesState extends DataState {
  final List<TaskImage> images;
  FetchedImagesState({this.images});
}

class FetchedUserState extends DataState {
  final User user;
  FetchedUserState({this.user});
}

class FetchedTaskState extends DataState {
  final Task task;
  FetchedTaskState({this.task});
}

