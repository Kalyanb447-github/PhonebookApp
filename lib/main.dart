import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_phonebook_app/ask_app_type.dart';
import './ui/contact_list.dart';
import './ui/contact_form.dart';

void main() => runApp(MyApp());

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToNextScreen();
  }

  goToNextScreen() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AskAppType(
             
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.jpeg'),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'List Of Contacts',
      theme: new ThemeData(primarySwatch: Colors.purple, fontFamily: 'Lato'),
      // home: new MyHomePage(
      //   title: 'List Of Contacts',
      // )
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void navigateToNewContact() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ContactForm()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon:
                  const Icon(Icons.group_add, color: Colors.white, size: 30.0),
              onPressed: () => navigateToNewContact()),
        ],
      ),
      body: ContactList(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.purple,
        icon: Icon(Icons.add),
        label: Text('New Contact'),
        onPressed: navigateToNewContact,
      ),
    );
  }
}
