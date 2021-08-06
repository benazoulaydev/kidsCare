import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_care/Screens/nav_bar.dart';
import 'package:kids_care/Screens/splash_screen.dart';
import 'package:kids_care/Widgets/dismiss_keyboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
        child: MaterialApp(
      title: 'Kids Care',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => new NavBar(),
      },
    ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("title"),
      ),
      body: Center(),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Users'),
  //       actions: [
  //         Chip(
  //           label: StreamBuilder<int>(
  //               stream: zoneBLoC.zoneCounter,
  //               builder: (context, snapshot) {
  //                 return Text(
  //                   (snapshot.data ?? 0).toString(),
  //                   style: TextStyle(
  //                       color: Colors.white, fontWeight: FontWeight.bold),
  //                 );
  //               }),
  //           backgroundColor: Colors.red,
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(right: 16),
  //         )
  //       ],
  //     ),
  //     body: Row(children: [
  //       Container(
  //         height: MediaQuery.of(context).size.height - 200,
  //         width: MediaQuery.of(context).size.width,
  //         child: StreamBuilder(
  //             stream: zoneBLoC.zoneList,
  //             builder: (context, snapshot) {
  //               switch (snapshot.connectionState) {
  //                 case ConnectionState.none:
  //                 case ConnectionState.waiting:
  //                 case ConnectionState.active:
  //                   return Center(child: CircularProgressIndicator());
  //                 case ConnectionState.done:
  //                   if (snapshot.hasError)
  //                     return Text('There was an error : ${snapshot.error}');
  //                   List<Zone> zones = snapshot.data as List<Zone>;

  //                   return ListView.separated(
  //                     itemCount: zones.length > 0 ? zones.length : 0,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       Zone _zone = zones[index];
  //                       String _leftDown = _zone.leftDown.X.toString() +
  //                           "," +
  //                           _zone.leftDown.Y.toString();
  //                       String _leftUp = _zone.leftUp.X.toString() +
  //                           "," +
  //                           _zone.leftUp.Y.toString();
  //                       String _rightUp = _zone.rightUp.X.toString() +
  //                           "," +
  //                           _zone.rightUp.Y.toString();
  //                       String _rightDown = _zone.rightDown.X.toString() +
  //                           "," +
  //                           _zone.rightDown.Y.toString();
  //                       return ListTile(
  //                           //title: Text(),
  //                           // subtitle: Text(_zone.email),
  //                           leading: Column(
  //                         children: [
  //                           Text("leftDown" +
  //                               _leftDown +
  //                               " " +
  //                               "leftUp" +
  //                               _leftUp),
  //                           Text("rightUp" +
  //                               _rightUp +
  //                               " " +
  //                               "rightDown" +
  //                               _rightDown),
  //                           const Image(
  //                             width: 200,
  //                             image: NetworkImage(
  //                                 'http://198.199.72.194:1880/imageFromApp'),
  //                           )
  //                         ],
  //                       ));
  //                     },
  //                     separatorBuilder: (context, index) => Divider(),
  //                   );
  //               }
  //             }),
  //       ),
  //       Container(
  //           height: 200,
  //           width: MediaQuery.of(context).size.width,
  //           child: new MyWidget())
  //     ]),
  //   );
  // }

}

extension GlobalKeyEx on GlobalKey {
  Offset? get globalPosition {
    final RenderBox box = currentContext?.findRenderObject() as RenderBox;
    return box.localToGlobal(Offset.zero);
  }
}
