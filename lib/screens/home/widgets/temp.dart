  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_hub/core/colors.dart';
import 'package:voice_hub/models/poetry_model.dart';
import 'package:voice_hub/screens/home/home.dart';
import 'package:voice_hub/screens/home/widgets/image_container.dart';
import 'package:voice_hub/screens/home/widgets/most_recent.dart';
import 'package:voice_hub/screens/poems/add_poem.dart';
import 'package:voice_hub/screens/poems/poems_list_screen.dart';
import 'package:voice_hub/screens/profile/profile_screen.dart';
import 'package:voice_hub/screens/search/search_screen.dart';
import 'package:voice_hub/services/authservice.dart';
import 'package:voice_hub/widgets/bottom_navbar.dart';
 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  
}

class _HomeScreenState extends State<HomeScreen> {

  //sets icons for the  bottom navbar 
  

  List<Map> navigationBarItems = [
  {'icon': Icons.home, 'index': 0},
  {'icon': Icons.calendar_today, 'index': 1},
  {'icon': Icons.chat_bubble_rounded, 'index': 2},
  {'icon': Icons.person, 'index': 3}
];

//checks currently selected icon
int selectedIndex = 0;

  final AuthService authService = AuthService();

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

  @override
  Widget build(BuildContext context) {

    List<Widget> screens = [

      Home(),
      SearchScreen(),
      PoemListScreen(),
      ProfileScreen()

    ];
    print(currentUserDetails?['email']);
    print(currentUserDetails?['phone']);

    print(FirebaseAuth.instance.currentUser?.uid);
    var user = FirebaseAuth.instance.currentUser?.email;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
          child: Icon(Icons.add),
          onPressed: () {}),
      bottomNavigationBar: BottomNavigationBar(items: [
        for(var navItem in navigationBarItems)
        BottomNavigationBarItem(icon: Container(
          height: 20,
          decoration: BoxDecoration(
             border: Border(
                      top: selectedIndex == navItem['index']
                          ? BorderSide(
                              color:AppColors.primaryColor, width: 5)
                          : BorderSide.none,
                    ),
          ),

          child: Icon(navItem['icon'], color: selectedIndex == 0 ? AppColors.primaryColor : Colors.black),
        ),
        label: ''
        ),
        
      ],
currentIndex: selectedIndex,
onTap: (value) => setState((){

  selectedIndex = value;

}),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(AddPoemScreen(
                imageUrl: '',
              ));
            },
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(currentUserDetails?['image']),
            ),
          )
        ],
        title: Image.asset('assets/images/voicehub.png', 
        height: 100,),
        elevation: 0,
      ),
      body: SafeArea(child: screens[selectedIndex]),
      // extendBodyBehindAppBar: true,
      // body: ListView(
      
      //   padding: EdgeInsets.zero,
      //   children: [
      //      Text(
      //         'Hello, ${currentUserDetails!['nickname']}',
      //         style: TextStyle(  fontWeight: FontWeight.bold),
      //       ),
      //     // Padding(
      //     //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
      //     //   child: DiscoverNews(),
      //     // ),

      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: ImageContainer(
      //           padding: EdgeInsets.symmetric(horizontal: 20),
      //           height: 200,
      //           width: double.infinity,
      //           imageUrl:
      //               'https://images.pexels.com/photos/247314/pexels-photo-247314.jpeg?cs=srgb&dl=pexels-pixabay-247314.jpg&fm=jpg'),
      //     ),
      //     // const TopPoem(),
      //     StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      //         stream:
      //             FirebaseFirestore.instance.collection('poems').snapshots(),
      //         builder: (context,
      //             AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //           if (snapshot.connectionState == ConnectionState.waiting) {
      //             return Center(
      //               child: CircularProgressIndicator(),
      //             );
      //           } else if (snapshot.hasError) {
      //             return Center(
      //               child: Text("Error ${snapshot.error}"),
      //             );
      //           } else {
      //             List<QueryDocumentSnapshot<Map<String, dynamic>>> poems =
      //                 snapshot.data!.docs;

      //             return Padding(
      //               padding: EdgeInsets.all(20),
      //               child: Column(
      //                 children: [
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Text(
      //                         "Most Recent",
      //                         style: Theme.of(context)
      //                             .textTheme
      //                             .headlineSmall!
      //                             .copyWith(fontWeight: FontWeight.bold),
      //                       ),
      //                       InkWell(
      //                           onTap: () {},
      //                           child: Text("More",
      //                               style:
      //                                   Theme.of(context).textTheme.bodyLarge)),
      //                     ],
      //                   ),
      //                   SizedBox(
      //                     height: 3,
      //                   ),
      //                   SizedBox(
      //                     height: 250,
      //                     child: ListView.builder(
      //                         scrollDirection: Axis.horizontal,
      //                         itemCount: poems.length,
      //                         itemBuilder: (context, index) {
      //                           PoetryModel poem =
      //                               PoetryModel.fromMap(poems[index].data()!);
      //                           return Container(
      //                             width:
      //                                 MediaQuery.of(context).size.width * 0.5,
      //                             margin: EdgeInsets.only(right: 15),
      //                             child: Column(
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.start,
      //                               children: [
      //                                 ImageContainer(
      //                                     width: MediaQuery.of(context)
      //                                             .size
      //                                             .width *
      //                                         0.5,
      //                                     imageUrl: poem.imageUrl),
      //                                 Text(
      //                                   poem.title,
      //                                   style: Theme.of(context)
      //                                       .textTheme
      //                                       .bodyLarge!
      //                                       .copyWith(
      //                                           fontWeight: FontWeight.bold),
      //                                 ),
      //                                 Row(
      //                                   children: [
      //                                     Expanded(
      //                                         child: Text(
      //                                             'Uploaded by ${poem.uploadedBy}',
      //                                             style: Theme.of(context)
      //                                                 .textTheme
      //                                                 .bodySmall!
      //                                                 .copyWith(
      //                                                     fontWeight: FontWeight
      //                                                         .bold))),
      //                                     Expanded(
      //                                         child: CircleAvatar(
      //                                       radius: 25,
      //                                       backgroundColor: Colors.purple,
      //                                       backgroundImage: NetworkImage(
      //                                           currentUserDetails!['image']),
      //                                     ))
      //                                   ],
      //                                 )
      //                               ],
      //                             ),
      //                           );
      //                         }),
      //                   )
      //                 ],
      //               ),
      //             );
      //           }
      //         }),

      //     // MostRecent(
      //     //   articles: Article.articles,
      //     // )
      //   ],
      // ),
      // body:  Center(child:
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Text("Logged in as ... $user"),
      //     ElevatedButton(onPressed: (){

      //       Get.to(AddPoemScreen(imageUrl: '',));

      //     }, child: Text("Add a poem")),

      //      ElevatedButton(onPressed: (){

      //       Get.to(ProfileScreen());

      //     }, child: Text("See profile")),

      //      ElevatedButton(onPressed: (){

      //       Get.to(BioPreferencesScreen());

      //     }, child: Text("See my details")),
      //     ElevatedButton(onPressed: (){

      //       Get.to(PixabayImageSelector());

      //     }, child: Text("See photos")),

      //     ElevatedButton(onPressed: (){

      //       Get.to( LoadingScreen());

      //     }, child: Text("See poems")),

      //   ],
      // ),)
    );
  }
}
