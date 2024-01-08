import 'package:chat_app/services/authentication/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // we want to display something, maybe like username etc.
  // so we need a instance of auth to reach them
  // instance of Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign out method
  void signOut() {
    // get Auth Service
    final authService = Provider.of<AuthService>(context, listen: false);

    // now we can sign out with method which we've created in auth_service
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title:  Text('Deine Freunde'),
        //title:  Text('Hallo ${_auth.currentUser?.email}'),
        centerTitle: true,
        actions: [
          // sign out Button
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: _buildUserList(),
    );
  }

  // build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>( // StreamBuilder is to see and update the data flow
      stream: FirebaseFirestore.instance.collection('users').snapshots(), // specify a Stream object
      builder: (context, snapshot) {
        // At first, handle the different Situations like error, loading etc.

        // If ERROR
        if (snapshot.hasError) {
          return const Padding(
            padding:  EdgeInsets.all(150.0),
            child:  Text('error'),
          );
        }

        // If LOADING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding:  EdgeInsets.all(150.0),
            child:  Text('loading'),
          );
        }

        // Now we can return a LISTVIEW
        return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),);
      },
    );
  }

  // build individual user list items
  Widget _buildUserListItem(DocumentSnapshot document) {
    // DocumentSnapshot represent the document which is turning in Firebase Firestore
    // or any other NoSQL DataBase
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // display all users except the current user
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']), // Wrap the email with Text widget
        onTap: () {
          // pass the clicked user's UID to the chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverUserEmail: data['email'],
                receiverUserID: data['uid'],
              ),
            ),
          );
        },
      );
    } else {
      // otherwise return a blank container
      return Container();
    }
  }

}
