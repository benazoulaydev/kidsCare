import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AlertScreen extends StatefulWidget {
  AlertScreen();
  AlertScreenState createState() => AlertScreenState();
}

class AlertScreenState extends State<AlertScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    // await BlocProvider.of<DangerAlertCubit>(context).getDangerStatus();
    setState(() {});
  }

  bool isAlert = false;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text("Alert Screen", style: TextStyle(color: Colors.white)),
          backgroundColor: isLoading
              ? Colors.blue
              : isAlert
                  ? Colors.red
                  : Colors.green,
          elevation: 0,
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.share),
            //   onPressed: () {},
            // ),
          ],
        ),
        body: Container(
            height: height,
            width: width,
            color: isLoading
                ? Colors.blue
                : isAlert
                    ? Colors.red
                    : Colors.green,
            child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Column contents vertically,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isLoading
                      ? const SpinKitDoubleBounce(color: Colors.white)
                      : isAlert
                          ? Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.white,
                              size: width / 2,
                              semanticLabel: 'Danger detected in the kitchen',
                            )
                          : Icon(
                              Icons.thumb_up_rounded,
                              color: Colors.white,
                              size: width / 2,
                              semanticLabel: 'All Good, no danger detected',
                            ),
                  SizedBox(
                    height: 100,
                  ),
                  isLoading
                      ? Text(
                          'Loading',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )
                      : isAlert
                          ? Text(
                              'Danger detected in the kitchen',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            )
                          : Text(
                              'All Good, no danger detected',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                  StreamBuilder(
                      stream: Stream.periodic(Duration(seconds: 1))
                          .asyncMap((i) => getDangerStatus()),
                      builder: (context, snapshot) {
                        isLoading = false;
                        return SizedBox();
                      })
                ])));
  }

  Future<bool> getDangerStatus() async {
    bool isDanger = false;
    var response = await http.get("http://198.199.72.194:1880/danger");
    if (response.statusCode == 200) {
      isDanger = convert.jsonDecode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    setState(() {
      isAlert = isDanger;
    });

    return isDanger;
  }
}
