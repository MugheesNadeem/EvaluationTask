import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_app/model/api_responses/GetImagesApiResponse.dart';
import 'package:flutter_app/model/data_models/task.dart';
import 'package:flutter_app/model/data_models/task_image.dart';
import 'package:flutter_app/model/data_models/user.dart';
import 'package:flutter_app/resources/repository.dart';
import 'package:flutter_app/utils/helper_functions.dart';
import './bloc.dart';

class DataBloc extends Bloc<DataBlocEvent, DataBlocState> {
  Repository repository = Repository();

  DataBloc() : super(InitialDataState());

  @override
  DataBlocState get initialState => InitialDataState();

  @override
  Stream<DataBlocState> mapEventToState(
      DataBlocEvent event,
      ) async* {
    if (event is FetchImagesEvent) {
      bool connectivityCheck = await checkConnection();
      if (connectivityCheck) {
        try {
          yield LoadingState();
          List getApiResponse = await repository.getData('/photos');
          List<TaskImage> taskImages = [];
          for (int i = 0; i < 5; i++) {
            taskImages.add(TaskImage(taskImage: getApiResponse[i]['url']));
          }
          yield FetchedImagesState(images: taskImages);
        } catch (e) {
          yield FailureState(error: e.toString());
        }
      } else {
        yield FailureState(error: 'Error Connecting');
      }
    }

    if (event is FetchTaskEvent) {
      bool connectivityCheck = await checkConnection();
      if (connectivityCheck) {
        try {
          yield LoadingState();
          List getApiResponse = await repository.getData('/posts');
          Task task = new Task(
            title: getApiResponse[0]['title'],
            subtitle: getApiResponse[0]['body'],
            timeDuration: getApiResponse[0]['id'],
            createdTime: getApiResponse[1]['title'],
            repetition: getApiResponse[1]['body'],
          );
          yield FetchedTaskState(task: task);
        } catch (e) {
          yield FailureState(error: e.toString());
        }
      } else {
        yield FailureState(error: 'Error Connecting');
      }
    }

    if (event is FetchUserEvent) {
      bool connectivityCheck = await checkConnection();
      if (connectivityCheck) {
        try {
          yield LoadingState();
          List getApiResponse = await repository.getData('/users');
          User user = new User(
            name: getApiResponse[0]['name'],
            email: getApiResponse[0]['email'],
          );
          yield FetchedUserState(user: user);
        } catch (e) {
          yield FailureState(error: e.toString());
        }
      } else {
        yield FailureState(error: 'Error Connecting');
      }
    }
  }
}
