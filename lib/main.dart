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
    PageController _myPage = PageController(initialPage: 0);

    return MultiBlocProvider(
      providers: [
        BlocProvider<DataBloc>(
          create: (BuildContext context) =>
          new DataBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          bottomNavigationBar: BottomAppBar(
            child: Expanded(
              child: Container(
                color: Color(0xFF2E2E2E),
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    iconButton(CupertinoIcons.calendar),
                    showDivider(),
                    iconButton(CupertinoIcons.bag),
                    showDivider(),
                    iconButton(CupertinoIcons.chat_bubble_text),
                    showDivider(),
                    iconButton(CupertinoIcons.bell),
                    showDivider(),
                    iconButton(Icons.more_horiz)
                  ],
                ),
              ),
            ),
          ),
          body: PageView(
            controller: _myPage,
            onPageChanged: (int) {
              print('Page Changes to index $int');
            },
            children: <Widget>[
              MainScreen(),
              Center(
                child: Container(
                  child: Text('Empty Body 1'),
                ),
              ),
              Center(
                child: Container(
                  child: Text('Empty Body 2'),
                ),
              ),
              Center(
                child: Container(
                  child: Text('Empty Body 3'),
                ),
              )
            ],
            physics: NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
          ),
        ),
      ),
    );
  }

  Widget iconButton(IconData iconData) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: IconButton(
        iconSize: 30.0,
        icon: Icon(
          iconData,
          color: Color(0xFF9298A2),
        ),
      ),
    );
  }

  Widget showDivider() {
    return Container(
        height: 30,
        width: 1,
        color: Color(0xFF9298A2)
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

