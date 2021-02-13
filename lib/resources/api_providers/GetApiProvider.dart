import 'dart:convert';
import 'package:http/http.dart' as http;

class GetApiProvider {
  Future<List> fetchData(String path) async {
    try {
      List list = new List();
      const _baseUrl = 'jsonplaceholder.typicode.com';
      Uri uri = Uri.https(_baseUrl, path);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        list = json.decode(response.body) as List;
        return list;
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print('Get Overview response: ${e.response?.data ?? e.toString()}');
    }
    return null;
  }
}