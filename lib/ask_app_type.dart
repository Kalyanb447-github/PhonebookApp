
import 'package:flutter/material.dart';
import 'package:my_phonebook_app/main.dart';

import 'app_without_firebase/main.dart';
import 'widgets/custom_shape.dart';
import 'widgets/responsive_ui.dart';

class AskAppType extends StatefulWidget {
  @override
  _AskAppTypeState createState() => _AskAppTypeState();
}

class _AskAppTypeState extends State<AskAppType> {
 double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;


    goToFirstApp(){
       Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=>Main2(),
        ));
    }
   
  goToSecondApp(){
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            title: 'List Of Contacts',
          ),
        ),
      );
    }
        
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      child: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              welcomeTextRow(),
              SizedBox(
                height: 40,
              ),
              SizedBox(height: _height / 12),
              studentbutton(),
              SizedBox(
                height: 40,
              ),
              teacherbutton(),
            ],
          ),
        ),
      ),
    );
  }
  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 4
                  : (_medium ? _height / 3.75 : _height / 3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0xFF734C99)],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 4.5
                  : (_medium ? _height / 4.25 : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // colors: [Colors.orange[200], Colors.pinkAccent],
                  colors: [Colors.white, Color(0xFF734C99)],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
              top: _large
                  ? _height / 30
                  : (_medium ? _height / 25 : _height / 20)),
        ),
      ],
    );
  }
  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[
          Text(
            "Choose app type",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _large ? 60 : (_medium ? 40 : 40),
              
            ),
          ),
        ],
      ),
    );
  }
  Widget studentbutton() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: goToFirstApp,
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: _large ? _width / 4 : (_medium ? _width * .8 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: [Color(0xFF734C99), Colors.purple[100]],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('App With List',
            style: TextStyle(fontSize: _large ? 14 : (_medium ? 16 : 10))),
      ),
    );
  }

  Widget teacherbutton() {
    return RaisedButton(
      onPressed: goToSecondApp,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      //onPressed:goToTeacherDashboard,
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: _large ? _width / 4 : (_medium ? _width * .8 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            // colors: <Color>[Colors.orange[200], Colors.pinkAccent],
            colors: [Color(0xFF734C99), Colors.purple[100]],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('App With Firebase',
            style: TextStyle(fontSize: _large ? 14 : (_medium ? 16 : 10))),
      ),
    );
  }
}
