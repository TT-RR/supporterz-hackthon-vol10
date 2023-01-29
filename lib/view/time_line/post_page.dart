import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {

  @override
  _PostPagePageState createState() => _PostPagePageState();
}

class _PostPagePageState extends State {

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新規投稿画面"),
      ),
      body: Center(
        child: TextField(
          controller: _textEditingController,
          enabled: true,
          style: TextStyle(color: Colors.black),
          obscureText: false,
          decoration: const InputDecoration(
            icon: Icon(Icons.speaker_notes),
            hintText: 'ここに入力',
            labelText: '内容',
          ),
        ),
      ),

    );
  }
  Widget bottomButton() {
    return BottomAppBar(
      color: Colors.blue,
      child: TextButton(
        child: Text(
          "投稿",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: TextButton.styleFrom(
          primary: Colors.blue,
        ),
        onPressed: (){ },
      ),
    );
  }
}