import 'package:flutter/material.dart';
import 'package:voice_hub/controllers/poem_controller.dart';
import 'package:voice_hub/models/poetry_model.dart';
 
class RealTimePoemListScreen extends StatefulWidget {
  @override
  _RealTimePoemListScreenState createState() => _RealTimePoemListScreenState();
}

class _RealTimePoemListScreenState extends State<RealTimePoemListScreen> {
  final PoemController poemController = PoemController();

  @override
  void initState() {
    super.initState();
    poemController.fetchPoems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real-Time Poem List'),
      ),
      body: StreamBuilder<List<PoetryModel>>(
        stream: poemController.poemStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<PoetryModel> poems = snapshot.data ?? [];

            return ListView.builder(
              itemCount: poems.length,
              itemBuilder: (context, index) {
                PoetryModel poem = poems[index];

                return ListTile(
                  title: Text(poem.title),
                  subtitle: Text(poem.body),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    poemController.dispose();
    super.dispose();
  }
}
