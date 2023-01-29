
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter/utils/authentication.dart';
import 'package:twitter/view/screen.dart';
import 'package:twitter/view/start_up/create_account_page.dart';
import 'package:twitter/view/time_line/time_line_page.dart';

class loginValidate extends StatefulWidget {
  const loginValidate({Key? key}) : super(key: key);

  @override
  State<loginValidate> createState() => _loginValidateState();
}

class _loginValidateState extends State<loginValidate> {
  bool _isObscure = true;
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('null-safe'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          //ここから入力欄
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'メールアドレスが入力されていません!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'メールアドレスを入力してください',
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: passController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'パスワードが入力されていません!';
                      }
                      return null;
                    },
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            })),
                  ),
                ),

                //ここから新規作成ページへ飛ぶ
                SizedBox(height: 10),
                RichText(text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: 'アカウントを作成していない方は'),
                  ],
                  ),
                ),

                 SizedBox(height: 10),
                 Center(
                   child: ElevatedButton(
                    onPressed: () async {
                      var result = await Navigator.push(// ・・・①
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAccount(),
                        ),
                      );
                      print("MyHomePage result: $result");
                    },
                    child: Text("こちらへ"),
                ),
                 ),

                //ログインボタン
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                      onPressed: () async{
                        var result = await Authentication.signIn(
                            email: emailController.text,
                            pass: passController.text
                        );

                        if(result == true){
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(
                              builder: (context) => NewsFeedPage1()
                          ));
                        }

                        if (_formkey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')),
                          );
                        }
                      }, child: Text('ログイン')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}