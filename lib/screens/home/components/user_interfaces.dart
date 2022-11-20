import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/screens/details/components/camera_screen.dart';
import 'package:myapp/screens/details/components/consumption_list.dart';




class User_Interfaces extends StatelessWidget {
  const User_Interfaces({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          UserInterfaces(
            interface_name: "CAMERA",
            icon: Icon(CupertinoIcons.camera_circle_fill,
                size: 100),
            press:
              (){
              Navigator.push(
                      context,
              MaterialPageRoute(builder: (context)
              {
                return CameraScreen();
              }
                )
              );
    }
    ),


          UserInterfaces(
              interface_name: "PERSONAL",
              icon: Icon(CupertinoIcons.person_circle_fill,
                  size: 100),
              press:
                () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ConsumptionListScreen();
                    }
                    )
                );
              }
          ),
          UserInterfaces(
              interface_name: "ETC",
              icon: Icon(CupertinoIcons.plus_app_fill,
                  size: 100),
              press: (){}
            //   (){
            //   Navigator.push(
            //           context,
            //   MaterialPageRoute(builder: (context) {
            //   return Screen();
            //
            // },
          ),
        ],
      ),
    );
  }
}

class UserInterfaces extends StatelessWidget {
  const UserInterfaces({
    Key? key,
    required this.interface_name,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String interface_name;
  final Icon icon;
  final void Function() press;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(
            left: kDefaultPadding,
            top: kDefaultPadding / 2,
            bottom: kDefaultPadding * 2.5,
          ),
          width: size.width * 0.4,
          height: 150,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            onPressed: press,
            icon: icon, color: Colors.white,

          ),

          //     SizedBox(height : 10),
          // ElevatedButton.icon(
          // onPressed: (){},
          // //   (){
          // //   Navigator.push(
          // //           context,
          // //   MaterialPageRoute(builder: (context) {
          // //   return CameraScreen();
          // //
          // // },
          // style: ElevatedButton.styleFrom(
          //     primary: Colors.white,
          //     fixedSize: Size(300, 150),
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(20)
          //     ),
          //     backgroundColor: kPrimaryColor,
          // ),
          //
          //
          //   label: icon,
          //
          //   icon: Text(interface_name,
          //      style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.white,
          //
          //     ),
          //   ),
          // ),
        )
    );
  }
}

