
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/screens/details/components/camera_screen.dart';

class CameraScreenInformation extends StatefulWidget {
  Information information = Information();
  CameraScreenInformation(this.information,{Key? key}) : super(key: key);

  @override
  State<CameraScreenInformation> createState() => _CameraScreenInformationState(this.information);
}

class _CameraScreenInformationState extends State<CameraScreenInformation> {
  Information information = Information();
  _CameraScreenInformationState(this.information);
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: const Text('Information'),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            onPrimary: Colors.white,
                            shadowColor: kPrimaryColor,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            _text = information.address;
                            setState(() {});
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  "addr",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            onPrimary: Colors.white,
                            shadowColor: kPrimaryColor,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            _text = information.phonenumber;
                            setState(() {});
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  "number",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            onPrimary: Colors.white,
                            shadowColor: kPrimaryColor,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            _text = information.date;
                            setState(() {});
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  "date",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            onPrimary: Colors.white,
                            shadowColor: kPrimaryColor,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            _text = '';
                            for (String t in information.products) _text = _text + t + "\n" ;
                            print(_text);
                            setState(() {});
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  "product",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    _text,
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],

            )),
      ),
    );
  }
}
