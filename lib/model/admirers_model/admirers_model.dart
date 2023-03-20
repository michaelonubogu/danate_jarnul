import 'dart:convert';
import 'package:hive/hive.dart';
part 'admirers_model.g.dart';


List<AdmirerModel> admirerModelFromJson(String str) => List<AdmirerModel>.from(json.decode(str).map((x) => AdmirerModel.fromJson(x)));

String admirerModelToJson(List<AdmirerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 2)
class AdmirerModel extends HiveObject{
  AdmirerModel({
    required this.id,
    required this.userId,
    required this.profile,
    required this.featureImages,
    required this.dob,
    required this.zodiacSign,
    required this.rate,
    required this.description,
    required this.myLikes,
    required this.myDislikes,
    required this.socialMedia,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String userId;
  @HiveField(2)
  final String profile;
  @HiveField(3)
  final List<FeatureImage> featureImages;
  @HiveField(4)
  final String dob;
  @HiveField(5)
  final String zodiacSign;
  @HiveField(6)
  final String rate;
  @HiveField(7)
  final String description;
  @HiveField(8)
  final String myLikes;
  @HiveField(9)
  final String myDislikes;
  @HiveField(10)
  final SocialMedia socialMedia;

  factory AdmirerModel.fromJson(Map<String, dynamic> json) => AdmirerModel(
    id: json["id"],
    userId: json["user_id"],
    profile: json["profile"],
    featureImages: List<FeatureImage>.from(json["feature_images"].map((x) => FeatureImage.fromJson(x))),
    dob: json["dob"],
    zodiacSign: json["zodiac_sign"],
    rate: json["rate"],
    description: json["description"],
    myLikes: json["my_likes"],
    myDislikes: json["my_dislikes"],
    socialMedia: SocialMedia.fromJson(json["social_media"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "profile": profile,
    "feature_images": List<dynamic>.from(featureImages.map((x) => x.toJson())),
    "dob": dob,
    "zodiac_sign": zodiacSign,
    "rate": rate,
    "description": description,
    "my_likes": myLikes,
    "my_dislikes": myDislikes,
    "social_media": socialMedia.toJson(),
  };
}

@HiveType(typeId: 3)
class FeatureImage {
  FeatureImage({

    required this.image,
  });
  @HiveField(0)
  final String image;

  factory FeatureImage.fromJson(Map<String, dynamic> json) => FeatureImage(
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
  };
}

@HiveType(typeId: 4)
class SocialMedia {
  SocialMedia({
    required this.name,
    required this.link,
  });

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String link;

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
    name: json["name"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "link": link,
  };
}
