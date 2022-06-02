import 'package:finger_voting/models/candidate.dart';
import 'package:finger_voting/providers/candidateProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CandidateItem extends StatelessWidget {
  final CandidateModel candidateModel;
  final String electionId;
  const CandidateItem(
      {Key? key, required this.candidateModel, required this.electionId})
      : super(key: key);

  popDialogBox(BuildContext context, CandidateModel candidateModel) async {
    await showDialog(
      context: context,
      builder: (ctx) => Dialog(
          child: GestureDetector(
              onTap: () {
                // Provider.of<CandidateProvider>(context, listen: false)
                //     .voteForCandidate(candidateModel);
                Navigator.pop(ctx);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.how_to_vote_rounded,
                      size: 56,
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    Text('You have voted for ${candidateModel.name}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 12),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)))
                  ],
                ),
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(
        'name : ${candidateModel.name} : isVoted : ${candidateModel.isVoted} someonelse: ${candidateModel.isVotedSomeoneElse} ');
    return Consumer<CandidateProvider>(builder: (context, value, child) {
      var currentvoting = value.getCurrentVotingCandidate;
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              tileColor: candidateModel.isVoted
                  ? Colors.blue[100]
                  : candidateModel.isVotedSomeoneElse
                      ? Colors.grey[300]
                      : Colors.orange[100],
              leading: const Icon(Icons.person),
              title: Text(candidateModel.name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: candidateModel.isVoted
                          ? Colors.blue[700]
                          : candidateModel.isVotedSomeoneElse
                              ? Colors.grey
                              : Colors.orange[700])),
              trailing: (currentvoting != null &&
                      currentvoting == candidateModel.candidateId)
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: Center(child: CircularProgressIndicator()))
                  : ElevatedButton(
                      child: Text(candidateModel.isVoted ? 'voted' : 'Vote'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              (candidateModel.isVoted ||
                                      candidateModel.isVotedSomeoneElse)
                                  ? Colors.grey
                                  : Colors.orange)),
                      onPressed: () async {
                        if (!candidateModel.isVoted &&
                            !candidateModel.isVotedSomeoneElse) {
                          // return;
                          var isVoted = await Provider.of<CandidateProvider>(
                                  context,
                                  listen: false)
                              .voteForCandidate(candidateModel, electionId);
                          if (isVoted) {
                            popDialogBox(context, candidateModel);
                          }
                        }
                      },
                    )));
    });
  }
}
