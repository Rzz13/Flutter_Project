class Profile {
  int? id;
  String name;
  String bio;
  int nim60;
  String coverPhoto;
  String profilePhoto;

  Profile({
    this.id,
    required this.name,
    required this.bio,
    required this.nim60,
    required this.coverPhoto,
    required this.profilePhoto,
  });

  Profile copyWith({
    int? id,
    String? name,
    String? bio,
    int? nim60,
    String? coverPhoto,
    String? profilePhoto,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      nim60: nim60 ?? this.nim60,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      name: map['name'],
      bio: map['bio'],
      nim60: map['nim60'],
      coverPhoto: map['coverPhoto'],
      profilePhoto: map['profilePhoto'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'bio': bio,
      'nim60': nim60,
      'coverPhoto': coverPhoto,
      'profilePhoto': profilePhoto,
    };
  }
}
