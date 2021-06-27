import 'package:flutter/material.dart';
import 'package:ucuchat/constants.dart';
import 'package:ucuchat/models/message_model.dart';
import 'package:ucuchat/models/user_model.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  ChatScreen({required this.user});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _buildMessage(Message message, bool isMe) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${message.sender.name}, ${message.time}',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            message.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user.name,
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
                  final Message message = messages[index];
                  final bool isMe = message.sender.id == currentUser.id;
                  return _buildMessage(message, isMe);
                },
                itemCount: messages.length,
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
