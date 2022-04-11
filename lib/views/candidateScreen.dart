import 'package:finger_voting/core/dummy_data.dart';
import 'package:finger_voting/core/getit.dart';
import 'package:finger_voting/providers/candidateProvider.dart';
import 'package:finger_voting/views/widgets/candidateItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CandidateScreen extends StatefulWidget {
  String electionName;
  CandidateScreen({
    required this.electionName,
    Key? key,
  }) : super(key: key);

  @override
  State<CandidateScreen> createState() => _CandidateScreenState();
}

class _CandidateScreenState extends State<CandidateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.electionName)),
      body: ChangeNotifierProvider.value(
        value: getIt.get<CandidateProvider>(),
        builder: (context, child) {
          var candidateItems =
              context.watch<CandidateProvider>().getListOfCandidates();
          return Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    margin: const EdgeInsets.all(8),
                    padding: EdgeInsets.all(4),
                    color: Colors.orange[50],
                    child: const Text('Candidates',
                        style: TextStyle(fontSize: 18))),
                SizedBox(height: 16),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: candidateItems.length,
                    itemBuilder: (ctx, i) {
                      return CandidateItem(
                        candidateModel: candidateItems[i],
                      );
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
