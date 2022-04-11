class ElectionModel {
  String electionId;
  String name;
  ElectionModel({
    this.electionId = '',
    this.name = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'electionId': electionId,
      'name': name,
    };
  }

  factory ElectionModel.fromMap(Map<String, dynamic> map) {
    return ElectionModel(
      electionId: map['electionId'] ?? '',
      name: map['name'] ?? '',
    );
  }
  @override
  String toString() => 'ElectionModel(electionId: $electionId, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ElectionModel &&
        other.electionId == electionId &&
        other.name == name;
  }

  @override
  int get hashCode => electionId.hashCode ^ name.hashCode;
}
