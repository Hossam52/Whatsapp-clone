import 'package:firebase_database/firebase_database.dart';
import 'package:whatsappclone/config/constants.dart';
import 'package:whatsappclone/model_view_controller/chats/cubits/all_chats_cubit.dart';
import 'package:whatsappclone/models/messege_model.dart';
import 'package:whatsappclone/models/user_model.dart';

class FirebaseRealTime {
  static FirebaseRealTime instance = FirebaseRealTime._();
  static DatabaseReference _rootRef = FirebaseDatabase().reference();
  static DatabaseReference _usersRef = _rootRef.child(USERS_FIREBASE);
  static DatabaseReference _chatsRef = _rootRef.child(CHATS_FIREBASE);
  FirebaseRealTime._();
  Stream<Event> getAllChats(String userId) {
    final userData = _usersRef.child(userId);
    final allChatsStream =
        userData.child('chats').orderByChild('/last_messege/time').onValue;
    return allChatsStream;
  }

  Stream<Event> getAllChatMessages(String chatId) {
    final DatabaseReference chatData = _chatsRef.child(chatId);
    final chatDataStream = chatData.child('messeges').onValue;

    return chatDataStream;
  }

  void sendMessege(String chatId, String friendId, MessegeModel messege) async {
    final chatRef = await checkIfChatExist(chatId);
    if (!chatRef.exists) {
      await _setInitalChatData(chatId, currentUserId, friendId, messege);
      await _setInitalChatData(chatId, friendId, currentUserId, messege,
          unReadedMesseges: 1);
    }
    final chatMesseges = _chatsRef.child(chatId).child('messeges');
    chatMesseges.push().set(messege.toMap());
    _usersRef.update({
      '/$currentUserId/chats/$friendId/last_messege': messege.toMap(),
      '/$friendId/chats/$currentUserId/last_messege': messege.toMap(),
    });
  }

  Future<void> _setInitalChatData(
      String chatId, String currentUser, String friendId, MessegeModel messege,
      {int unReadedMesseges = 0}) async {
    var chat = _usersRef.child(currentUser).child('/chats').child(friendId);
    await chat.set({
      'id': chatId,
      'un_read_messeges': unReadedMesseges,
      'friend_id': friendId,
      'chat_name': friendId,
      'chat_image': 'assets/images/person_image.jpg',
      'last_messege': messege.toMap()
    });
  }

  void addNewUser(UserModel model) {
    _usersRef.child('/${model.phone}').set(model.toMap());
  }

  void startChat(String userId, MessegeModel messege) async {
    final chatKey = await _createChatRefrence(messege);
    _addChatRefToMeAndOthers(
        senderId: currentUserId,
        friendId: userId,
        chatId: chatKey,
        messege: messege);
    _addChatRefToMeAndOthers(
        friendId: userId,
        senderId: currentUserId,
        chatId: chatKey,
        messege: messege);
  }

  Future<bool> checkIfUserExist(String userId) async {
    final searchedUser = await _usersRef.orderByKey().equalTo(userId).once();
    print(searchedUser.exists);
    return searchedUser.exists;
  }

  Future<DataSnapshot> checkIfChatExist(String chatId) async {
    final allUserChats = _usersRef.child(currentUserId).child('chats');
    final chat = await allUserChats.orderByKey().equalTo(chatId).once();
    return chat;
  }

  Future<DataSnapshot> getChatContent(String userId) async {
    final friendIdFounded = await checkIfUserExist(userId);
    if (friendIdFounded) {
      final chat = await checkIfChatExist(userId);
      return chat;
    } else
      return null;
  }

  Future<String> _createChatRefrence(MessegeModel messege) async {
    final chatKey = createChatKey();
    final newChatRef = _chatsRef.child(chatKey);
    final messegesRef = newChatRef.child('messeges');
    final newMessegeRef = messegesRef.push();
    await newMessegeRef.set(messege.toMap());
    return newChatRef.key;
  }

  String createChatKey() {
    final newChatRef = _chatsRef.push();
    return newChatRef.key;
  }

  void _addChatRefToMeAndOthers(
      {String senderId, String friendId, String chatId, MessegeModel messege}) {
    final userReference = _usersRef.child(friendId);
    final chatsRef = userReference.child('chats');
    chatsRef.child(chatId).set({
      'id': chatId,
      'un_read_messeges': 0,
      'friend_id': senderId,
      'chat_name': 'Test chat',
      'chat_image': 'assets/images/person_image.jpg',
      'last_messege': messege.toMap()
    });
  }
}
