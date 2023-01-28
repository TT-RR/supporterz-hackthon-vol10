class Account{
  String name;        //ユーザの名前
  String id;          //ID
  String imagePath;   //ユーザのサイトURL
  String userID;      //ニックネーム
  String selfIntroduction; //自分の自己紹介
  DateTime? createdTime; //投稿作った時間
  DateTime? updatedTime; //編集時間

  Account({
    this.name = '',
    this.id = '',
    this.imagePath = '',
    this.userID = '',
    this.selfIntroduction = '',
    this.createdTime,
    this.updatedTime,
});
}