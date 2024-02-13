import 'package:flutter/material.dart';
import 'package:voice_hub/core/colors.dart';
import 'package:voice_hub/screens/home/widgets/image_container.dart';

import '../../../models/article_model.dart';

class MostRecent extends StatelessWidget {
  const MostRecent({
    super.key,
    required this.articles,
  });

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
                Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Articles', style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
                  Icon(Icons.arrow_forward, color: AppColors.secondaryColor, size:30)
                ],
              
              ),
            ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    margin: EdgeInsets.only(right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageContainer(
                            width: MediaQuery.of(context).size.width * 0.5,
                            imageUrl: articles[index].imageUrl),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          articles[index].title,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            '${DateTime.now().difference(articles[index].createdAt).inHours} hours ago',
                            style: Theme.of(context).textTheme.bodySmall),
                             SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                    'Uploaded by ${articles[index].author}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold))),
                            Expanded(
                                child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.purple,
                              backgroundImage: NetworkImage(articles[index].authorImageUrl),
                            ))
                          ],
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

