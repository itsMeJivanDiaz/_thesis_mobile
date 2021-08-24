import 'package:cimo_mobile/establishment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cimo_mobile/unsupported.dart';
import 'dart:math';
import 'package:cimo_mobile/search.dart';
import 'package:cimo_mobile/fetch_general.dart';
import 'package:cimo_mobile/specific_establishment.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  List data = [];
  List city = [];
  HomeView({
    required this.data,
    required this.city,
  });
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List colors = [
    Color(0xffE0F1F0),
    Color(0xffFCF6ED),
  ];

  Random rand = new Random();
  int coloridx = 0;
  bool load = false;

  final _searchcontroller = TextEditingController();

  Future<void> _refresh() async {
    // ignore: non_constant_identifier_names
    FetchGeneralData est_instance = FetchGeneralData();
    await est_instance.getData();
    setState(() {
      widget.data = est_instance.data;
    });
  }

  void getSpecific(String id, String tag) async {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (context, __, _) => EstablishmentInfo(
          id: id,
          hero_tag: tag,
        ),
      ),
    );
  }

  colorchange(index) {
    if (index % 2 == 0) {
      coloridx = 1;
    } else {
      coloridx = 0;
    }
    return coloridx;
  }

  String _indexvalue = '';

  String current = 'None';

  void _modalshow() {
    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: false,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, update) {
            return Container(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_city_rounded,
                        size: 20,
                        color: Color(0xffFF6E00),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Cities',
                        style: TextStyle(
                          fontFamily: 'Montserrat-B',
                          fontSize: 15,
                          color: Color(0xff616161),
                        ),
                      ),
                      Spacer(),
                      Text(
                        ' ( Current : $current )',
                        style: TextStyle(
                          fontFamily: 'Montserrat-R',
                          fontSize: 13,
                          color: Color(0xff616161),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.city.length,
                      itemExtent: 50,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          update(() {
                            _indexvalue = index.toString();
                            current = widget.city[index]['city'];
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffE1E1E1),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: _indexvalue == index.toString()
                                    ? Color(0xffFF6E00)
                                    : Color(0xffdddddd),
                                size: 17,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${widget.city[index]['city']}',
                                style: TextStyle(
                                  fontFamily: 'Montserrat-R',
                                  fontSize: 14,
                                  color: Color(0xff616161),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffA9D8D5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.check,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  _senddatasearch(String data) async {
    // ignore: unused_local_variable
    SearchEstablishment searchisntance =
        SearchEstablishment(search: data, city: current);
    await searchisntance.getsearch();
    setState(() {
      widget.data = searchisntance.data;
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
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    if (MediaQuery.of(context).size.width < 300 ||
        MediaQuery.of(context).size.width > 768) {
      return buildunsupported(context);
    } else {
      if (load == false) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xffFDE5E3),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Image(
                    image: AssetImage('assets/images/image.jpg'),
                  ),
                ),
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: Text(
                      'Discover Establishments',
                      style: TextStyle(
                        fontFamily: 'Montserrat-B',
                        fontSize: 20,
                        color: Color(0xff573240),
                      ),
                    ),
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.68,
                  maxChildSize: 0.90,
                  minChildSize: 0.68,
                  builder: (context, controller) => Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                  right: 10,
                                ),
                                child: TextField(
                                  controller: _searchcontroller,
                                  onChanged: (value) {
                                    _senddatasearch(value);
                                  },
                                  style: TextStyle(
                                    fontFamily: 'Montserrat-R',
                                    color: Color(0xff616161),
                                    fontSize: 13,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Find Place',
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
                                      Icons.search_rounded,
                                      size: 16,
                                      color: Color(0xffFF6E00),
                                    ),
                                    suffixIcon: Icon(
                                      Icons.location_pin,
                                      size: 16,
                                      color: Color(0xffFF6E00),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffFF6E00),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  _modalshow();
                                },
                                icon: Icon(
                                  Icons.tune_rounded,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          height: 1,
                          color: Color(0xffFF6E00),
                        ),
                        Expanded(
                          child: Container(
                            child: RefreshIndicator(
                              onRefresh: _refresh,
                              child: ListView.builder(
                                controller: controller,
                                itemCount: widget.data.length,
                                itemExtent: 120,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 15.0,
                                    ),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colors[colorchange(index)],
                                      child: InkWell(
                                        splashColor: Color(0xffA9D8D5),
                                        onTap: () {
                                          getSpecific(
                                            widget.data[index]
                                                ['establishment-ID'],
                                            widget.data[index]
                                                ['establishment-ID'],
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                              30,
                                              0,
                                              30,
                                              0,
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 65,
                                                  width: 65,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Hero(
                                                    tag: widget.data[index]
                                                        ['establishment-ID'],
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: widget.data[index]
                                                                  ['logo'] ==
                                                              "None"
                                                          ? Image(
                                                              image: AssetImage(
                                                                  'assets/images/logo.png'),
                                                            )
                                                          : Image(
                                                              image: NetworkImage(
                                                                  'http://192.168.254.108:80/cimo_desktop/uploads/${widget.data[index]['logo']}'),
                                                              fit: BoxFit.cover,
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        '${widget.data[index]['establishment-name']}',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat-B',
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '${widget.data[index]['branch-street']}, ${widget.data[index]['city']}',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat-R',
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '${widget.data[index]['barangay-area']} Area',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat-R',
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Scaffold(
          body: Text('hello'),
        );
      }
    }
  }
}
