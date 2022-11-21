import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'categories.dart';
import 'marketInfo.dart';

class Body extends StatelessWidget {

  CollectionReference product = FirebaseFirestore.instance.collection('receipts');
  var numofmarkets;
  var marketnameList = [];
  var priceList = [];


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
                child: StreamBuilder(
                  stream: product.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    // 찾고자 하는 상품명이 있는 마트명만 나열되도록 검사
                    numofmarkets = streamSnapshot.data?.docs.length ?? 0; // null safety check 해야함
                    for(int i = 0 ; i < numofmarkets ; i++){
                      if(streamSnapshot.data?.docs[i]['productname'] == "매일우유"){
                        marketnameList.add(streamSnapshot.data?.docs[i]['marketname']);
                        priceList.add(streamSnapshot.data?.docs[i]['price']);
                      }
                      // marketnameList.toSet();
                      // priceList.toSet();
                    }
                    if (streamSnapshot.hasData) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: kDefaultPadding,
                          crossAxisSpacing: kDefaultPadding,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: marketnameList.length, //streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                            return MartInfo(
                                name: marketnameList[index],
                                price: priceList[index],
                                // name: documentSnapshot['marketname'],
                                // price: documentSnapshot['price'],
                                press: () {}
                            );
                          },
                      );
                    }
                    return Center();
                  },
                ),
              ),
            )

      ],
    );
  }
}

