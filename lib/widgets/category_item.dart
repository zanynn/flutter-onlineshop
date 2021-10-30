import 'package:flutter/material.dart';
import 'package:online_shop/constants.dart';

class CategoryItem extends StatelessWidget {
  final String image;
  final String name;

  const CategoryItem({this.image, this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            maxRadius: MediaQuery.of(context).size.height * 0.1 / 2.5,
            backgroundColor: kPrimaryColor,
            // backgroundColor: Color(color),
            child: Container(
              height: 45,
              child: Image(
                color: Colors.white,
                image: NetworkImage(image),
              ),
            ),
          ),
          Text(name)
        ],
      ),
    );
  }
}
