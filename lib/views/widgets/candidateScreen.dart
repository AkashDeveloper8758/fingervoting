import 'package:finger_voting/core/getit.dart';
import 'package:finger_voting/models/candidate.dart';
import 'package:finger_voting/models/electionMode.dart';
import 'package:finger_voting/providers/candidateProvider.dart';
import 'package:finger_voting/views/widgets/candidateItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CandidateScreen extends StatefulWidget {
  ElectionModel electionModel;
  CandidateScreen({
    required this.electionModel,
    Key? key,
  }) : super(key: key);

  @override
  State<CandidateScreen> createState() => _CandidateScreenState();
}

class _CandidateScreenState extends State<CandidateScreen> {
  late CandidateProvider candidateProvider;
  late Future<List<CandidateModel>> _candidateFuture;

  @override
  void initState() {
    candidateProvider = getIt.get<CandidateProvider>();
    _candidateFuture = candidateProvider
        .fetchCandidatesByElectionId(widget.electionModel.electionId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var electionId = widget.electionModel.electionId;
    return Scaffold(
        appBar: AppBar(title: Text(widget.electionModel.name)),
        body: FutureBuilder(
            future: _candidateFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SizedBox(
                      height: 16,
                      width: 16,
                      child: Center(child: CircularProgressIndicator())),
                );
              }
              return ChangeNotifierProvider.value(
                  value: candidateProvider,
                  builder: (context, _) {
                    var candidateItems =
                        candidateProvider.getCandidates(electionId);
                    return candidateItems.isNotEmpty
                        ? Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.all(4),
                                    color: Colors.orange[50],
                                    child: const Text('Candidates',
                                        style: TextStyle(fontSize: 18))),
                                const SizedBox(height: 16),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: candidateItems.length,
                                    itemBuilder: (ctx, i) {
                                      return CandidateItem(
                                        candidateModel: candidateItems[i],
                                        electionId: electionId,
                                      );
                                    }),
                              ],
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(12),
                            child: const Text(
                              'no candidates opted for this election',
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                  });
            }));
  }
}
