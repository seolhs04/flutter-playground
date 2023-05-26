import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/apps/chatApp/services/user_service.dart';

class ChatService {
  static final chatTable = FirebaseFirestore.instance.collection('chat');

  static sendChat(String message) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userData = await UserService.getUserDataById(userId);

    await chatTable.add({
      'text': message,
      'createdAt': Timestamp.now(),
      'userId': userId,
      'username': userData.data()!['username'],
      'userImage': userData.data()!['image_url'],
    });
  }
}
