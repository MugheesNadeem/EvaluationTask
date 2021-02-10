import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/data_bloc.dart';
import 'package:flutter_app/bloc/data_event.dart';
import 'package:flutter_app/model/data_models/task_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/data_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<TaskImage> taskImages = new List();
  DataBloc _dataBloc;

  @override
  void initState() {
    _dataBloc = DataBloc();
    _dataBloc.add(FetchImagesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: getWidget()),
    );
  }

  Widget getWidget() {
    return BlocListener(
        cubit: _dataBloc,
        listener: (context, state) {
          if (state is FetchedImagesState) {
            taskImages = state.images;
          }
        },
      child: BlocBuilder(
        cubit: _dataBloc,
        builder: (BuildContext context, DataState state) {
          return Container(
            child: Center(
              child: Text(
                'Test',
              ),
            ),
          );
        },
      ),
    );
    // return BlocConsumer<DataBloc, DataState>(
    //   listener: (BuildContext context, DataState state) {
    //     if (state is ErrorFetchingData) {
    //     } else if (state is FetchedImagesState) {
    //       taskImages = state.images;
    //     }
    //   },
    //   builder: (BuildContext context, DataState state) {
    //     return Container(
    //       child: Center(
    //         child: Text(
    //           taskImages[0].taskImage,
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}

