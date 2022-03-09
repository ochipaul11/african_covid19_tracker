import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: const<Widget>[
            UserAccountsDrawerHeader(
                accountName: Text('Paul Okeyo'),
                accountEmail: Text('paulokeyo@hotmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage:
                  NetworkImage('https://images.unsplash.com/photo-1492681290082-e932832941e6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80'),
                )),
            ListTile(
              title: Text("Email"),
              subtitle: Text("Paulokeyo@htmail.com"),
              trailing: Icon(Icons.edit),
              // onTap: _changeName,
            ),
            ListTile(
              title: Text("Paul Okeyo"),
              subtitle: Text('Developer'),
              trailing: Icon(Icons.edit),
              // onTap: _changeName,
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Center(
        child: Text("Account",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black45,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
