import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/src/helperfunctions/sharedpref_helper.dart';
import 'package:movie_mate/src/models/liked_movie.dart';
import 'package:movie_mate/src/services/chat_service.dart';
import 'package:random_string/random_string.dart';

class ChatScreen extends StatefulWidget {
  final String chatWithUsername, name;
  ChatScreen(this.chatWithUsername, this.name);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String chatRoomId, messageId = "";
  Stream messageStream;
  String myName, myProfilePic, myUserName, myEmail;
  TextEditingController messageTextEditingController = TextEditingController();

  getMyInfoFromSharedPreference() async {
    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();

    chatRoomId = getChatRoomIdByUsernames(widget.chatWithUsername, myUserName);
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessage(bool sendClicked) {
    if (messageTextEditingController.text.isNotEmpty) {
      //TODO: Made change here
      String message =
          messageTextEditingController.text.trim(); //TODO: Made change here

      var lastMessageTs = DateTime.now();

      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myUserName,
        "ts": lastMessageTs,
        "photoURL": myProfilePic //TODO: made change here
      };

      //messageId
      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }

      ChatService()
          .addMessage(chatRoomId, messageId, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy": myUserName
        };

        ChatService().updateLastMessageSend(chatRoomId, lastMessageInfoMap);

        if (sendClicked) {
          // remove the text in the message input field
          messageTextEditingController.text = "";
          // make message id blank to get regenerated on next message send
          messageId = "";
        }
      });
    }
  }

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomRight:
                      sendByMe ? Radius.circular(0) : Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft:
                      sendByMe ? Radius.circular(24) : Radius.circular(0),
                ),
                color: sendByMe ? Colors.blue : Colors.blueGrey,
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 70, top: 16),
                itemCount: snapshot.data.docs.length,
                reverse: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return chatMessageTile(
                      ds["message"], myUserName == ds["sendBy"]);
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  getAndSetMessages() async {
    messageStream = await ChatService().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
    getAndSetMessages();
  }

  onMatchPressed() async {
    List<LikedMovie> commonLikedMovies = await ChatService()
        .getCommonLikedMovies(myName, widget.chatWithUsername);
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.grey[900],
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  FutureBuilder<double>(
                      future: getMatchPercentage(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return CircularProgressIndicator();

                        return Text(
                          snapshot.data.toStringAsFixed(1) + ' %',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RobotoCondensed'),
                        );
                      }),
                  SizedBox(height: 10),
                  Text(
                    '${commonLikedMovies.length.toString()} Common Movies',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                        itemCount: commonLikedMovies.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            leading: Image.network(
                                commonLikedMovies[index].posterURL),
                            title: Text(commonLikedMovies[index].movieName),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<double> getMatchPercentage() async {
    double matchPercentage =
        await ChatService().getMatchPercentage(myName, widget.chatWithUsername);
    return matchPercentage;
  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          GestureDetector(
            onTap: () => onMatchPressed(),
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.orange,
              ),
              child: Text('Match'),
            ),
          ),
        ],
        // child: Row(
        //   children: [
        //     Text(widget.name),
        //     Text(getMatchPercentage().toString()),
        //   ],
        // ),
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black.withOpacity(0.8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    // GestureDetector(
                    //   onTap: () => onMatchPressed(),
                    //   child: Container(
                    //     padding: EdgeInsets.all(10),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(50),
                    //       color: Colors.orange,
                    //     ),
                    //     child: Text('Match'),
                    //   ),
                    // ),
                    SizedBox(width: 10),
                    Expanded(
                        child: TextField(
                      controller: messageTextEditingController,
                      onChanged: (value) {
                        addMessage(false);
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "type a message",
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.6))),
                    )),
                    GestureDetector(
                      onTap: () {
                        addMessage(true);
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
