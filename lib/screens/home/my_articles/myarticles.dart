import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voice_hub/core/colors.dart';
import 'package:voice_hub/models/poetry_model.dart';
import 'package:voice_hub/screens/home/widgets/image_container.dart';

class MyArticles extends StatelessWidget {
  const MyArticles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('poems').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error ${snapshot.error}"),
            );
          } else {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> poems =
                snapshot.data!.docs;
            final height = MediaQuery.of(context).size.height / 2 - 130;
            return SizedBox(
              height: height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: poems.length,
                itemBuilder: (context, index) {
                  PoetryModel poem = PoetryModel.fromMap(poems[index].data()!);
                  return Container(
                    height: height,
                    width: MediaQuery.of(context).size.width * 0.5,
                    margin: EdgeInsets.only(right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        poem.imageUrl == ''
                            ? ImageContainer(
                                width: MediaQuery.of(context).size.width * 0.45,
                                imageUrl:
                                    'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
                              )
                            : ImageContainer(
                                width: MediaQuery.of(context).size.width * 0.45,
                                imageUrl: poem.imageUrl,
                              ),
                              SizedBox(height: 8,),
                        Text(
                          
                          poem.title,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height:8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                             CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.primaryColor,
                              ),

                              SizedBox(width: 8,),
                            Expanded(
                              child: Text(
                                poem.uploadedBy,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
