import 'dart:convert';

import 'package:e_cars_ui/Models/carModel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://app-naa.herokuapp.com/api/'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new CardModel.fromJson(job)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Users');
    }
  }
}
 
//   Future<CardModel> fetchInfo() async {
//     final response =
//         await http.get(Uri.parse('https://app-naa.herokuapp.com/api/'));
//     final jsonresponse = json.decode(response.body);

//     return CardModel.fromJson(jsonresponse);
//   }
// }
