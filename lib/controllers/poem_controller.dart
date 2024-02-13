import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voice_hub/models/poetry_model.dart';  
class PoemController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamController<List<PoetryModel>> _poemStreamController =
      StreamController<List<PoetryModel>>.broadcast();

  Stream<List<PoetryModel>> get poemStream => _poemStreamController.stream;

  StreamController<int> _poemListLengthController = StreamController<int>.broadcast();

  Stream<int> get poemListLengthStream => _poemListLengthController.stream;

  Future<void> deletePoem(PoetryModel poem) async {
  try {
    await _firestore.collection('poems').doc(poem.title).delete();
  } catch (e) {
    print("Error deleting poem: $e");
  }
}


  void fetchPoems() {
    try {
      final StreamSubscription<QuerySnapshot<Map<String, dynamic>>> subscription =
          _firestore.collection('poems').snapshots().listen(
                (QuerySnapshot<Map<String, dynamic>> snapshot) {
                  List<PoetryModel> poems =
                      snapshot.docs.map((doc) => PoetryModel.fromMap(doc.data()!)).toList();
                  _poemStreamController.add(poems);
                  _poemListLengthController.add(poems.length);
                },
                onError: (error) {
                  print("Error fetching poems: $error");
                },
              );

      // Dispose the subscription when the controller is disposed
      _poemStreamController.onCancel = () {
        subscription.cancel();
      };
    } catch (e) {
      print("Error fetching poems: $e");
    }
  }

  Future<int> getPoemListLength() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('poems').get();

      return snapshot.size;
    } catch (e) {
      print("Error fetching poem list length: $e");
      return 0;
    }
  }

  void dispose() {
    _poemStreamController.close();
    _poemListLengthController.close();
  }
}
