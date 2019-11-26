import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../service/contact_service.dart';
import '../ui/contact_edit.dart';

class ContactDetails extends StatefulWidget {
  final DocumentSnapshot contact;
  ContactDetails({this.contact});

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  ContactService contactService = new ContactService();

  void navigateToEdit(DocumentSnapshot contact) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContactEdit(contact: contact)));
  }

   void onDelete(id) {
    contactService.deleteContact(id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final topContent = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: CircleAvatar(
              child: Text(
                widget.contact.data['name'][0],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              radius: 40.0,
            ),
          ),
        ),
      ],
    );

    final bottomContent = Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(Icons.account_box, color: Colors.blue, size: 28.0),
          title: Text(
            widget.contact.data['name'],
            style: TextStyle(fontSize: 22.0),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(Icons.local_phone, color: Colors.blue, size: 28.0),
          title: Text(
            widget.contact.data['phone'],
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(Icons.location_on, color: Colors.blue, size: 28.0),
          title: Text(
            widget.contact.data['address'],
            style: new TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact.data['name']),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white, size: 30.0),
            onPressed: () => navigateToEdit(widget.contact),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white, size: 30.0),
            onPressed: () => deleteDialog(context),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }

  Future<bool> deleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Contact?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  onDelete(widget.contact.documentID);
                  Navigator.of(context).pop(true);
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            ],
          );
        });
  }
}