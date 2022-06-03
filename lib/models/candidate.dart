class CandidateModel {
  String candidateId;
  String name;
  bool isVoted = false;
  int age;
  String partyName;
  String electionId;
  List<String> votersList;
  bool isVotedSomeoneElse = false;

  CandidateModel(
      {required this.candidateId,
      required this.name,
      required this.isVoted,
      required this.age,
      required this.partyName,
      required this.electionId,
      required this.votersList,
      required this.isVotedSomeoneElse});

  factory CandidateModel.fromMap(Map<String, dynamic> map) {
    return CandidateModel(
        candidateId: map['candidateId'] ?? '',
        name: map['name'] ?? '',
        isVoted: false,
        age: map['age']?.toInt() ?? 0,
        partyName: map['partyName'] ?? '',
        electionId: map['electionId'] ?? '',
        votersList: List<String>.from(map['votersList']),
        isVotedSomeoneElse: false);
  }

  @override
  String toString() {
    return 'CandidateModel(candidateId: $candidateId, name: $name, isVoted: $isVoted, age: $age, partyName: $partyName, electionId: $electionId)';
  }
}
