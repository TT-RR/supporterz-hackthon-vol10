import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter/utils/authentication.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text('新規作成',style: TextStyle(color: Colors.black),),
      ),

      body: Center(
        child: Column(
          children: [
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
                    ){
                    var result = await Authentication.signUp(email: emailController.text, pass: passController.text);
                    if(result == true){
                      Navigator.pop(context);
                    }
                }
            },
            child: Text('アカウント作成')
            ),
          ],
        ),
      ),
    );

  }
}

