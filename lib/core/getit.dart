import 'package:finger_voting/core/apiClient.dart';
import 'package:finger_voting/providers/authProvider.dart';
import 'package:finger_voting/providers/candidateProvider.dart';
import 'package:finger_voting/repositories/api_calls_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getIt = GetIt.instance;

Future setup() async {
  getIt.registerSingleton<Client>(Client());
  getIt.registerSingleton<ApiClient>(ApiClient(getIt()));

  getIt.registerSingleton<ApiRepository>(ApiRepository(getIt()));

  getIt.registerSingleton<AuthProvider>(AuthProvider(getIt()));
  getIt.registerSingleton<CandidateProvider>(CandidateProvider(getIt()));
}
