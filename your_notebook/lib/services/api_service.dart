import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:your_notebook/models/item_model.dart';

class ApiService {
  final String apiUrl = 'https://637f5cd65b1cc8d6f942aebf.mockapi.io/food'; // Public API for images

  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      return json.map((data) => Item.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
}
