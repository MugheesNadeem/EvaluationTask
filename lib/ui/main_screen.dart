import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc.dart';
import 'package:flutter_app/bloc/data_bloc.dart';
import 'package:flutter_app/model/data_models/task.dart';
import 'package:flutter_app/model/data_models/task_image.dart';
import 'package:flutter_app/model/data_models/user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DataBloc dataBloc;
  List<TaskImage> taskImages = [];
  User user;
  Task task;
  int selectedImageIndex;
  bool showTimer;
  bool timerEnded;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 20;

  @override
  void initState() {
    setState(() {
      selectedImageIndex = 0;
    });
    showTimer = false;
    timerEnded = false;

    dataBloc = new DataBloc();
    dataBloc.add(FetchImagesEvent());
    dataBloc.add(FetchTaskEvent());
    dataBloc.add(FetchUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DataBloc, DataBlocState>(
      cubit: dataBloc,
      listener: (context, state) {
        if (state is FetchedTaskState) {
          setState(() {
            task = state.task;
          });
        }

        if (state is FetchedUserState) {
          setState(() {
            user = state.user;
          });
        }

        if (state is FetchedImagesState) {
          setState(() {
            if(state.images != null && state.images.length > 0)
              taskImages = state.images;
          });
        }
      },
      child: BlocBuilder(
        cubit: dataBloc,
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is LoadingState,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                          child: CarouselSlider(
                            options: CarouselOptions(
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 5),
                                autoPlayAnimationDuration: Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: false,
                                scrollDirection: Axis.horizontal,
                                viewportFraction: 1,
                                initialPage: selectedImageIndex,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    selectedImageIndex = index;
                                  });
                                }
                            ),
                            items: taskImages.map((item) =>
                                Container(
                                  width: SizeConfig.screenWidth,
                                  child: Image.network(item.taskImage, fit: BoxFit.fill, width: double.infinity),
                                )).toList(),
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: taskImages.map((taskImage) {
                          int index = taskImages.indexOf(taskImage);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedImageIndex == index
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  task != null
                      ? Container(
                    padding: EdgeInsets.fromLTRB(24, 6, 24, 0),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTextBox(
                          task.title,
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'QuickSand',
                            fontWeight: FontWeight.w900,
                            color: Colors.green,
                          ),
                        ),
                        getTextBox(
                          task.subtitle,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Icon(
                                  CupertinoIcons.calendar,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getTextBox(
                                      task.createdTime,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    getTextBox(
                                      task.repetition,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                      : SizedBox(),
                  user != null
                      ? Expanded(
                    child: Card(
                      elevation: 4,
                      child: Container(
                        width: double.infinity,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(24, 10, 18, 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 6, right: 18),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: taskImages != null && taskImages.length > 0
                                          ? Image.network(
                                        taskImages[0].taskImage,
                                        width: 60,
                                        height: 60,
                                      )
                                          : Icon(CupertinoIcons.info),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        getTextBox(
                                          user.name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        getTextBox(
                                          user.email,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    height: 40,
                                    width: 40,
                                    child: Icon(
                                      CupertinoIcons.chat_bubble_text,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  height: 1,
                                  margin: const EdgeInsets.symmetric(vertical: 15.0),
                                  width: double.infinity,
                                  color: Colors.grey),
                              showTimer
                                  ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'TIMER',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  CountdownTimer(
                                    endTime: endTime,
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.orange
                                    ),
                                    onEnd: () {
                                      setState(() {
                                        showTimer = false;
                                        timerEnded = true;
                                      });
                                      displayAlertDialog(context, 'Timer completed');
                                    },
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: Colors.black,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    height: 40,
                                    width: 40,
                                    child: Icon(
                                      CupertinoIcons.pause,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              )
                                  : getTextBox(
                                timerEnded
                                    ? 'The timer has ended'
                                    : 'Get your gear set up & ready to work.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Expanded(
                                child: Builder(
                                  builder: (context) {
                                    final GlobalKey<SlideActionState> _key = GlobalKey();
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
                                      child: SlideAction(
                                        sliderButtonIcon: Icon(
                                          Icons.arrow_forward,
                                          size: 30,
                                          color: timerEnded ? Colors.black : Color(0xFFE2E8ED),
                                        ),
                                        reversed: timerEnded,
                                        sliderButtonIconSize: 30,
                                        sliderButtonYOffset: -10,
                                        innerColor: timerEnded ? Color(0xFFE2E8ED) : Colors.black,
                                        outerColor: timerEnded ? Colors.black : Color(0xFFE2E8ED),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 24.0),
                                          child: Text(
                                            showTimer
                                                ? 'SLIDE TO END WORK'
                                                : 'SLIDE TO START WORK',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        key: _key,
                                        onSubmit: timerEnded
                                            ? () {}
                                            : () {
                                          Future.delayed(
                                            Duration(seconds: 3),
                                                () => _key.currentState != null ?? _key.currentState.reset(),
                                          );
                                          endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 20;
                                          setState(() {
                                            showTimer = true;
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                      : SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getTextBox(String inputText, {TextStyle style}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        inputText.replaceFirst(inputText[0], inputText[0].toUpperCase()),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    );
  }

  void displayAlertDialog(
      BuildContext context,
      String title,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
              )
          ),
          titlePadding: EdgeInsets.all(0),
          title: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            color: Color(0xFF2E2E2E),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/done.png',
                  height: 300,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                 'The timer has ended',
                 style: TextStyle(
                   color: Colors.white,
                   fontFamily: 'Montserrat',
                   fontWeight: FontWeight.w900,
                   fontSize: 18,
                 ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
