import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:voice_hub/core/colors.dart';
import 'package:voice_hub/models/article_model.dart';
import 'package:voice_hub/models/poetry_model.dart';
import 'package:voice_hub/screens/home/widgets/greetings.dart';
import 'package:voice_hub/screens/home/widgets/image_container.dart';
import 'package:voice_hub/screens/home/widgets/most_recent.dart';
import 'package:voice_hub/screens/home/widgets/row_title.dart';
import 'package:voice_hub/screens/home/widgets/top_poem.dart';
import 'package:voice_hub/screens/home/widgets/user_intro.dart';

import 'my_articles/myarticles.dart';

class Home extends StatelessWidget {
  Home({super.key});

  var str = """
  
  # ggg  
  ## This is a Heading 2
  This is a paragraph with some *italic* and **bold** text.
  - This is a bullet point
  - Another bullet point
  1. This is a numbered list
  2. Another numbered item
  
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 12),
            child: UserIntro(),
          ),
          Greetings(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const RowTitle(text: 'Recent Articles',),
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.arrow_forward,
                      color: AppColors.secondaryColor,
                      size: 30,
                    )),
              ],
            ),
          ),
        MyArticles(),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const RowTitle(text: 'My Articles',),
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.arrow_forward,
                      color: AppColors.secondaryColor,
                      size: 30,
                    )),
              ],
            ),
          ),
           MyArticles(),
          SizedBox(
            height: 300,
            child: Markdown(
              physics: ScrollPhysics(),
              data: str),
          ),
        ],
      ),
    ));
  }
}




