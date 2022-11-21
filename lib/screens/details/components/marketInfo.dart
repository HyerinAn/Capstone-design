import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/constants.dart';
import 'categories.dart';


class MartInfo extends StatelessWidget {
  //final Market market;
  final String name, price;
  final void Function() press;
  const MartInfo({
    Key? key,
    //required this.market,
    required this.name,
    required this.price,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(kDefaultPadding),
          // height: 180,
          // width: 160,
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(16)
          ),
          child: Image.asset("assets/images/mart1.png"),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding/4),
            child: Text(name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15, //20
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        Center(
          child: Text(price + "원",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold),),
        )
      ],
    );
  }
}