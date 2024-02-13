// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:voice_hub/core/colors.dart';
// import 'package:voice_hub/screens/home/widgets/image_container.dart';
// import 'package:voice_hub/screens/poems/add_poem.dart';
// import 'package:voice_hub/screens/search/search_screen.dart';
// import 'package:voice_hub/widgets/custom_tag.dart';

// class TopPoem extends StatelessWidget {
//   const TopPoem({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ImageContainer(
//       padding: EdgeInsets.all(20),
//       width: double.infinity,
//       height: MediaQuery.of(context).size.height * 0.45,
//       imageUrl:
//           'https://cdn.pixabay.com/photo/2018/03/19/18/20/tea-time-3240766_1280.jpg',
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           CustomTag(backgroundColor: AppColors.primaryColor, children: [
//             Text(
//               "Top pick of today, ",
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyMedium!
//                   .copyWith(color: Colors.white),
//             )
//           ]),
//           Text(
//             "Poem Title",
//             style: Theme.of(context).textTheme!.headlineSmall!.copyWith(
//                 fontWeight: FontWeight.bold, height: 1.25, color: Colors.black),
//           ),
//           TextButton(
//               style: TextButton.styleFrom(padding: EdgeInsets.zero),
//               onPressed: () {
//                 print('pressed');
//                 Get.to(AddPoemScreen(imageUrl: ''));
//               },
//               child: Row(
//                 children: [
//                   Text(
//                     "Read This  ",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyLarge!
//                         .copyWith(color: AppColors.primaryColor),
//                   ),
//                   SizedBox(
//                     width: 2,
//                   ),
//                   Icon(Icons.arrow_right_alt)
//                 ],
//               ))
//         ],
//       ),
//     );
//   }
// }