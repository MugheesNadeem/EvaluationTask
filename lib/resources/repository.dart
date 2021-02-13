import 'api_providers/GetApiProvider.dart';

class Repository {

  Future<List> getData(String path) async {
    GetApiProvider _apiProvider = new GetApiProvider();
    return _apiProvider.fetchData(path);
  }

}