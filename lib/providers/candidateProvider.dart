import 'package:finger_voting/core/dummy_data.dart';
import 'package:finger_voting/models/candidate.dart';
import 'package:finger_voting/repositories/auth_repo.dart';
import 'package:flutter/cupertino.dart';

class CandidateProvider extends ChangeNotifier {
  List<CandidateModel> _listOfCandidates = DummySupply.candidateList;
  final AuthRepository _authRepository = AuthRepository();

  List<CandidateModel> getListOfCandidates() {
    return _listOfCandidates;
  }

  Future<bool> voteForCandidate(CandidateModel candidateModel) async {
    var isFingerAuthenticated =
        await _authRepository.authenticateWithBiometric();
    if (isFingerAuthenticated.left) {
      updateVoteStatus(candidateModel);
      return true;
    }
    return false;
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
