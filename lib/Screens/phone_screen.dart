import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PhoneScreen extends StatefulWidget {
  PhoneScreen();
  PhoneScreenState createState() => PhoneScreenState();
}

class PhoneScreenState extends State<PhoneScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await getPhoneStatus();
    // await BlocProvider.of<DangerAlertCubit>(context).getDangerStatus();
    setState(() {});
  }

  String phone = "";
  String newPhone = "";
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Phone", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
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
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .start, //Center Column contents vertically,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Current Phone: ',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  Text(
                    phone,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  Center(
                      child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        isLoading
                            ? const SpinKitDoubleBounce(color: Colors.blue)
                            : TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero),
                                textInputAction: TextInputAction.go,

                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],

                                onSaved: (value) => this.newPhone = value!,

                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                        isLoading
                            ? SizedBox()
                            : RaisedButton(
                                child: Text('Submit'),
                                onPressed: () async {
                                  setState(() {
                                    this.isLoading = true;
                                  });
                                  if (this._formKey.currentState!.validate()) {
                                    setState(() {
                                      this._formKey.currentState!.save();
                                    });
                                    await postPhone(this.newPhone);
                                    await init();
                                  }
                                  setState(() {
                                    this.isLoading = false;
                                  });
                                },
                              ),
                      ],
                    ),
                  ))
                ])));
  }

  Future<void> getPhoneStatus() async {
    String phone = "";
    Map<String, dynamic> map;
    var response = await http.get("http://198.199.72.194:1880/getPhone");
    if (response.statusCode == 200) {
      map = convert.jsonDecode(response.body);
      if (map.containsKey("phone")) {
        phone = map["phone"] as String;
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    setState(() {
      this.phone = phone;
    });
  }

  Future<void> postPhone(String phone) async {
    final uri = 'http://198.199.72.194:1880/postPhone';
    var map = new Map<String, dynamic>();
    map['phone'] = phone;

    http.Response response = await http.post(
      uri,
      body: map,
    );
    print(response.body);
  }
}
