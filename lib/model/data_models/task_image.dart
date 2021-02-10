//Json/images

class TaskImage {
  String taskImage;

  TaskImage({this.taskImage});

  TaskImage.fromJson(Map<String, dynamic> json) {
     this.taskImage = json['url'];
  }
}