import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ucuchat/constants.dart';
import 'package:ucuchat/models/message_model.dart';
import 'package:ucuchat/net/api_methods.dart';

class ChatScreen extends StatefulWidget {
  final String title;
  final String chatId;
  ChatScreen({required this.title, required this.chatId});
  @override
  _ChatScreenState createState() =>
      _ChatScreenState(title: title, chatId: this.chatId);
}

class _ChatScreenState extends State<ChatScreen> {
  final String chatId;
  final String title;

  List<Message>? _messages;
  int _limit = 20;
  _ChatScreenState({required this.title, required this.chatId}) {
    _messages = <Message>[];
    FirebaseFirestore.instance
        .collection("messages")
        .doc(chatId)
        .collection("messages")
        .orderBy("time", descending: true)
        .snapshots()
        .listen((event) {
      final docs = event.docs;
      updateMessages(docs.map((e) => e.data()).toList());
    });
  }

  void updateMessages(List<Map<String, dynamic>?> newMsgs) {
    List<Message>? msgs = <Message>[];
    newMsgs.forEach((element) {
      if (element != null) {
        msgs.add(Message.fromJson(element));
        print("ADDING MESSAGE" + Message.fromJson(element).content);
      }
    });

    setState(() {
      _messages = msgs;
    });
  }

  Future<void> _refresh() async {
    final snaps = await FirebaseFirestore.instance
        .collection("messages")
        .doc(chatId)
        .collection("messages")
        .orderBy("time", descending: true)
        .snapshots();

    final newMessages = await snaps.map((element) => element.docs).toList();
    newMessages.forEach((element) {
      updateMessages(element.map((e) => e.data()).toList());
    });
  }

  _buildMessage(Message message, bool isMe) {
    print("Building Message" + message.content);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${message.senderName}, ${message.time}',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            message.content,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: isMe ? Color(0xffebe9e6) : Color(0xfff0e9df),
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      margin: isMe
          ? EdgeInsets.only(
              top: 6.0,
              bottom: 6.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 6.0,
              bottom: 6.0,
              right: 80.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
    );
  }

  Widget _messageBuilder() {
    // print(currentUser.id == null ? "id is null" : "id is not null");
    // print(getCurrentUserId());
    // FirebaseFirestore.instance
    //       .collection("messages")
    //       .where("sender", isEqualTo: currentUser.id)
    //       .where("receiver", isEqualTo: user.id)
    //       .orderBy("time", descending: true)
    //       .limit(_limit)
    //       .snapshots().
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("messages")
          // .where("sender", isEqualTo: "2I1Quum6s9Q2V3BIFE5U8ydS6ie2")
          // .where("receiver", isEqualTo: "MSh6Prr8duqtLcnaAGr8")
          .orderBy("time", descending: true)
          .limit(_limit)
          .snapshots(),
      builder: (BuildContext conext, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          // listMessage.addAll(snapshot.data!.docs);
          return ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemBuilder: (context, index) =>
                _buildMessage(_messages![index], true),
            itemCount: _messages?.length,
            reverse: true,
            // controller: listScrollController,
          );
        } else {
          return Center(child: Text("No messages for now")
              // CircularProgressIndicator(
              //   valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              // ),
              );
        }
      },
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.photo),
            color: primaryColor,
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Your text ...',
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.send),
            color: primaryColor,
          ),
        ],
      ),
    );
  }

  // Widget buildListMessages() {
  //   return Flexible(child:
  //   )
  // }

  @override
  Widget build(BuildContext context) {
    // _messages.sort();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.only(top: 15.0),
                itemBuilder: (BuildContext context, int index) {
                  final Message message = _messages![index];
                  final bool isMe = message.senderId == getCurrentUserId();
                  return _buildMessage(message, isMe);
                },
                itemCount: _messages?.length,
              ),
              // child: _messageBuilder(),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
