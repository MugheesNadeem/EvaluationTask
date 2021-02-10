import 'package:flutter_app/model/api_responses/GetImagesApiResponse.dart';

import 'api_providers/GetImageApiProvider.dart';

class Repository {

  Future<GetImagesApiResponse> getTaskImages() async {
    GetImagesApiProvider _apiProvider = new GetImagesApiProvider();
    return _apiProvider.fetchData();
  }

}