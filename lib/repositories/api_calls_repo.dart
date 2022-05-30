import 'package:finger_voting/core/apiClient.dart';
import 'package:finger_voting/models/candidate.dart';
import 'package:finger_voting/models/electionMode.dart';
import 'package:finger_voting/models/user.dart';

class ApiRepository {
  final ApiClient _apiClient;
  ApiRepository(this._apiClient);

  Future<bool> verifyVoterIdAndPassword(String voterId, String password) async {
    try {
      var response =
          await _apiClient.get('verify?voterId=$voterId&password=$password');
      print('api response : $response');
      return response['isValid'];
    } catch (err) {
      print('error on apicall: $err');
      return false;
    }
  }

  Future<UserModel?> getVoterByVoterId(String voterId) async {
    try {
      var response = await _apiClient.get('voter/$voterId');
      return UserModel.fromMap(response);
    } catch (err) {
      return null;
    }
  }

  Future<List<CandidateModel>?> getCandidateByElectionId(
      String electionId) async {
    try {
      var response = await _apiClient.get('candidates/$electionId');
      response = response as List;
      return response.map((e) => CandidateModel.fromMap(e)).toList();
    } catch (err) {
      print('error : $err');
      return null;
    }
  }

  Future<List<ElectionModel>?> getElections() async {
    try {
      var response = await _apiClient.get('elections');
      response = response as List;
      var elections = response.map((e) => ElectionModel.fromMap(e)).toList();
      return elections;
    } catch (err) {
      return null;
    }
  }

  Future<bool> voteCandidate(String voterId, String candidateid) async {
    try {
      await _apiClient
          .get('voteCandidate?voterId=$voterId&candidateId=$candidateid');
      return true;
    } catch (err) {
      return false;
    }
  }
}
