import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/screens/home/components/body.dart';
import 'package:myapp/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    }catch(e){
      print(e);
    }
  }

    Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      //bottomNavigationBar: MyBottomNavBar(),
    );
  }

    AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
    );
  }

}

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Search screen'),
  //       actions: [
  //         IconButton(
  //           icon: Icon(
  //             Icons.exit_to_app_sharp,
  //             color: Colors.white,
  //           ),
  //           onPressed: (){
  //             _authentication.signOut();
  //             Navigator.pop(context);
  //           },
  //         )
  //       ],
  //     ),
  //     body: Center(
  //       child: Text('Search screen'),
  //     ),
  //   );
  // }



