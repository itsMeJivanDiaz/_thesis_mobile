import 'package:cimo_mobile/brgy_home.dart';
import 'package:cimo_mobile/brgy_loading.dart';
import 'package:cimo_mobile/get_json_addr.dart';
import 'package:cimo_mobile/jwt_pref.dart';
import 'package:cimo_mobile/log_in.dart';
import 'package:cimo_mobile/mobile_sign_up.dart';
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
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUp(
                  data: data,
                )),
      );
    });
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
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BrgyLoading(
                    token: token,
                    secret: secretkey,
                  )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(logger.status[0]['error']),
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
        systemNavigationBarColor: Color(0xffFDF6EE),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffFDF6EE),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Some log in logo here',
                style: TextStyle(
                  fontFamily: 'Montserrat-R',
                  fontSize: 15,
                  color: Color(0xff573240),
                ),
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
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    size: 16,
                    color: Color(0xffFF6E00),
                  ),
                ),
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
                  prefixIcon: Icon(
                    Icons.lock_rounded,
                    size: 16,
                    color: Color(0xffFF6E00),
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xffff6e00),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(MediaQuery.of(context).size.width / 2.2, 45),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                onPressed: () {
                  if (password.isEmpty || username.isEmpty) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Empty Inputs')));
                  } else {
                    login();
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xffff6e00),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(MediaQuery.of(context).size.width / 2.2, 45),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                onPressed: () {
                  getjaddr();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.badge_rounded,
                        size: 20,
                      ),
                      Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontFamily: 'Montserrat-B',
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.edit_rounded,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
