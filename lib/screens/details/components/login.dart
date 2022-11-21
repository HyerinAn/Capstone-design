import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/config/palette.dart';
import 'package:myapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/screens/home/search_screen.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _authenticaton = FirebaseAuth.instance;

  bool isSignupScreen = true;
  final _formkey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';

  void _tryValidation(){
    final isValid = _formkey.currentState!.validate();
    if(isValid){
      _formkey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,//Palette.backgroundColor,
        body: GestureDetector(
          onTap: (){ 
            FocusScope.of(context).unfocus();
          },
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //       image: AssetImage('image/recipt.jpg'),
                //       fit: BoxFit.fill
                //     ),
                // ),
                child: Container(
                  padding: EdgeInsets.only(top: 90),
                  child: Column(
                    children: [
                      RichText(
                        // text: TextSpan(
                        //   text: 'LOGIN',
                        //   style: TextStyle(
                        //       letterSpacing: 1.0,
                        //       fontSize: 25,
                        //       color: Colors.white),
                        //   children: [
                           text: TextSpan(
                              text: isSignupScreen ? 'SIGNUP' : ' LOGIN',
                              style: TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                 // ],
                    //    ),
                ),
                      SizedBox(
                        height: 5.0,
                      ),
                      // Text(
                      //   isSignupScreen ? '회원가입' : '로그인',
                      //   style: TextStyle(
                      //     letterSpacing: 1.0,
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.bold,
    
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            //배경
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: 180,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                padding: EdgeInsets.all(20.0),
                height: isSignupScreen ? 280.0 : 250.0,
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ],
                ),
                child:SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'EXISTING',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 80,
                                  color: Colors.green,
                                )
                            ],
                          ),
                        
                        
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'NEW',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 80,
                                  color: Colors.green,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if(isSignupScreen)
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              key: ValueKey(1),
                              validator: (value){
                                if(value!.isEmpty || value.length < 4){
                                  return '4글자 이상 입력해주세요.';
                                }
                                return null;
                              },
                              onSaved: (value){
                                userName = value!;
                              },
                              onChanged: (value){
                                userName = value;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: Palette.iconColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  hintText: 'User name',
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Palette.textColor1),
                                  contentPadding: EdgeInsets.all(10)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              key: ValueKey(2),
                              validator: (value){
                                if(value!.isEmpty || !value.contains('@')){
                                  return '유효한 이메일 주소를 입력해주세요.';
                                }
                                return null;
                              },
                              onSaved: (value){
                                userEmail = value!;
                              },
                              onChanged: (value){
                                userEmail = value;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Palette.iconColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  hintText: 'email',
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Palette.textColor1),
                                  contentPadding: EdgeInsets.all(10)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              obscureText: true,
                              key: ValueKey(3),
                              validator: (value){ 
                                if(value!.isEmpty || value.length < 6){
                                  return '비밀번호는 최소 7자리 이상이어야 합니다.';
                                }
                                return null;
                              },
                              onSaved: (value){
                                userPassword = value!;
                              },
                              onChanged: (value){
                                userPassword = value;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Palette.iconColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  hintText: 'password',
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Palette.textColor1),
                                  contentPadding: EdgeInsets.all(10)),
                            )
                          ],
                        ),
                      ),
                    ),
                    if(!isSignupScreen)
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              key: ValueKey(4),
                              validator: (value){
                                if(value!.isEmpty || !value.contains('@')){
                                  return '유효한 이메일 주소를 입력해주세요.';
                                }
                                return null;
                              },
                              onSaved: (value){
                                userEmail = value!;
                              },
                              onChanged: (value){
                                userEmail = value;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Palette.iconColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  hintText: 'email',
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Palette.textColor1),
                                  contentPadding: EdgeInsets.all(10)),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            TextFormField(
                              key: ValueKey(5),
                                validator: (value){ 
                                if(value!.isEmpty || value.length < 6){
                                  return '비밀번호는 최소 6자리 이상이어야 합니다.';
                                }
                                return null;
                              },
                              onSaved: (value){
                                userPassword = value!;
                              },
                              onChanged: (value){
                                userPassword = value;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Palette.iconColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  hintText: 'password',
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Palette.textColor1),
                                  contentPadding: EdgeInsets.all(10)),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ),
            //텍스트 폼 필드
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: isSignupScreen ? 430 : 390,
              right: 0,
              left: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: GestureDetector(
                    onTap: () async{
                      if(isSignupScreen){
                        _tryValidation();
                        try{
                        final newUser = await _authenticaton.createUserWithEmailAndPassword(
                          email: userEmail, 
                          password: userPassword
                          );
                          
                          if(newUser.user != null){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){
                                return SearchScreen();
                              }),
                            );

                          }
                        }catch(e){
                         print(e);
                         ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: 
                            Text('Please check your email and password'),
                            backgroundColor: Colors.blue,
                            )
                         );
                      }
                        
                      }
                      if(!isSignupScreen) {
                        _tryValidation();

                        try {
                          final newUser =
                          await _authenticaton.signInWithEmailAndPassword(
                            email: userEmail,
                            password: userPassword,
                          );
                          if (newUser.user != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return SearchScreen();
                              }),
                            );
                          }
                        } catch (e) {
                          print(e);

                            showCupertinoDialog(context: context, builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text("로그인 실패"),
                                content: Text("다시 시도해주세요"),
                                actions: [
                                  CupertinoDialogAction(isDefaultAction: true, child: Text("확인"), onPressed: () {
                                    Navigator.pop(context);
                                  })
                                ],
                              );
                            });
                          }


                      }
                    },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.yellow, Colors.blue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
                ),
              ),
            ),
            //전송버튼
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              top: isSignupScreen ? MediaQuery.of(context).size.height - 125
              :MediaQuery.of(context).size.height - 165,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Text(isSignupScreen ? 'or Signup with' : 'or Signin with'),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton.icon(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: Size(155, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      backgroundColor: Colors.green
                    ),
                    icon: Icon(Icons.add),
                    label: Text('Google'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}