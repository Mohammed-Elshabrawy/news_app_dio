import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app_dio/shared/cubit/cubit.dart';

Widget newsItem(article, context) => Padding(
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
                  style:
                      NewsCubit.get(context).isDark == true
                          ? TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          )
                          : TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
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
        itemBuilder:
            (BuildContext context, int index) => newsItem(list[index], context),
        separatorBuilder: (BuildContext context, int index) => mySeparator(),
        itemCount: list.length,
      ),
  fallback: (context) => const Center(child: CircularProgressIndicator()),
);

Widget defaultFormFiled({
  bool readOnly = false,
  onTab,
  onSubmit,
  onChange,
  labelStyle,
  textStyle,
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator<String> validate,
  required String label,
  required IconData prefix,
}) => TextFormField(
  style: textStyle,
  readOnly: readOnly,
  onTap: onTab,
  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  validator: validate,
  decoration: InputDecoration(
    labelStyle: labelStyle,
    labelText: label,
    prefixIcon: Icon(prefix), // Icon
    border: OutlineInputBorder(),
  ), // InputDecoration
);

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
