class PostModel{
  String? name;
  String? uId;
  String? postId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel({
    this.name,
    this.uId,
    this.postId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
  });

  PostModel.fromJson(Map<String,dynamic> json){
    name = json["name"];
    uId = json["uId"];
    postId = json["postId"];
    image = json["image"];
    dateTime = json["dateTime"];
    text = json["text"];
    postImage = json["postImage"];
  }

  Map<String,dynamic> toMap(){
    return {
      "name":name,
      "postId":uId,
      "uId":postId,
      "image":image,
      "dateTime":dateTime,
      "text":text,
      "postImage":postImage,
    };
  }

}