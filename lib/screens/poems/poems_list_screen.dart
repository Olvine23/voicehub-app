import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voice_hub/controllers/poetry_controller.dart';
import 'package:voice_hub/models/poetry_model.dart';
 
 

class PoemListScreen extends StatelessWidget {
  final PoetryController poetryController = PoetryController();

  PoemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poem List'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('poems').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Data is ready
            List<QueryDocumentSnapshot<Map<String, dynamic>>> poems = snapshot.data!.docs;

            return ListView.builder(
              itemCount: poems.length,
              itemBuilder: (context, index) {
                PoetryModel poem = PoetryModel.fromMap(poems[index].data()!);

                return ListTile(
                  title: Text(poem.title),
                  subtitle: Text(poem.body),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(poem.imageUrl),
                    radius: 30,
                  ),
                  onTap: () {
                   
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
