import 'package:cimo_mobile/get_json_addr.dart';
import 'package:cimo_mobile/mobile_final_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  Map<String, dynamic> data = Map();
  SignUp({required this.data});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormFieldState> _key = GlobalKey();
  final GlobalKey<FormFieldState> _key1 = GlobalKey();
  final GlobalKey<FormFieldState> _key2 = GlobalKey();
  final GlobalKey<FormFieldState> _key3 = GlobalKey();

  void reset_key() {
    _key.currentState?.reset();
  }

  void reset_key_1() {
    _key1.currentState?.reset();
  }

  void reset_key_2() {
    _key2.currentState?.reset();
  }

  void reset_key_3() {
    _key3.currentState?.reset();
  }

  bool iscompl = false;

  bool isregionempty = true;
  bool isprovinceempty = true;
  bool iscityempty = true;
  double _provheight = 0.0;
  double _cityheight = 0.0;
  double _brgyheight = 0.0;
  double _btnheight = 0.0;
  Map<String, dynamic> jsonaddr = Map();
  Map<String, dynamic> provinces = Map();
  Map<String, dynamic> cities = Map();
  List<dynamic> brgy = [];
  List<dynamic> _brgy = [];
  String _selectedregion = '';
  String _selectedprovince = '';
  String _selectedcity = '';
  String _selectedbrgy = '';
  List<String> listprovince = [];
  List<String> listcity = [];
  List<String> listbrgy = [];
  List<String> region = [
    'REGION I',
    'REGION II',
    'REGION III',
    'REGION IV-A',
    'REGION IV-B',
    'REGION V',
    'REGION VI',
    'REGION VII',
    'REGION VIII',
    'REGION IX',
    'REGION X',
    'REGION XI',
    'REGION XII',
    'REGION XIII',
    'BARMM',
    'CAR',
    'NCR',
  ];

  @override
  void initState() {
    super.initState();
    jsonaddr = widget.data;
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Some Sign up logo'),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
              child: DropdownButtonFormField(
                key: _key,
                isExpanded: true,
                isDense: false,
                menuMaxHeight: 300,
                hint: Text('Select your region'),
                itemHeight: 50,
                onChanged: (value) {
                  listprovince.clear();
                  setState(() {
                    iscompl = false;
                    isprovinceempty = true;
                    isregionempty = true;
                    iscityempty = true;
                    _selectedregion = value.toString();
                    provinces = jsonaddr[_selectedregion]['province_list'];
                    isregionempty = false;
                    _provheight = 50.0;
                  });
                  provinces.keys.forEach((key) {
                    listprovince.add(key);
                  });
                  print(isprovinceempty);
                },
                items: region.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onTap: () {
                  setState(() {
                    iscompl = false;
                    isprovinceempty = true;
                    isregionempty = true;
                    iscityempty = true;
                    reset_key();
                    isregionempty = true;
                    _provheight = 0.0;
                  });
                },
                onSaved: (value) {
                  isregionempty = false;
                  value = value.toString();
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: _provheight,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
              child: isregionempty == true
                  ? null
                  : DropdownButtonFormField(
                      key: _key1,
                      itemHeight: 50,
                      isExpanded: true,
                      isDense: false,
                      menuMaxHeight: 300,
                      hint: Text('Select your province'),
                      items: listprovince.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value[0].toUpperCase() +
                              value.substring(1).toLowerCase()),
                        );
                      }).toList(),
                      onTap: () {
                        setState(() {
                          iscompl = false;
                          iscityempty = true;
                          iscompl = false;
                          reset_key_1();
                          isprovinceempty = true;
                          _cityheight = 0.0;
                        });
                      },
                      onSaved: (value) {
                        value = value.toString();
                      },
                      onChanged: (value) {
                        listcity.clear();
                        setState(() {
                          iscompl = false;
                          isprovinceempty = true;
                          _selectedprovince = value.toString();
                          cities = jsonaddr[_selectedregion]['province_list']
                              [_selectedprovince]['municipality_list'];
                          isprovinceempty = false;
                          _cityheight = 50.0;
                        });
                        cities.keys.forEach((key) {
                          listcity.add(key);
                        });
                      },
                    ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: _cityheight,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
              child: isprovinceempty == true
                  ? null
                  : DropdownButtonFormField(
                      key: _key2,
                      itemHeight: 50,
                      isExpanded: true,
                      isDense: false,
                      menuMaxHeight: 300,
                      hint: Text('Select your city / municipality'),
                      items: listcity.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value[0].toUpperCase() +
                              value.substring(1).toLowerCase()),
                        );
                      }).toList(),
                      onTap: () {
                        setState(() {
                          reset_key_2();
                          iscompl = false;
                          iscityempty = true;
                          _brgyheight = 0.0;
                        });
                      },
                      onSaved: (value) {
                        value = value.toString();
                      },
                      onChanged: (value) {
                        listbrgy.clear();
                        setState(() {
                          iscompl = false;
                          iscityempty = true;
                          _selectedcity = value.toString();
                          brgy = jsonaddr[_selectedregion]['province_list']
                                  [_selectedprovince]['municipality_list']
                              [_selectedcity]['barangay_list'];
                          iscityempty = false;
                          _brgyheight = 50.0;
                        });
                        brgy.forEach((value) {
                          listbrgy.add(value);
                        });
                      },
                    ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: _brgyheight,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
              child: iscityempty == true
                  ? null
                  : DropdownButtonFormField(
                      key: _key3,
                      itemHeight: 50,
                      isExpanded: true,
                      isDense: false,
                      menuMaxHeight: 300,
                      hint: Text('Select your barangay'),
                      items: listbrgy.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value[0].toUpperCase() +
                              value.substring(1).toLowerCase()),
                        );
                      }).toList(),
                      onTap: () {
                        setState(() {
                          reset_key_3();
                          iscompl = false;
                        });
                      },
                      onSaved: (value) {
                        value = value.toString();
                      },
                      onChanged: (value) {
                        setState(() {
                          _selectedbrgy = value.toString();
                          iscompl = true;
                          _btnheight = 50.0;
                        });
                      },
                    ),
            ),
            SizedBox(
              height: 50,
            ),
            buildbutton(),
          ],
        ),
      ),
    );
  }

  Widget buildbutton() {
    return iscompl == false
        ? Container()
        : AnimatedContainer(
            duration: Duration(microseconds: 300),
            height: _btnheight,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color(0xffff6e00),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(MediaQuery.of(context).size.width / 2.2, _btnheight),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FinalSignUp(
                      region: _selectedregion,
                      province: _selectedprovince,
                      city: _selectedcity,
                      brgy: _selectedbrgy,
                    ),
                  ),
                );
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
                      'NEXT',
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
          );
  }
}
