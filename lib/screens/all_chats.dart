import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ucuchat/constants.dart';
import 'package:ucuchat/models/message_model.dart';
import 'package:ucuchat/models/serializer.dart';
import 'package:ucuchat/models/user_model.dart';
import 'package:ucuchat/net/api_methods.dart';
import 'package:ucuchat/screens/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class AllChats extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<Message> chats = <Message>[];
//     loadMessagesFromJson().then((value) => chats = value);
//     // if (chats == null)
//     return Expanded(
//         child: Container(
//       child: ListView.builder(
//         itemCount: chats!.length,
//         itemBuilder: (BuildContext context, int index) {
//           final Message chat = chats![index];
//           return GestureDetector(
//             onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => ChatScreen(
//                     user: chat.sender,
//                   ),
//                 )),
//             child: Container(
//               margin: EdgeInsets.only(top: 2.5, bottom: 2.5, right: 5.0),
//               padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//               decoration: BoxDecoration(
//                 color: Color(0xffebe9e6),
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(20.0),
//                   bottomRight: Radius.circular(20.0),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: <Widget>[
//                       CircleAvatar(
//                         radius: 35.0,
//                         backgroundImage: AssetImage(chat.sender.imageUrl),
//                       ),
//                       SizedBox(
//                         width: 10.0,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             chat.sender.name,
//                             style: TextStyle(
//                               color: primaryColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5.0,
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.45,
//                             child: Text(
//                               chat.text,
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w500,
//                                 // fontSize: 13.0,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                   Column(
//                     children: <Widget>[
//                       Text(
//                         chat.time,
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     ));
//   }
// }

class AllChats extends StatefulWidget {
  @override
  _AllChatsState createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  late List<Map<String, dynamic>> _chats = [{}];

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
      if (snapshotmsgs.docs.isNotEmpty) {
        mymap[i]["messages"] =
            snapshotmsgs.docs.map((e) => Message.fromDocument(e)).toList();
        // print("MESSAGE: " + (mymap[i]["messages"][0] as Message).content);
        chats.add(mymap[i]);
      } else {
        print("empty");
      }
      // chats.add(mymap[i]);
    }

    setState(() {
      // print("setting chat");
      // chats.removeAt(0);
      _chats = chats;
      // print("SETTIN STATE");
      // print(_chats);
    });
    // chatsStream.forEach((element) {
    //   print(element == null ? "is null" : 'not bull');
    //   var el = element as Map<String, dynamic>;
    //   print(el);
    // });
    // print("updated");
  }

  Widget buildChats() {
    final instance = FirebaseFirestore.instance;

    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("messages")
            // .doc()
            // .collection(collectionPath)

            // .limit(_limit)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            // print("gothere");
            // print(snapshot.data?.docs.length);
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

  Widget chatListBuilder(AsyncSnapshot<QuerySnapshot> doc) {
    return ListView.builder(
      itemCount: _chats.length,
      itemBuilder: (BuildContext context, int index) {
        final chat = _chats[index];
        final Message lastMessage = chat["messages"][0] != null
            ? chat['messages'][0] as Message
            : Message(
                senderName: "senderName", time: "time", content: "content");
        // print(_chats);
        print(chat);
        // snap.
        // print(chat);
        // final msgs = chat["messages"]? as List<Map<String, dynamic>>;
        // print(msgs);
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(
                  title: chat["chatName"],
                ),
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
                    // CircleAvatar(
                    //   radius: 35.0,
                    //   backgroundImage: Image.network(usr.imageUrl,
                    //       fit: BoxFit.cover,
                    //       width: 50.0,
                    //       height: 50.0, loadingBuilder: (BuildContext context,
                    //           Widget child, ImageChunkEvent? loadingProgress) {
                    //     if (loadingProgress == null) return child;
                    //     return Container(
                    //       width: 50,
                    //       height: 50,
                    //       child: Center(
                    //         child: CircularProgressIndicator(
                    //           color: primaryColor,
                    //           value: loadingProgress.expectedTotalBytes !=
                    //                       null &&
                    //                   loadingProgress.expectedTotalBytes != null
                    //               ? loadingProgress.cumulativeBytesLoaded /
                    //                   loadingProgress.expectedTotalBytes!
                    //               : null,
                    //         ),
                    //       ),
                    //     );
                    //   }, errorBuilder: (context, object, stackTrace) {
                    //     return Icon(
                    //       Icons.account_circle,
                    //       size: 50.0,
                    //       color: greyColor,
                    //     );
                    //   }).image,
                    // ),
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
    );
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
