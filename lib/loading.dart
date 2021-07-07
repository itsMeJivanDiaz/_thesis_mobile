import 'package:cimo_mobile/fetch_registered_city.dart';
import 'package:cimo_mobile/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cimo_mobile/fetch_general.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void initializegeneraldata() async {
    FetchGeneralData initialData = FetchGeneralData();
    setState(() {
      loadingmessage = 'Checking your Internet.';
    });
    await initialData.getData();
    List initData = initialData.data;
    FetchRegisteredCity registeredCity = FetchRegisteredCity();
    await Future.delayed(
      Duration(seconds: 3),
      () {
        setState(() {
          loadingmessage = 'Getting Registered Establishments..';
        });
      },
    );
    await registeredCity.getData();
    List initialCity = registeredCity.data;
    await Future.delayed(
      Duration(seconds: 3),
      () {
        setState(() {
          loadingmessage = 'Finalizing.';
        });
      },
    );
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(
              data: initData,
              city: initialCity,
            ),
          ),
        );
      },
    );
  }

  String loadingmessage = 'Initializing';

  bool loadingstatus = true;

  @override
  void initState() {
    super.initState();
    initializegeneraldata();
    Future.delayed(
      Duration(seconds: 30),
      () {
        setState(() {
          loadingmessage = 'Server Error or Internet Error.';
          loadingstatus = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffFDF6EE),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
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
                          fontSize: 33,
                          color: Color(0xffA9D8D5),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        '$loadingmessage',
                        style: TextStyle(
                          fontFamily: 'Montserrat-R',
                          fontSize: 15,
                          color: Color(0xffcccccc),
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
