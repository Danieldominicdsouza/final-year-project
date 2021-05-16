import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/src/helperfunctions/sharedpref_helper.dart';
import 'package:movie_mate/src/services/chat_service.dart';

import 'chat_screen.dart';

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  bool isSearching = false;
  String myName, myProfilePic, myUserName, myEmail;
  Stream usersStream, chatRoomsStream;

  TextEditingController searchUsernameEditingController =
      TextEditingController();

  getMyInfoFromSharedPreference() async {
    myName = await SharedPreferenceHelper().getUserName();
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl() ?? '';
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  onSearchBtnClick() async {
    isSearching = true;
    setState(() {});
    usersStream = await ChatService()
        .getUserByUserName(searchUsernameEditingController.text);

    setState(() {});
  }

  Widget chatRoomsList() {
    return Expanded(
      child: Container(
        child: StreamBuilder(
          stream: chatRoomsStream,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data.docs[index];
                      return ChatRoomListTile(
                          ds["lastMessage"], ds.id, myUserName);
                    })
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget searchListUserTile({String profileUrl, name, username, email}) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdByUsernames(myUserName, username);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUserName, username]
        };
        ChatService().createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(username, name)));
      },
      child: Container(
          //margin: EdgeInsets.symmetric(vertical: 8, horizontal: 40),
          child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[850],
          foregroundImage: NetworkImage(profileUrl),
          child: Icon(Icons.person, color: Colors.grey),
        ),
        title: Text(
          username, //TODO: Made change here
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text(email),
      )
          // Row(
          //   children: [
          //     ClipRRect(
          //       borderRadius: BorderRadius.circular(40),
          //       child: Image.network(
          //         profileUrl,
          //         height: 40,
          //         width: 40,
          //       ),
          //     ),
          //     SizedBox(width: 12),
          //     Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [Text(name), Text(email)])
          //   ],
          // ),
          ),
    );
  }

  Widget searchUsersList() {
    return StreamBuilder(
      stream: usersStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return searchListUserTile(
                      profileUrl: ds["photoURL"],
                      name: ds["username"],
                      email: ds["email"],
                      username: ds["username"]);
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  getChatRooms() async {
    chatRoomsStream = await ChatService().getChatRooms();
    setState(() {});
  }

  onScreenLoaded() async {
    await getMyInfoFromSharedPreference();
    getChatRooms();
  }

  @override
  void initState() {
    onScreenLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              isSearching
                  ? GestureDetector(
                      onTap: () {
                        isSearching = false;
                        searchUsernameEditingController.text = "";
                        setState(() {});
                      },
                      child: Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(Icons.arrow_back_ios)),
                    )
                  : Container(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: searchUsernameEditingController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "username"),
                      )),
                      GestureDetector(
                          onTap: () {
                            if (searchUsernameEditingController.text != "") {
                              onSearchBtnClick();
                            }
                          },
                          child: Icon(Icons.search))
                    ],
                  ),
                ),
              ),
            ],
          ),
          isSearching ? searchUsersList() : chatRoomsList()
        ],
      ),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String lastMessage, chatRoomId, myUsername;
  ChatRoomListTile(this.lastMessage, this.chatRoomId, this.myUsername);

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String profilePicUrl = "", name = "", username = "";

  getThisUserInfo() async {
    username =
        widget.chatRoomId.replaceAll(widget.myUsername, "").replaceAll("_", "");
    QuerySnapshot querySnapshot = await ChatService().getUserInfo(username);
    print(
        "something ${querySnapshot.docs[0].id} ${querySnapshot.docs[0]["username"]}  ${querySnapshot.docs[0]["photoURL"]}");
    name = "${querySnapshot.docs[0]["username"]}";
    profilePicUrl =
        "${querySnapshot.docs[0]["photoURL"]}"; //TODO: Made change here
    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(username, name)));
      },
      child: Container(
        //margin: EdgeInsets.symmetric(vertical: 20),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[850],
            foregroundImage: NetworkImage(profilePicUrl),
            child: Icon(Icons.person, color: Colors.grey),
          ),
          title: Text(
            username, //TODO: Made change here
            style: TextStyle(fontSize: 16),
          ),
          subtitle: Text(widget.lastMessage),
        ),
        //     Expanded(
        //   child: Row(
        //     children: [
        //       ClipRRect(
        //         borderRadius: BorderRadius.circular(30),
        //         child: Image.network(
        //           profilePicUrl,
        //           height: 40,
        //           width: 40,
        //         ),
        //       ),
        //       SizedBox(width: 12),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             username, //TODO: Made change here
        //             style: TextStyle(fontSize: 16),
        //           ),
        //           SizedBox(height: 3),
        //           Text(widget.lastMessage)
        //         ],
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
