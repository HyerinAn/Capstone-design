import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/constants.dart';

import 'categories.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
    child: Center(
      child: Container(
      padding: EdgeInsets.only(top: kDefaultPadding - 8,left: kDefaultPadding + 25),
      height: 50,
      width: 300,
      decoration: BoxDecoration(
      color: kPrimaryColor,
      borderRadius: BorderRadius.circular(50)),

            child: Text(
              "구매 가능 매장 검색 결과",
              style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      ),
      ),
            ),
    ),
        ),
        Categories(),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: GridView.builder(
                itemCount: 6, // 상품이 등록된 마트 개수
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: kDefaultPadding,
                    crossAxisSpacing: kDefaultPadding,
                    childAspectRatio: 0.75,
        ),
                  itemBuilder: (context, index) => MartInfo(martname: "martname", price: "price", press: (){})),
            )
         )

      ],
    );
  }
}

class MartInfo extends StatelessWidget {
  final String martname;
  final String price;
  final void Function() press;
  const MartInfo({
    Key? key,
    required this.martname,
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
            child: Text(martname,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20, fontWeight: FontWeight.bold
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