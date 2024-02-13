import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:voice_hub/screens/pixabay/image_select.dart';
import 'package:voice_hub/services/authservice.dart';
 

import '../../controllers/poetry_controller.dart';

class AddPoemScreen extends StatefulWidget {
  final String imageUrl;
  

AddPoemScreen({super.key, required this.imageUrl});

  @override
  
  State<AddPoemScreen> createState() => _AddPoemScreenState();
}

class _AddPoemScreenState extends State<AddPoemScreen> {
final AuthService authService = AuthService();
String description = 'My great package';

  Map<String, dynamic>? currentUserDetails;

  @override
  void initState() {
    super.initState();
    loadCurrentUserDetails();
  }

  Future<void> loadCurrentUserDetails() async {
    Map<String, dynamic>? details = await authService.getCurrentUserDetails();

    if (mounted) {
      setState(() {
        currentUserDetails = details;
      });
    }
  }

 PoetryController poetryController = PoetryController();

  TextEditingController titleController = TextEditingController();

TextEditingController imageUrlController = TextEditingController();

 TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(
      widget.imageUrl
    );
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
            SizedBox(height: 8),
            ElevatedButton(onPressed: (){
              Get.to(PixabayImageSelector());
            }, child: Text("Add  image")),
            SizedBox(height: 8),
            Text("Selected image: ${widget.imageUrl}"),
            MarkdownTextInput(
              controller: bodyController,
              (String value) => setState(() => description = value),
                          description,
            ),
            // TextField(
            //   controller: bodyController,
            //   decoration: InputDecoration(labelText: 'Body'),
            //   maxLines: 5,
            // ),
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
      imageUrl: widget.imageUrl,
      body: bodyController.text.trim(),
    );

    // You can navigate back to the previous screen or perform other actions here.
    // For example: Get.back();
  }
}
