import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../service/contact_service.dart';
import '../main.dart';

class ContactEdit extends StatefulWidget {
  final DocumentSnapshot contact;
  ContactEdit({this.contact});
  @override
  _ContactEditState createState() => _ContactEditState();
}

class _ContactEditState extends State<ContactEdit> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  ContactService contactService = new ContactService();

  void updateContact(contactId) {
    contactService.updateData(contactId, {
      'name': _nameController.text,
      'phone': _phoneController.text,
      'address': _addressController.text,
    }).then((result) {
      editedDialog(context);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.contact.data['name'];
    _phoneController.text = widget.contact.data['phone'];
    _addressController.text = widget.contact.data['address'];
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
        title: Text('Edit Contact'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    style: TextStyle(fontSize: 22.0),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name is Data';
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
                        return 'Phone is Data';
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
                          'Update',
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
                            updateContact(widget.contact.documentID);
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> editedDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Contact Updated'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
              )
            ],
          );
        });
  }
}