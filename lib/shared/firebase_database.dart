import 'package:firebase_database/firebase_database.dart';
import 'package:whatsappclone/config/constants.dart';
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
    final allChatsStream = userData.child('chats').onValue;
    return allChatsStream;
  }

  Stream<Event> getAllChatMessages(String chatId) {
    final DatabaseReference chatData = _chatsRef.child(chatId);
    final chatDataStream = chatData.child('messeges').onValue;

    return chatDataStream;
  }

  void sendMessege(String chatId, MessegeModel messege) {
    final chatMesseges = _chatsRef.child(chatId).child('messeges');
    chatMesseges.push().set(messege.toMap());
    _usersRef.update({'/uid1/chats/$chatId/last_messege': messege.toMap()});
  }

  void addNewUser(UserModel model) {
    _usersRef.child('/${model.phone}').set(model.toMap());
  }

  void startChat(String userId, MessegeModel messege) async {
    final chatKey = await _createChatRefrence(messege);
    _addChatRefToMeAndOthers(
        senderId: 'uid1', friendId: userId, chatId: chatKey, messege: messege);
    _addChatRefToMeAndOthers(
        friendId: userId, senderId: 'uid1', chatId: chatKey, messege: messege);
  }

  Future<String> _createChatRefrence(MessegeModel messege) async {
    final newChatRef = _chatsRef.push();
    final messegesRef = newChatRef.child('messeges');
    final newMessegeRef = messegesRef.push();
    await newMessegeRef.set(messege.toMap());
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
