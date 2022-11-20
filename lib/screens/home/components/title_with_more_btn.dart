import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/constants.dart';


class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    Key? key,
    required this.title,
    required this.press
  }) : super(key: key);

  final String title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: <Widget>[
          TitleWithCustomerUnderline(
              text: title),
          Spacer(),
          TextButton(
            onPressed: (){},
            style: TextButton.styleFrom(
              primary: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: kPrimaryColor,
            ),

            child: Text(
              "More",
              style: TextStyle(color: Colors.white),


            ),
          ),
        ],
      ),
    );
  }
}

class TitleWithCustomerUnderline extends StatelessWidget {
  const TitleWithCustomerUnderline({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(text,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: kDefaultPadding / 4),
              height: 7,
              color: kPrimaryColor.withOpacity(0.2),

            ),
          ),
        ],),
    );
  }
}
