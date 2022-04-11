import 'package:finger_voting/models/candidate.dart';
import 'package:finger_voting/models/electionMode.dart';

class DummySupply {
  static final List<ElectionModel> electionList = [
    ElectionModel(electionId: 'sldfjks', name: 'President of Cesta'),
    ElectionModel(electionId: 'sldfjksdfs', name: 'Vice President of Cesta'),
    ElectionModel(electionId: 'ssagldfjks', name: 'President of college'),
    ElectionModel(electionId: 'sldfevgjks', name: 'Head of CS Department'),
  ];
  static final List<CandidateModel> candidateList = [
    CandidateModel(
      imageUrl: 'https://randomuser.me/api/portraits/men/56.jpg',
      candidateId: 'woesdggiurmn',
      name: 'Arvind kumar',
    ),
    CandidateModel(
        imageUrl: 'https://randomuser.me/api/portraits/men/68.jpg',
        candidateId: 'woeiurman',
        name: 'Prateek Tiwari'),
    CandidateModel(
        imageUrl: 'https://randomuser.me/api/portraits/men/50.jpg',
        candidateId: 'woeaiurmn',
        name: 'DD'),
    CandidateModel(
        imageUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
        candidateId: 'waoeiurmn',
        name: 'Vinay Sehwag plus'),
  ];
}
