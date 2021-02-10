import 'dart:convert';
import 'package:flutter_app/model/api_responses/GetImagesApiResponse.dart';
import 'package:http/http.dart' as http;

class GetImagesApiProvider {
  fetchData() async {
    try {
      List list = new List();
      final response = await http.get("https://jsonplaceholder.typicode.com/photos");
      if (response.statusCode == 200) {
        list = json.decode(response.body) as List;
        return GetImagesApiResponse.fromJson(list);
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      print('Get Overview response: ${e.response?.data ?? e.toString()}');
    }
  }
}