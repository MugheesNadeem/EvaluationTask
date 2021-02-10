import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_app/model/api_responses/GetImagesApiResponse.dart';
import 'package:flutter_app/model/data_models/task_image.dart';
import 'package:flutter_app/resources/repository.dart';
import 'package:flutter_app/utils/helper_functions.dart';
import './bloc.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  Repository repository = Repository();

  DataBloc() : super(InitialDataState());

  @override
  DataState get initialState => InitialDataState();

  @override
  Stream<DataState> mapEventToState(
      DataEvent event,
      ) async* {
    if (event is FetchImagesEvent) {
      bool connectivityCheck = await checkConnection();
      if (connectivityCheck) {
        try {
          yield LoadingState();
          GetImagesApiResponse getImagesApiResponse = await repository.getTaskImages();
          List<TaskImage> taskImages = getImagesApiResponse.taskImages;
          yield FetchedImagesState(images: taskImages);
        } catch (e) {
          yield FailureState(error: e.toString());
        }
      } else {
        yield FailureState(error: 'Error Connecting');
      }
    }

    if (event is FetchedTaskState) {
      bool connectivityCheck = await checkConnection();
      if (connectivityCheck) {
        try {
          yield LoadingState();
          // Church church = await repository.getChurchById(event.churchId);
          yield FetchedTaskState();
        } catch (e) {
          yield FailureState(error: e.toString());
        }
      } else {
        yield FailureState(error: 'Error Connecting');
      }
    }

    if (event is FetchedUserState) {
      bool connectivityCheck = await checkConnection();
      if (connectivityCheck) {
        try {
          yield LoadingState();
          // Church church = await repository.getChurchById(event.churchId);
          yield FetchedUserState();
        } catch (e) {
          yield FailureState(error: e.toString());
        }
      } else {
        yield FailureState(error: 'Error Connecting');
      }
    }
  }
}
