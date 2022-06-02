import 'package:finger_voting/core/dummy_data.dart';
import 'package:finger_voting/models/candidate.dart';
import 'package:finger_voting/models/electionMode.dart';
import 'package:finger_voting/models/user.dart';
import 'package:finger_voting/repositories/api_calls_repo.dart';
import 'package:finger_voting/repositories/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class CandidateProvider extends ChangeNotifier {
  Map<String, List<CandidateModel>> _listOfCandidates = {};
  List<ElectionModel> _elections = [];

  final AuthRepository _authRepository = AuthRepository();
  String? _userId;

  final ApiRepository _apiRepository;
  String? _votingCandidateid;

  String? get getCurrentVotingCandidate => _votingCandidateid;
  List<ElectionModel> get getElectionsList => _elections;
  CandidateProvider(this._apiRepository);

  updateVoterId() async {
    if (_userId == null) {
      var preference = await SharedPreferences.getInstance();
      var userId = preference.getString(Constants.voterId);
      _userId = userId!;
    }
  }

  Future refreshAllData() async {
    clearData();
    await getElections(forced: true);
  }

  Future clearData() async {
    _elections = [];
    _listOfCandidates = {};
  }

  Future<List<CandidateModel>> fetchCandidatesByElectionId(
      String electionId) async {
    if (_listOfCandidates.containsKey(electionId) &&
        _listOfCandidates[electionId]!.isNotEmpty) {
      return _listOfCandidates[electionId] ?? [];
    }
    var candidates = await _apiRepository.getCandidateByElectionId(electionId);
    if (candidates != null) {
      for (var c in candidates) {
        if (c.votersList.contains(_userId)) {
          c.isVoted = true;
        }
      }
      _listOfCandidates[electionId] = candidates;
      return candidates;
    }
    return [];
  }

  List<CandidateModel> getCandidates(String electionId) {
    if (_listOfCandidates.containsKey(electionId)) {
      return _listOfCandidates[electionId]!;
    }
    return [];
  }

  Future<List<ElectionModel>> getElections({bool forced = false}) async {
    if (_elections.isNotEmpty & !forced) {
      return _elections;
    }
    var elections = await _apiRepository.getElections();
    await updateVoterId();
    if (elections != null) {
      _elections = elections;
    }
    return _elections;
  }

  Future<bool> voteForCandidate(
      CandidateModel candidateModel, String electionId) async {
    try {
      var isFingerAuthenticated =
          await _authRepository.authenticateWithBiometric();
      print('is fingerprint auth : ${isFingerAuthenticated.left}');
      if (isFingerAuthenticated.left) {
        _votingCandidateid = candidateModel.candidateId;
        notifyListeners();
        var isVoted = await _apiRepository.voteCandidate(
            _userId!, candidateModel.candidateId);
        _votingCandidateid = null;
        notifyListeners();
        print('isvoted : $isVoted');

        if (isVoted) {
          updateVoteStatus(candidateModel, electionId);
          return true;
        }
        return false;
      }
      return false;
    } catch (err) {
      print('error on voting : $err ');
      return false;
    }
  }

// fill function, update values in priovder and preference, does not return anything
  // Future getUserByVoterId(String voterId) async {
  //   var user = await _apiRepository.getVoterByVoterId(voterId);
  //   if (user != null) {
  //     _userId = user;
  //     var preference = await SharedPreferences.getInstance();
  //     await preference.setString(Constants.userName, user.name);
  //   }
  // }

  updateVoteStatus(CandidateModel candidate, String electionId) {
    // for (var element in _listOfCandidates[electionId]!) {
    //   element.isVoted = false;
    // }
    _listOfCandidates[electionId]!
        .firstWhere((element) => element.candidateId == candidate.candidateId)
        .isVoted = true;
    print('notifying voters : --------');
    notifyListeners();
  }
}
