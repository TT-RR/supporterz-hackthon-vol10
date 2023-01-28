  import 'package:flutter/material.dart';
import 'package:twitter/model/account.dart';
import 'package:twitter/view/time_line/post_page.dart';
import 'package:twitter/view/time_line/time_line_page.dart';

  class AccountPage extends StatefulWidget {

      Account myAccount =Account(
        "1",
        "こんにちわ",
        "John Doe",
        "john_doe",
        "https://picsum.photos/id/1062/80/80",
      );

    @override
    State<AccountPage> createState() => _AccountPageState();
  }

  class _AccountPageState extends State<AccountPage> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          children: [
            //写真を表示する
            const Expanded(flex: 2, child: _TopPortion()),
            //名前を表示する
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      myAccount.fullName,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '@${myAccount.userName}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //編集ボタン
                        FloatingActionButton.extended(
                          onPressed: () {

                          },
                          heroTag: 'follow',
                          elevation: 0,
                          label: const Text("編集"),
                          icon: const Icon(Icons.person_add_alt_1),
                        ),
                        //メッセージボタン
                        const SizedBox(width: 16.0),
                        FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) => PostPage()));
                          },
                          heroTag: 'mesage',
                          elevation: 0,
                          backgroundColor: Colors.red,
                          label: const Text("Message"),
                          icon: const Icon(Icons.message_rounded),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const _ProfileInfoRow()
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  class _ProfileInfoRow extends StatelessWidget {
    const _ProfileInfoRow({Key? key}) : super(key: key);

    final List<ProfileInfoItem> _items = const [
      ProfileInfoItem("Posts", 900),
      ProfileInfoItem("Followers", 120),
      ProfileInfoItem("Following", 200),
    ];

    @override
    Widget build(BuildContext context) {
      return Container(
        height: 80,
        constraints: const BoxConstraints(maxWidth: 400),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _items
              .map((item) => Expanded(
              child: Row(
                children: [
                  if (_items.indexOf(item) != 0) const VerticalDivider(),
                  Expanded(child: _singleItem(context, item)),
                ],
              )))
              .toList(),
        ),
      );
    }

    Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item.value.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Text(
          item.title,
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }

  class ProfileInfoItem {
    final String title;
    final int value;
    const ProfileInfoItem(this.title, this.value);
  }

  class FabExample extends StatelessWidget {
    const FabExample({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('FloatingActionButton Sample'),
        ),
        body: const Center(child: Text('Press the button below!')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.mode_edit),
        ),
      );
    }
  }

  //写真を表示する
  class _TopPortion extends StatelessWidget {
    const _TopPortion({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xff0043ba), Color(0xff006df1)]),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(myAccount.imageUrl),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }
  }