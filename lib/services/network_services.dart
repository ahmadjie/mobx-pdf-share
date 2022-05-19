import 'dart:convert';

import 'package:creditest/models/listphotos.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  Future<List<ListPhotos>> getListData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // print(body);
      List<ListPhotos> data = (body as List).map((json) {
        return ListPhotos.fromJson(json);
      }).toList();
      return data;
    }
    return <ListPhotos>[];
  }
}
