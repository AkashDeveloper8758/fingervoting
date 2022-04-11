import 'package:finger_voting/core/dummy_data.dart';
import 'package:finger_voting/models/candidate.dart';
import 'package:flutter/cupertino.dart';

class CandidateProvider extends ChangeNotifier {
  List<CandidateModel> _listOfCandidates = DummySupply.candidateList;

  List<CandidateModel> getListOfCandidates() {
    return _listOfCandidates;
  }

  updateVoteStatus(CandidateModel candidate) {
    _listOfCandidates.forEach((element) {
      element.isVoted = false;
    });
    _listOfCandidates
        .firstWhere((element) => element.candidateId == candidate.candidateId)
        .isVoted = true;
    notifyListeners();
  }
}
