import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget newsItem(article,context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      ConditionalBuilder(
        condition: article['urlToImage'] != null,
        builder: (BuildContext context) {
          return Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("${article['urlToImage']}"),
              ),
            ),
          );
        },
        fallback: (BuildContext context) {
          return Container();
        },
      ),
      SizedBox(width: 10),
      Expanded(
        child: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  ' "${article['title']}"',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Text(
                "${article['publishedAt']}",
                style: TextStyle(color: Colors.grey), // TextStyle
              ), // Text
            ],
          ),
        ),
      ),
    ],
  ),
);

Widget mySeparator() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Divider(height: 1, color: Colors.grey),
);

Widget articleBuilder(list, context) => ConditionalBuilder(
  condition: list.length > 0,
  builder:
      (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => newsItem(list[index],context),
        separatorBuilder: (BuildContext context, int index) => mySeparator(),
        itemCount: list.length,
      ),
  fallback: (context) => const Center(child: CircularProgressIndicator()),
);
