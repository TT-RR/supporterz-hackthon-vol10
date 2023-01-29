import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter/model/account.dart';

class UserFireStore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users = _firestoreInstance.collection(
      'users');

  static Future<dynamic> SetUser(Account newAccount) async {
    //実行して、
    try {
      //newDocにnameとimage_pathも入れる
      await users.doc(newAccount.id).set({
        'id': newAccount.id,
        'selfIntroduction': newAccount.selfIntroduction,
        'fullName': newAccount.fullName, //ユーザーの名前
        'imageUrl': newAccount.imageUrl, //ユーザーのアイコン
        'userName': newAccount.userName,
      });
      print('新規ユーザー作成完了');
      return true;
    } on FirebaseException catch (e) {
      //うまくいかないならこっちに行く
      print('新規ユーザー作成失敗 --- $e');
      return false;
    }
  }
}