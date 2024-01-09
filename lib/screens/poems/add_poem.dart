import 'package:flutter/material.dart';
import 'package:get/get.dart';
 

import '../../controllers/poetry_controller.dart';

class AddPoemScreen extends StatelessWidget {
  final PoetryController poetryController = PoetryController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Poem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(labelText: 'Body'),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => addPoem(),
              child: Text('Add Poem'),
            ),
          ],
        ),
      ),
    );
  }

  void addPoem() {
    poetryController.addPoem(
      title: titleController.text.trim(),
      imageUrl: imageUrlController.text.trim(),
      body: bodyController.text.trim(),
    );

    // You can navigate back to the previous screen or perform other actions here.
    // For example: Get.back();
  }
}
