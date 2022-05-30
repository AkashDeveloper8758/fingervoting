import 'package:finger_voting/core/dummy_data.dart';
import 'package:finger_voting/core/getit.dart';
import 'package:finger_voting/models/electionMode.dart';
import 'package:finger_voting/providers/authProvider.dart';
import 'package:finger_voting/providers/candidateProvider.dart';
import 'package:finger_voting/views/login/loginScreen.dart';
import 'package:finger_voting/views/widgets/electionItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthProvider authProvider;
  late CandidateProvider candidateProvider;
  late Future<List<ElectionModel>> fetchElections;
  bool _isLoading = false;

  Future<List<ElectionModel>> fetchElectionFunction() async {
    return candidateProvider.getElections();
  }

  @override
  void initState() {
    super.initState();
    authProvider = getIt.get<AuthProvider>();
    candidateProvider = getIt.get<CandidateProvider>();

    fetchElections = fetchElectionFunction();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      // print('inside widget binding ');
      var value = await authProvider.authenticateOnly();
      if (!value.left) {
        authProvider.logout();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const LoginScreen()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finger voting'),
        actions: [
          IconButton(
              onPressed: () {
                authProvider.logout();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) => const LoginScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout)),
          IconButton(
              onPressed: () async {
                setState(() => _isLoading = true);
                await candidateProvider.refreshAllData();
                setState(() => _isLoading = false);
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: double.infinity,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(12),
                color: Colors.orange[50],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Running elections',
                        style: TextStyle(fontSize: 18)),
                    _isLoading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator())
                        : const SizedBox()
                  ],
                )),
            const SizedBox(height: 16),
            FutureBuilder<List<ElectionModel>>(
                future: fetchElections,
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                        height: 16,
                        width: 16,
                        child: Center(child: CircularProgressIndicator()));
                  }
                  var electionList = candidateProvider.getElectionsList;
                  if (electionList.isEmpty) {
                    return Container(
                        margin: const EdgeInsets.all(16),
                        child: const Text('no elections are there'));
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: electionList.length,
                      itemBuilder: (ctx, i) {
                        return ElectionItem(
                            count: i + 1, electionModel: electionList[i]);
                      });
                }),
          ],
        ),
      ),
    );
  }
}
