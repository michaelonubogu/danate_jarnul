import 'dart:convert';
import 'package:hive/hive.dart';

// Define your object class
// To parse this JSON data, do
//
//     final admirerModel = admirerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AdmirerModel> admirerModelFromJson(String str) => List<AdmirerModel>.from(json.decode(str).map((x) => AdmirerModel.fromJson(x)));

String admirerModelToJson(List<AdmirerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdmirerModel {
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

  final int id;
  final String userId;
  final String profile;
  final List<FeatureImage> featureImages;
  final String dob;
  final String zodiacSign;
  final String rate;
  final String description;
  final String myLikes;
  final String myDislikes;
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

class FeatureImage {
  FeatureImage({
    required this.image,
  });

  final String image;

  factory FeatureImage.fromJson(Map<String, dynamic> json) => FeatureImage(
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
  };
}

class SocialMedia {
  SocialMedia({
    required this.name,
    required this.link,
  });

  final String name;
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
