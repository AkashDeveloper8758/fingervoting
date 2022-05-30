class ElectionModel {
  String electionId;
  String name;
  ElectionModel(
    this.electionId,
    this.name,
  );

  factory ElectionModel.fromMap(Map<String, dynamic> map) {
    return ElectionModel(
      map['electionId'] ?? '',
      map['electionName'] ?? '',
    );
  }

  @override
  String toString() => 'ElectionModel(electionId: $electionId, name: $name)';
}
