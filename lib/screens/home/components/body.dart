//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/constants.dart';

import 'header_with_searchbox.dart';
import 'title_with_more_btn.dart';
import 'user_interfaces.dart';


class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          TitleWithMoreBtn(
            title: "User Interfaces", press: () {}),
          User_Interfaces(),

        ],
        ),
    );
  }
}

