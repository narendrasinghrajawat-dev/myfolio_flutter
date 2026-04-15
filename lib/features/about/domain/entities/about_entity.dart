import 'package:equatable/equatable.dart';

class AboutEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String? resumeUrl;
  final String? email;
  final String? phone;
  final String? location;
  final String? website;
  final String? linkedin;
  final String? github;
  final String? twitter;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AboutEntity({
    required this.id,
    required this.title,
    required this.description,
    this.resumeUrl,
    this.email,
    this.phone,
    this.location,
    this.website,
    this.linkedin,
    this.github,
    this.twitter,
    required this.createdAt,
    required this.updatedAt,
  });

  AboutEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? resumeUrl,
    String? email,
    String? phone,
    String? location,
    String? website,
    String? linkedin,
    String? github,
    String? twitter,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AboutEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      resumeUrl: resumeUrl ?? this.resumeUrl,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      website: website ?? this.website,
      linkedin: linkedin ?? this.linkedin,
      github: github ?? this.github,
      twitter: twitter ?? this.twitter,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        resumeUrl,
        email,
        phone,
        location,
        website,
        linkedin,
        github,
        twitter,
        createdAt,
        updatedAt,
      ];
}
