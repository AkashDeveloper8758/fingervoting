class CandidateModel {
  String candidateId;
  String name;
  bool isVoted = false;
  int age;
  String partyName;
  String electionId;
  List<String> votersList;

  CandidateModel(
    this.candidateId,
    this.name,
    this.isVoted,
    this.age,
    this.partyName,
    this.electionId,
    this.votersList,
  );

  factory CandidateModel.fromMap(Map<String, dynamic> map) {
    return CandidateModel(
        map['candidateId'] ?? '',
        map['name'] ?? '',
        false,
        map['age']?.toInt() ?? 0,
        map['partyName'] ?? '',
        map['electionId'] ?? '',
        List<String>.from(map['votersList']));
  }

  @override
  String toString() {
    return 'CandidateModel(candidateId: $candidateId, name: $name, isVoted: $isVoted, age: $age, partyName: $partyName, electionId: $electionId)';
  }
}
