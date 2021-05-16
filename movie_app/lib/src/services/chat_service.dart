import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_mate/src/helperfunctions/sharedpref_helper.dart';
import 'package:movie_mate/src/models/liked_movie.dart';
import 'package:movie_mate/src/services/movie_service.dart';

class ChatService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getUserByUserName(String username) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where("username", isEqualTo: username)
        .snapshots();
  }

  Future addMessage(
      String chatRoomId, String messageId, Map messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  updateLastMessageSend(String chatRoomId, Map lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  createChatRoom(String chatRoomId, Map chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    if (snapShot.exists) {
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exists
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String myUsername = await SharedPreferenceHelper().getUserName();
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: myUsername)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }

  Future<List<LikedMovie>> getCommonLikedMovies(
      String username1, String username2) async {
    // List<String> user1LikedMovies = [];
    // List<String> user2LikedMovies = [];
    List<LikedMovie> commonLikedMovies = [];
    String user1uid, user2uid;

    QuerySnapshot user1Snapshot =
        await userCollection.where('username', isEqualTo: username1).get();
    QuerySnapshot user2Snapshot =
        await userCollection.where('username', isEqualTo: username2).get();

    user1uid = user1Snapshot.docs[0].id;
    user2uid = user2Snapshot.docs[0].id;

    QuerySnapshot user1LikedMoviesSnapshot =
        await userCollection.doc(user1uid).collection('likedMovies').get();
    QuerySnapshot user2LikedMoviesSnapshot =
        await userCollection.doc(user2uid).collection('likedMovies').get();

    List<LikedMovie> user1LikedMovies =
        MovieService().likedMoviesFromSnapshot(user1LikedMoviesSnapshot);
    List<LikedMovie> user2LikedMovies =
        MovieService().likedMoviesFromSnapshot(user2LikedMoviesSnapshot);

    user1LikedMovies.forEach((user1movie) {
      user2LikedMovies.forEach((user2movie) {
        if (user1movie.movieName == user2movie.movieName) {
          commonLikedMovies.add(user2movie);
        }
      });
      // if (user2LikedMovies.contains(movie)) {
      //   commonLikedMovies.add(movie);
      // }
    });
    user1LikedMovies.forEach((element) => print(element.movieName));
    user2LikedMovies.forEach((element) => print(element.movieName));
    commonLikedMovies.forEach((element) => print(element.movieName));

    return commonLikedMovies;
  }

  Future<double> getMatchPercentage(String username1, String username2) async {
    List<LikedMovie> commonLikedMovies = [];
    String user1uid, user2uid;
    double matchPercentage = 0;

    QuerySnapshot user1Snapshot =
        await userCollection.where('username', isEqualTo: username1).get();
    QuerySnapshot user2Snapshot =
        await userCollection.where('username', isEqualTo: username2).get();

    user1uid = user1Snapshot.docs[0].id;
    user2uid = user2Snapshot.docs[0].id;

    QuerySnapshot user1LikedMoviesSnapshot =
        await userCollection.doc(user1uid).collection('likedMovies').get();
    QuerySnapshot user2LikedMoviesSnapshot =
        await userCollection.doc(user2uid).collection('likedMovies').get();

    List<LikedMovie> user1LikedMovies =
        MovieService().likedMoviesFromSnapshot(user1LikedMoviesSnapshot);
    List<LikedMovie> user2LikedMovies =
        MovieService().likedMoviesFromSnapshot(user2LikedMoviesSnapshot);

    user1LikedMovies.forEach((user1movie) {
      user2LikedMovies.forEach((user2movie) {
        if (user1movie.movieName == user2movie.movieName) {
          commonLikedMovies.add(user2movie);
        }
      });
    });

    // matchPercentage = (commonLikedMovies.length /
    //         (user1LikedMovies.length + user2LikedMovies.length)) *
    //     100;

    // if (user1LikedMovies.length > user2LikedMovies.length)
    //   return matchPercentage =
    //       ((user1LikedMovies.length - user2LikedMovies.length) /
    //               commonLikedMovies.length) *
    //           100;
    // else
    //   return matchPercentage =
    //       ((user2LikedMovies.length - user1LikedMovies.length) /
    //               commonLikedMovies.length) *
    //           100;

    if (user1LikedMovies.length > user2LikedMovies.length)
      return matchPercentage =
          (commonLikedMovies.length / user1LikedMovies.length) * 100;
    else
      return matchPercentage =
          (commonLikedMovies.length / user2LikedMovies.length) * 100;

    //return matchPercentage;
  }
}
