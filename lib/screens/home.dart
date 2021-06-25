import 'package:flutter/material.dart';
import 'package:ucuchat/constants.dart';
import 'package:ucuchat/utils.dart';
import 'package:ucuchat/screens/all_chats.dart' as chatsScreen;
import 'package:ucuchat/screens/user.dart' as userScreen;
import 'package:ucuchat/screens/search.dart' as searchScreen;

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("UCU Chat"),
          backgroundColor: primaryColor,
          bottom: new TabBar(controller: tabController, tabs: <Tab>[
            new Tab(icon: new Icon(Icons.chat)),
            new Tab(icon: new Icon(Icons.search)),
            new Tab(icon: new Icon(Icons.person)),
          ])),
      body: new TabBarView(
        children: <Widget>[
          new chatsScreen.AllChats(),
          new searchScreen.SearchUsers(),
          new userScreen.UserPage(),
        ],
        controller: tabController,
      ),
    );
  }
}

Container getTopText(text) {
  return Container(
    margin: const EdgeInsets.only(top: 80.0, bottom: 20.0),
    child: Text(
      text,
      style: AppTextStyles.robotoRed21Bold,
    ),
  );
}
