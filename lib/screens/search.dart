import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ucuchat/models/user_model.dart';

import '../constants.dart';

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

  _onSearchChanged() {
    readUsers();
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
          Expanded(
              child: Container(
            child: ListView.builder(
                itemCount: _resultUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 2.5, bottom: 2.5, right: 5.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Color(0xffebe9e6),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 35.0,
                              // Change to real one from db
                              backgroundImage:
                                  AssetImage('assets/images/greg.jpg'),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _resultUsers[index].name,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Text(
                                    '${_resultUsers[index].occupation}, ${_resultUsers[index].phone}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.message))
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ))
        ],
      ),
    );
  }
}
