import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voice_hub/models/poetry_model.dart';
 

class PoemController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamController<List<PoetryModel>> _poemStreamController = StreamController<List<PoetryModel>>.broadcast();

  Stream<List<PoetryModel>> get poemStream => _poemStreamController.stream;

  void fetchPoems() {
    try {
      _firestore.collection('poems').snapshots().listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
        List<PoetryModel> poems = snapshot.docs.map((doc) => PoetryModel.fromMap(doc.data()!)).toList();
        _poemStreamController.add(poems);
      });
    } catch (e) {
      print("Error fetching poems: $e");
    }
  }

  Future<int> getPoemListLength() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('poems').get();

      return snapshot.size;
    } catch (e) {
      print("Error fetching poem list length: $e");
      return 0;
    }
  }

  void dispose() {
    _poemStreamController.close();
  }
}
