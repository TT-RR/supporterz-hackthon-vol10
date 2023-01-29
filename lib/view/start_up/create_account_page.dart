
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/model/account.dart';
import 'package:twitter/utils/authentication.dart';
import 'package:twitter/utils/firestore/users.dart';

class CreateAccount extends StatefulWidget {

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userIDController = TextEditingController();
  TextEditingController selfIntroductionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  File? image;
  ImagePicker picker = ImagePicker();

  Future<void> getImage() async{
    //最後のところを.cameraにするとカメラが使える
    final pickedFile  = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null) {
      setState(() {
        //imageの中に選択した画像のpathを入れる
        image = File(pickedFile.path);
      });
    }
  }

  Future<String> uploadImage(String uid) async{
    final FirebaseStorage storageInstance = FirebaseStorage.instance;
    final Reference  ref = storageInstance.ref();
    await await ref.child(uid).putFile(image!);
    String downloadUrl = await storageInstance.ref(uid).getDownloadURL();
    print('image_path: $downloadUrl');
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text('新規作成',style: TextStyle(color: Colors.black),),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              GestureDetector(
                onTap: (){
                  getImage();
                },
                child: CircleAvatar(
                  foregroundImage: image == null ? null : FileImage(image!),
                  radius: 40,
                  child: Icon(Icons.add),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: '名前を入力'),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: userIDController,
                  decoration: InputDecoration(hintText: 'ユーザーIDを入力'),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: selfIntroductionController,
                  decoration: InputDecoration(hintText: '自己紹介を入力'),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: 'メールアドレスを入力'),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(hintText: 'パスワードを入力'),
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                  onPressed:() async{
                  if(nameController.text.isNotEmpty
                      && userIDController.text.isNotEmpty
                      && selfIntroductionController.text.isNotEmpty
                      && emailController.text.isNotEmpty
                      && passController.text.isNotEmpty
                      && image == null){
                      var result = await Authentication.signUp(email: emailController.text, pass: passController.text);
                      if(result is UserCredential){
                        String image_path = await uploadImage(result.user!.uid);
                        Account newAccount = Account(
                          result.user!.uid,
                          selfIntroductionController.text,
                          nameController.text,
                          userIDController.text,
                          image_path,
                        );
                        var _result = await UserFireStore.SetUser(newAccount);
                        if(_result == true){
                          Navigator.pop(context);
                        }
                      }
                  }
              },
              child: Text('アカウント作成')
              ),
            ],
          ),
        ),
      ),
    );

  }
}

