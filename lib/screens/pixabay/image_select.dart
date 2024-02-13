import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_hub/core/colors.dart';
import 'package:voice_hub/screens/home/home_screen.dart';
import 'package:voice_hub/screens/poems/add_poem.dart';

import '../../controllers/pixabay/pixabay_controller.dart';

class PixabayImageSelector extends StatelessWidget {
  
  final PixabayController pixabayController = Get.put(PixabayController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: AppColors.primaryColor,
        title: Text('Attach an Image', style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: pixabayController.searchController,
              decoration: InputDecoration(
                labelText: 'Search for Images',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    
                    pixabayController.searchImages(searchTerm: pixabayController.searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: pixabayController.imageUrls.length,
                itemBuilder: (context, index) {
                  final imageUrl = pixabayController.imageUrls[index];
                  return GestureDetector(
                    onTap: () {
                      print(imageUrl);
                      Get.off(AddPoemScreen(imageUrl: imageUrl));
                      Get.snackbar("Success", "selected image url: $imageUrl");
                      // Handle image selection (you can pass the selected URL back to the calling screen)
                      // Get.back(result: imageUrl);
                    },
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 