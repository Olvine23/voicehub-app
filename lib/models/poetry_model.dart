class PoetryModel {
  final String title;
  final String imageUrl;
  final String body;
  final String uploadedBy;

  PoetryModel({
    required this.title,
    required this.imageUrl,
    required this.body,
    required this.uploadedBy
  });

  // Convert PoetryModel to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'body': body,
      'uploadedBy': uploadedBy
    };
  }

    // Create a factory method to convert a Firestore document to a PoetryModel
  factory PoetryModel.fromMap(Map<String, dynamic> map) {
    return PoetryModel(
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      body: map['body'] ?? '', 
      uploadedBy: map['uploadedBy'] ?? '',
    );
  }
}
