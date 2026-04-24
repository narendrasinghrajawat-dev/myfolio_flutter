class UserModel {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? displayName;
  final String? role;
  final bool? isVerified;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.displayName,
    this.role,
    this.isVerified,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String? ?? map['id'] as String?,
      email: map['email'] as String?,
      firstName: map['firstName'] as String?,
      lastName: map['lastName'] as String?,
      displayName: map['displayName'] as String?,
      role: map['role'] as String?,
      isVerified: map['isVerified'] as bool?,
      isActive: map['isActive'] as bool?,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
      'role': role,
      'isVerified': isVerified,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  bool get isUserAdmin => role == '2';
  bool get isUser => role == '1';
}
