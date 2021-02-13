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
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void initState() {
    setState(() {
      selectedImageIndex = 0;
    });

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
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            task.title.replaceFirst(task.title[0], task.title[0].toUpperCase()),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'QuickSand',
                                fontWeight: FontWeight.w900,
                                color: Colors.green,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            task.subtitle.replaceFirst(task.title[0], task.title[0].toUpperCase()),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            task.timeDuration.toString(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            task.createdTime,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            task.repetition,
                          ),
                        ),
                      ],
                    ),
                  )
                      : SizedBox(),
                  user != null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          user.name,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          user.email,
                        ),
                      ),
                    ],
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

  Widget loadingAnimation() => Center(child: CupertinoActivityIndicator());
}
