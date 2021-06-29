import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ucuchat/constants.dart';
import 'package:ucuchat/models/message_model.dart';
import 'package:ucuchat/models/user_model.dart';
import 'package:ucuchat/net/api_methods.dart';
import 'package:ucuchat/screens/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllChats extends StatefulWidget {
  @override
  _AllChatsState createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  late List<Map<String, dynamic>> _chats = [{}];
  late User _currentUser;
  int _limit = 20;
  _AllChatsState() {
    updateChats();
    FirebaseFirestore.instance
        .collection("messages")
        .snapshots()
        .listen((event) {
      print("UPDATING");
      if (mounted) {
        updateChats();
      }
    });
    // FirebaseFirestore.instance
    // .collection("messages")
    // loadMessagesFromJson().then((value) => updateChats(value));
  }
  void updateChats() async {
    // print("updating" + (msgs.isEmpty ? "Empty" : "not empty"));
    print("from update chats");
    var snapshot =
        await FirebaseFirestore.instance.collection("messages").get();

    var curUsers = await FirebaseFirestore.instance.collection("users").get();

    // var smth = ;

    _currentUser = curUsers.docs
        .where((element) =>
            User.fromDocument(element as DocumentSnapshot).id ==
            getCurrentUserId())
        .map((e) => User.fromDocument(e as DocumentSnapshot))
        .toList()[0];

    // print("CURRENT USER" + curUser[0].name);

    List<Map<String, dynamic>> chats = [];
    final List<Map<String, dynamic>> mymap = snapshot.docs
        .map((doc) => {"id": doc.id, "chatName": doc.data()["chatName"]})
        .toList() as List<Map<String, dynamic>>;
    mymap.forEach((element) {
      print(element["chatName"]);
    });
    for (int i = 0; i < mymap.length; ++i) {
      // var element =
      var snapshotmsgs = await FirebaseFirestore.instance
          .collection("messages")
          .doc(mymap[i]["id"])
          .collection("messages")
          .orderBy("time", descending: true)
          .get();

      final chatPersonalList =
          _currentUser.personalChats.map((e) => e["chatId"]).toList();

      // getCurrentUserId();
      if ((chatPersonalList.contains(mymap[i]["id"]) ||
          _currentUser.chatsList.contains(mymap[i]["id"]))) {
        if (snapshotmsgs.docs.isNotEmpty) {
          mymap[i]["messages"] =
              snapshotmsgs.docs.map((e) => Message.fromDocument(e)).toList();
        } else {
          mymap[i]["messages"] = [];
        }

        // print("MESSAGE: " + (mymap[i]["messages"][0] as Message).content);
        chats.add(mymap[i]);
      } else {
        print("empty");
      }
      // chats.add(mymap[i]);
    }

    setState(() {
      _chats = chats;
    });
  }

  Widget buildChats() {
    if (_chats.length == 1 && _chats[0].isEmpty) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
      ));
    } else {
      return Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("messages").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return chatListBuilder(snapshot);
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              );
            }
          },
        ),
      );
    }
  }

  Future<void> _onRefresh() {
    updateChats();
    return Future(() => print(""));
  }

  Widget chatListBuilder(AsyncSnapshot<QuerySnapshot> doc) {
    return RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: ListView.builder(
          itemCount: _chats.length,
          itemBuilder: (BuildContext context, int index) {
            final chat = _chats[index];
            final Message lastMessage = List.from(chat["messages"]).isNotEmpty
                ? chat['messages'][0] as Message
                : Message(
                    senderName: " ", senderId: " ", time: "", content: "");

            print("CHAT" + chat.toString());
            if (chat.isEmpty)
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              );
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                        title: chat["chatName"],
                        chatId: chat["id"],
                        userName: _currentUser.name),
                  )),
              child: Container(
                margin: EdgeInsets.only(top: 2.5, bottom: 2.5, right: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chat['chatName'],
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Text(
                                lastMessage.content,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  // fontSize: 13.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          lastMessage.time,
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    // if (_chats.isEmpty) {
    //   loadMessagesFromJson().then((value) => updateChats(value));
    // }
    // updateChats();
    return buildChats();
  }
}
