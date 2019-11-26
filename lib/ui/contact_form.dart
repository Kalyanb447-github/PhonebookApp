import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../service/contact_service.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  ContactService contactService = new ContactService();

  void addContact() {
    contactService.addContact({
      'name': _nameController.text,
      'phone': _phoneController.text,
      'address': _addressController.text,
    }).then((result) {
      addedDialog(context);
    }).catchError((e) {
      print(e);
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  style: TextStyle(fontSize: 22.0),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'name is empty';
                    }
                  },
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  style: TextStyle(fontSize: 22.0),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Phone is empty';
                    }
                  },
                  controller: _phoneController,
                  decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  style: TextStyle(fontSize: 22.0),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Address is empty';
                    }
                  },
                  controller: _addressController,
                  decoration: InputDecoration(
                      labelText: 'Address',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ButtonTheme(
                  minWidth: 300.0,
                  height: 45.0,
                  child: RaisedButton(
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    color: Colors.green,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        addContact();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Dialog Box
  Future<bool> addedDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('New Contact created'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}