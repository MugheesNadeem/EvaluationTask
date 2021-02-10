import 'package:flutter_app/model/data_models/task_image.dart';

class GetImagesApiResponse {
  List<TaskImage> taskImages;

  GetImagesApiResponse(this.taskImages);

  GetImagesApiResponse.fromJson(List json) {
    if (taskImages != null && taskImages.length > 0) {
      for (int i = 0; i < 5; i++) {
        print('Image 1 : ${json[i]['url']}');
        this.taskImages.add(json[i]['url']);
      }
    }
  }
}