import 'dart:convert';

class CandidateModel {
  String candidateId;
  String name;
  String imageUrl;
  bool isVoted;
  CandidateModel({
    required this.candidateId,
    required this.name,
    required this.imageUrl,
    this.isVoted = false,
  });

  factory CandidateModel.fromMap(Map<String, dynamic> map) {
    return CandidateModel(
      candidateId: map['candidateId'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      isVoted: map['isVoted'],
    );
  }

  @override
  String toString() => 'CandidateModel(candidateId: $candidateId, name: $name)';
}
