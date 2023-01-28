class Post{
  String id;    //id
  String content;   //コンテンツ
  String postAccountId;  //投稿する人のid
  DateTime? createdTine; //上げた時間

  Post({
    this.id = '',
    this.content = '',
    this.postAccountId = '',
    this.createdTine,
  });
}