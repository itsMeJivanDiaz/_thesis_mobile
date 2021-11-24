import 'package:cimo_mobile/brgy_home.dart';
import 'package:cimo_mobile/fetch_registered_city.dart';
import 'package:cimo_mobile/home.dart';
import 'package:cimo_mobile/jwt_init.dart';
import 'package:cimo_mobile/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cimo_mobile/fetch_general.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cimo_mobile/fetch_brgy_est.dart';

class BrgyLoading extends StatefulWidget {
  String? token = '';
  String? secret = '';
  BrgyLoading({required this.token, required this.secret});
  @override
  _BrgyLoadingState createState() => _BrgyLoadingState();
}

class _BrgyLoadingState extends State<BrgyLoading> {
  String status = '';
  String loadingmessage = 'Please wait';
  bool loadingstatus = true;
  bool isauthentic = false;

  void fetchbarangay() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        loadingmessage = 'Verifying profile';
      });
    });
    BrygyFetch brgyfetch =
        BrygyFetch(token: widget.token, secretkey: widget.secret);
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        loadingmessage = 'Getting Designated Establishments';
      });
    });
    await brgyfetch.fetchest();
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        loadingmessage = 'Finalizing';
      });
    });
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BrgyHome(
            token: widget.token,
            secretkey: widget.secret,
            establishment: brgyfetch.status,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchbarangay();
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Container(
                  height: 230,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage(
                          'assets/images/logo.png',
                        ),
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'CIMO',
                        style: TextStyle(
                          fontFamily: 'Montserrat-B',
                          fontSize: 35,
                          color: Color(0xffA9D8D5),
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Color(0xff616161),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        '$loadingmessage',
                        style: TextStyle(
                          fontFamily: 'Montserrat-B',
                          fontSize: 12,
                          color: Color(0xff573240),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      loadingstatus == true
                          ? SpinKitThreeBounce(
                              size: 20,
                              color: Color(0xffFCD4D0),
                            )
                          : Icon(
                              Icons.wifi_off_rounded,
                              size: 20,
                              color: Color(0xffcccccc),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                child: Text(
                  'Crowd Counting with Integrative Mobile Application',
                  style: TextStyle(
                    fontFamily: 'Montserrat-R',
                    fontSize: 11,
                    color: Color(0xff808080),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
