import 'package:cimo_mobile/loading.dart';
import 'package:cimo_mobile/mobile_login.dart';
import 'package:cimo_mobile/unsupported.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cimo_mobile/get_json_addr.dart';

class Selection extends StatefulWidget {
  const Selection({Key? key}) : super(key: key);

  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  Map<String, dynamic> jsonaddr = Map();
  void getaddrjson() async {
    GetJsonAddr getter = GetJsonAddr();
    await getter.getaddr();
    setState(() {
      jsonaddr = getter.addrdata;
    });
  }

  void barangaylogin() {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MobileLogin()),
      );
    });
  }

  void redirect() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Loading()),
      );
    });
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
    if (MediaQuery.of(context).size.width < 300 ||
        MediaQuery.of(context).size.width > 900) {
      return buildunsupported(context);
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffFDF6EE),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(
                  'assets/images/selection.png',
                ),
                height: 230,
                width: 290,
              ),
              Text(
                'Hi, please choose a log in option',
                style: TextStyle(
                  fontFamily: 'Montserrat-R',
                  fontSize: 15,
                  color: Color(0xff573240),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xff96cfce),
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
                  barangaylogin();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.badge_outlined,
                        size: 20,
                      ),
                      Text(
                        'BARANGAY OFFICIAL',
                        style: TextStyle(
                          fontFamily: 'Montserrat-B',
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
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
                  redirect();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.perm_identity_outlined,
                        size: 20,
                      ),
                      Text(
                        'GENERAL USER',
                        style: TextStyle(
                          fontFamily: 'Montserrat-B',
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
