import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voice_hub/controllers/poem_controller.dart';
import 'package:voice_hub/models/poetry_model.dart';
import 'package:voice_hub/services/authservice.dart';

class RealTimePoemListScreen extends StatefulWidget {
  @override
  _RealTimePoemListScreenState createState() => _RealTimePoemListScreenState();
}

class _RealTimePoemListScreenState extends State<RealTimePoemListScreen> {
  final PoemController poemController = PoemController();
   String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 18) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  Map<String, dynamic>? currentUserDetails;
  final AuthService authService = AuthService();
  Future<void> loadCurrentUserDetails() async {
    Map<String, dynamic>? details = await authService.getCurrentUserDetails();

    setState(() {
      currentUserDetails = details;
    });
  }

  @override
  void initState() {
    super.initState();
    poemController.fetchPoems();
    loadCurrentUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: FutureBuilder<int>(
      //     future: poemController.getPoemListLength(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Text('Real-Time Poem List (Loading...)');
      //       } else if (snapshot.hasError) {
      //         return Text('Error: ${snapshot.error}');
      //       } else {
      //         return Text('Real-Time Poem List (${snapshot.data})');
      //       }
      //     },
      //   ),
      // ),
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

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                       
                        color: Colors.white, // Adjust the color as needed
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // User Profile Photo and Name
                            Row(
                              children: [
                                currentUserDetails != null
                                    ? CircleAvatar(
                                        radius: 30,
                                        // Use the user's actual profile photo or a placeholder
                                        backgroundImage: NetworkImage(
                                            currentUserDetails!['image']),
                                      )
                                    : CircleAvatar(
                                        radius: 30,
                                        // Use the user's actual profile photo or a placeholder
                                        backgroundImage: NetworkImage(
                                            'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png'),
                                      ),
                                SizedBox(width: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getGreeting(),
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      currentUserDetails![
                                          'nickname'], // Replace with the actual user's name
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.insert_link)
                    ],
                  ),
                ),
                CarouselSlider.builder(
                  itemCount: poems.length,
                  itemBuilder: (context, index, realIndex) {
                    PoetryModel poem = poems[index];

                    return Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: NetworkImage(poem
                              .imageUrl), // Use the actual field for image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              color: Colors.black.withOpacity(0.5),
                              child: Text(
                                poem.title, // Use the actual field for the poem title
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 250,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      // Handle page change if needed
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> _deletePoem(PoetryModel poem) async {
    try {
      // Delete the poem from Firestore
      await FirebaseFirestore.instance
          .collection('poems')
          .doc(poem.uploadedBy)
          .delete();

      // Show a snackbar to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Poem deleted'),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () async {
              // Implement undo logic if needed
              await FirebaseFirestore.instance
                  .collection('poems')
                  .add(poem.toMap());
            },
          ),
        ),
      );
    } catch (e) {
      print("Error deleting poem: $e");
    }
  }

  @override
  void dispose() {
    poemController.dispose();
    super.dispose();
  }
}
