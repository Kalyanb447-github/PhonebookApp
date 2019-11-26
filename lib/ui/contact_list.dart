import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'contact_details.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  void navigateToDetails(DocumentSnapshot contact) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactDetails(contact: contact)));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          Firestore.instance.collection('contacts').orderBy('name').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
        return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new ListTile(
                      leading: CircleAvatar(
                        child: Text(document['name'][0]),
                      ),
                      title: new Text(
                        document['name'],
                        style: TextStyle(fontSize: 22.0),
                      ),
                      onTap: () => navigateToDetails(document)),
                );
              }).toList(),
            );
        }
      },
    );
  }
}