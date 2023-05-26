import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static final userTable = FirebaseFirestore.instance.collection("users");

  static addUserData({
    required String userId,
    required String userName,
    required String email,
    required String imageUrl,
  }) async {
    await userTable.doc(userId).set({
      'username': userName,
      'email': email,
      'image_url': imageUrl,
    });
  }

  static getUserDataById(String id) async {
    return await userTable.doc(id).get();
  }
}
