import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ucuchat/models/user_model.dart';

class SearchUsers extends StatefulWidget {
  @override
  _SearchUsersState createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  List<User> _allUsers = [];
  List<User> _resultUsers = [];
  TextEditingController _searchController = TextEditingController();

  searchResultsList() {
    List<User> showResults = [];
    if (_searchController.text != "") {
      for (var currUser in _allUsers) {
        if (currUser.name
            .toLowerCase()
            .contains(_searchController.text.toLowerCase())) {
          showResults.add(currUser);
        }
      }
    } else {
      _resultUsers = _allUsers;
    }

    setState(() {
      _resultUsers = showResults;
    });
  }

  readUsers() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      _allUsers = snapshot.docs
          .map(
            (doc) => User(
              id: doc.id,
              name: doc.data()['name'],
              occupation: doc.data()['occupation'],
              imageUrl: doc.data()['imgUrl'],
              phone: doc.data()['phone'],
              email: doc.data()['email'],
            ),
          )
          .toList();
    });
    searchResultsList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  // @override
  // void dispose() {
  //   _searchController.removeListener(_onSearchChanged);
  //   _searchController.dispose();
  //   super.dispose();
  // }

  _onSearchChanged() {
    print(_searchController.text);
    readUsers();
  }

  _buildUserCard(User user) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              Text(user.name),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
            ),
          ),
          // Padding(
          //   padding:
          //       const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
          //   child: TextField(
          //     controller: _searchController,
          //     decoration: InputDecoration(
          //       prefixIcon: Icon(Icons.search),
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
                itemCount: _resultUsers.length,
                itemBuilder: (BuildContext context, int index) =>
                    _buildUserCard(_resultUsers[index])),
          )
        ],
      ),
    );
  }
}
