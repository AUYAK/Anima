class PetModel {
  final String id;
  final String ownerId;
  final String name;
  final String species;
  final String? breed;
  final String? gender;
  final DateTime? dob;
  final String? photoUrl;
  final String? notes;
  final DateTime createdAt;
  final String status;
  final DateTime? statusChangedAt;

  const PetModel({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.species,
    this.breed,
    this.gender,
    this.dob,
    this.photoUrl,
    this.notes,
    required this.createdAt,
    this.status = 'active',
    this.statusChangedAt,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'] as String,
      ownerId: json['owner_id'] as String,
      name: json['name'] as String,
      species: json['species'] as String,
      breed: json['breed'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] != null ? DateTime.parse(json['dob'] as String) : null,
      photoUrl: json['photo_url'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: json['status'] as String? ?? 'active',
      statusChangedAt: json['status_changed_at'] != null
          ? DateTime.parse(json['status_changed_at'] as String)
          : null,
    );
  }

  PetModel copyWith({String? photoUrl}) {
    return PetModel(
      id: id,
      ownerId: ownerId,
      name: name,
      species: species,
      breed: breed,
      gender: gender,
      dob: dob,
      photoUrl: photoUrl ?? this.photoUrl,
      notes: notes,
      createdAt: createdAt,
      status: status,
      statusChangedAt: statusChangedAt,
    );
  }
}
