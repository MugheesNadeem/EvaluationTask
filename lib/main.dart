import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/data_bloc.dart';
import 'package:flutter_app/bloc/data_event.dart';
import 'package:flutter_app/model/data_models/task_image.dart';
import 'package:flutter_app/ui/main_screen.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<DataBloc>(
          create: (BuildContext context) =>
          new DataBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          // appBar: AppBar(
          //   title: Row(
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Icon(CupertinoIcons.house_fill),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Text('bnji.com'),
          //     ],
          //   ),
          //   centerTitle: true,
          // ),
          body: MainScreen(),
        ),
      ),
    );
  }

  Widget getWidget() {
    return Container(
      child: Center(
        child: Text(
          'Test',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}

