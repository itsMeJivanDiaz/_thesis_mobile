import 'package:cimo_mobile/brgy_home.dart';
import 'package:cimo_mobile/brgy_loading.dart';
import 'package:cimo_mobile/get_json_addr.dart';
import 'package:cimo_mobile/jwt_pref.dart';
import 'package:cimo_mobile/log_in.dart';
import 'package:cimo_mobile/mobile_sign_up.dart';
import 'package:cimo_mobile/selection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MobileLogin extends StatefulWidget {
  const MobileLogin({Key? key}) : super(key: key);

  @override
  _MobileLoginState createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  final _usertext = TextEditingController();
  final _userpass = TextEditingController();
  String username = '';
  String password = '';

  void getjaddr() async {
    GetJsonAddr getter = GetJsonAddr();
    await getter.getaddr();
    signup(getter.addrdata);
  }

  void signup(data) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUp(
          data: data,
        ),
      ),
    );
  }

  void login() async {
    print('hello');
    LoginQuery logger = LoginQuery(username: username, password: password);
    await logger.postreq();
    if (logger.status[0]['status'] == "Success") {
      JwtPrefs jwt =
          JwtPrefs(setvar: 'jwt_brgy', setval: logger.status[0]['jwt']);
      await jwt.setjwt();
      await jwt.getjwt();
      String? token = jwt.res;
      JwtPrefs key =
          JwtPrefs(setvar: 'key_brgy', setval: logger.status[0]['secretkey']);
      await key.setjwt();
      await key.getjwt();
      String? secretkey = key.res;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => BrgyLoading(
              token: token,
              secret: secretkey,
            ),
          ),
          (Route<dynamic> route) => false);
    } else {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            logger.status[0]['error'],
            style: TextStyle(
              fontFamily: 'Montserrat-R',
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xff573240),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xffFAE9D7),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xffFDF6EE),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 10),
          height: MediaQuery.of(context).size.height,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 35,
                          padding: EdgeInsets.zero,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Selection(),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.keyboard_backspace_rounded,
                                color: Color(0xff573240),
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Welcome back!',
                              style: TextStyle(
                                fontFamily: 'Montserrat-B',
                                color: Color(0xff573240),
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Log in to continue.',
                              style: TextStyle(
                                fontFamily: 'Montserrat-R',
                                color: Color(0xff616161),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          child: Image(
                            image: AssetImage(
                              'assets/images/login.png',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                            height: MediaQuery.of(context).size.height / 3.3,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Log in Form',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat-B',
                                      color: Color(0xffFF6E00),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  height: 1,
                                  width: MediaQuery.of(context).size.width,
                                  color: Color(0xffFF6E00),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  controller: _usertext,
                                  onChanged: (value) {
                                    setState(() {
                                      username = value;
                                    });
                                  },
                                  style: TextStyle(
                                    fontFamily: 'Montserrat-R',
                                    color: Color(0xff616161),
                                    fontSize: 13,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Username',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat-R',
                                      color: Color(0xff616161),
                                      fontSize: 13,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xffff5f5f5),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    prefixIcon: Container(
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        ),
                                        color: Colors.transparent,
                                      ),
                                      height: 45,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                              ),
                                              color: Color(0xffA9D8D5),
                                            ),
                                            height: 47,
                                            width: 47,
                                            child: Icon(
                                              Icons.assignment_ind,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  obscureText: true,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  controller: _userpass,
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                  style: TextStyle(
                                    fontFamily: 'Montserrat-R',
                                    color: Color(0xff616161),
                                    fontSize: 13,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat-R',
                                      color: Color(0xff616161),
                                      fontSize: 13,
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        top: 0, bottom: 0, left: 0, right: 0),
                                    filled: true,
                                    fillColor: Color(0xffff5f5f5),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    prefixIcon: Container(
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        ),
                                        color: Colors.transparent,
                                      ),
                                      height: 45,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                              ),
                                              color: Color(0xffA9D8D5),
                                            ),
                                            height: 47,
                                            width: 47,
                                            child: Icon(
                                              Icons.lock_rounded,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 130),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Color(0xffff6e00),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Colors.white,
                                        ),
                                        minimumSize:
                                            MaterialStateProperty.all<Size>(
                                          Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              45),
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (password.isEmpty ||
                                            username.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .removeCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration: Duration(seconds: 2),
                                              content: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.error_rounded,
                                                    size: 15,
                                                    color: Color(0xffff6e00),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Empty fields are not allowed',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat-R',
                                                      color: Color(0xff573240),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              backgroundColor: Colors.white,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ),
                                          );
                                        } else {
                                          login();
                                        }
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(
                                              Icons.lock_open,
                                              size: 20,
                                            ),
                                            Text(
                                              'LOG IN',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat-B',
                                                fontSize: 12,
                                              ),
                                            ),
                                            Icon(
                                              Icons.vpn_key_sharp,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Montserrat-R',
                            color: Color(0xff616161),
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  'Don’t have an account yet? Please, sign up ',
                            ),
                            TextSpan(
                              text: 'HERE',
                              style: TextStyle(
                                color: Color(0xffFF6E00),
                                fontFamily: 'Montserrat-B',
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  getjaddr();
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
