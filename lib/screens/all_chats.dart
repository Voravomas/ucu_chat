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
  List<Message> _chats = <Message>[];

  int _limit = 20;
  _AllChatsState() {
    loadMessagesFromJson().then((value) => updateChats(value));
  }
  void updateChats(List<Message> msgs) {
    // print("updating" + (msgs.isEmpty ? "Empty" : "not empty"));
    setState(() {
      _chats.addAll(msgs);
      // print("adding " + msgs.length.toString() + " messages");
    });
    // print("updated");
  }

  Widget buildChats() {
    final instance = FirebaseFirestore.instance;
    // final myEmail = instance.collection("users").doc(currentUser.id).da;
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            // .where("id", isNotEqualTo: "2I1Quum6s9Q2V3BIFE5U8ydS6ie2")
            .limit(_limit)
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
      itemCount: doc.data?.docs.length,
      itemBuilder: (BuildContext context, int index) {
        DocumentSnapshot snap = doc.data?.docs[index] as DocumentSnapshot;
        // print(snap.exists);
        final User usr = User.fromDocument(snap) as User;
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(
                  user: usr,
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
                    CircleAvatar(
                      radius: 35.0,
                      backgroundImage: Image.network(usr.imageUrl,
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0, loadingBuilder: (BuildContext context,
                              Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                              value: loadingProgress.expectedTotalBytes !=
                                          null &&
                                      loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      }, errorBuilder: (context, object, stackTrace) {
                        return Icon(
                          Icons.account_circle,
                          size: 50.0,
                          color: greyColor,
                        );
                      }).image,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          usr.name,
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
                            "chat.text",
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
                      "chat.time",
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
    return buildChats();
  }
}
