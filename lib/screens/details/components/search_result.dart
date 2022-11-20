import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/constants.dart';
import 'body.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: (){},
            icon: Icon(CupertinoIcons.back),
          iconSize: 30,
          color: kPrimaryColor,),
      ),
      body: Body(),

    );
  }



  }




