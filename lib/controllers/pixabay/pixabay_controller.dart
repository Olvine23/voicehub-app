import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PixabayController extends GetxController {
  RxList<String> imageUrls = <String>[].obs;
  TextEditingController searchController = TextEditingController();

  Future<void> searchImages({required String searchTerm}) async {
    final unsplashAccessKey = 'muE4e8WRTaw1wWdADHlOGyJXUyTxHM4hIKv5ZKgRpoI';
    final unsplashApiUrl = 'https://api.unsplash.com/search/photos';
    final Map<String, String> queryParameters = {
      'query': searchTerm,
      'client_id': unsplashAccessKey,
       'per_page': 50.toString(), // Set the number of results per page
    };
    

    final response = await http.get(Uri.parse('$unsplashApiUrl?${Uri(queryParameters: queryParameters).query}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final List<String> urls = (data['results'] as List<dynamic>).map((dynamic item) {
        return item['urls']['regular'].toString();
      }).toList();

      imageUrls.assignAll(urls);
    } else {
      print('Failed to load images: ${response.reasonPhrase}');
    }
  }
}
 