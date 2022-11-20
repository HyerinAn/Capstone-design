import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/constants.dart';

class PopularMarket_List extends StatelessWidget {
  const PopularMarket_List({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          PopularMarketList(
            image: "assets/images/mart1.png",
            press: (){},
          ),
          PopularMarketList(
            image: "assets/images/mart2.png",
            press: (){},
          ),
        ],
      ),
    );
  }
}

class PopularMarketList extends StatelessWidget {
  const PopularMarketList({
    Key? key,
    required this.image,
    required this.press,

  }) : super(key: key);

  final String image;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(
            left: kDefaultPadding,
            top: kDefaultPadding / 2,
            bottom: kDefaultPadding / 2),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(image),
            )
        ),
      ),
    );
  }
}

