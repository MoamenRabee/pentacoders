class UserModel{
  String? name;
  String? image;
  String? cover_image;
  String? bio;
  String? phone;
  String? email;
  String? uId;

  UserModel({
    this.name,
    this.image,
    this.cover_image,
    this.bio,
    this.phone,
    this.email,
    this.uId,
  });

  UserModel.fromJson(Map<String,dynamic> json){
    name = json["name"];
    image = json["image"];
    cover_image = json["cover_image"];
    bio = json["bio"];
    phone = json["phone"];
    email = json["email"];
    uId = json["uId"];
  }

  Map<String,dynamic> toMap(){
    return {
      "name":name,
      "image":image,
      "cover_image":cover_image,
      "bio":bio,
      "phone":phone,
      "email":email,
      "uId":uId,
    };
  }


}