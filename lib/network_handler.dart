import 'package:http/http.dart' as http;
import 'dart:convert';


class NetworkHandler {
  final String apiKey = 'ebd1ffe83ffc4adcb0e58ba7504421b7';
  String? country;
  String? category;

  NetworkHandler({required this.country,required this.category});

  Future<Map> getNews() async {
    http.Response response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=$apiKey'));
    var res = jsonDecode(response.body);
    return res;
  }

}