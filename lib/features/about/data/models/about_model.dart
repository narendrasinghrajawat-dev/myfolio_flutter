import '../../domain/entities/about_entity.dart';

class AboutModel extends AboutEntity {
  const AboutModel({
    required super.id,
    required super.title,
    required super.description,
    super.resumeUrl,
    super.email,
    super.phone,
    super.location,
    super.website,
    super.linkedin,
    super.github,
    super.twitter,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) {
    return AboutModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      resumeUrl: json['resumeUrl'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      website: json['website'] as String?,
      linkedin: json['linkedin'] as String?,
      github: json['github'] as String?,
      twitter: json['twitter'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'resumeUrl': resumeUrl,
      'email': email,
      'phone': phone,
      'location': location,
      'website': website,
      'linkedin': linkedin,
      'github': github,
      'twitter': twitter,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  AboutEntity toEntity() {
    return AboutEntity(
      id: id,
      title: title,
      description: description,
      resumeUrl: resumeUrl,
      email: email,
      phone: phone,
      location: location,
      website: website,
      linkedin: linkedin,
      github: github,
      twitter: twitter,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
