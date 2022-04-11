import 'package:finger_voting/providers/authProvider.dart';
import 'package:finger_voting/providers/candidateProvider.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future setup() async {
  getIt.registerSingleton<AuthProvider>(AuthProvider());
  getIt.registerSingleton<CandidateProvider>(CandidateProvider());
}
