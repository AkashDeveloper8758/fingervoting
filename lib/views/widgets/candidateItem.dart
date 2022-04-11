import 'package:finger_voting/models/candidate.dart';
import 'package:finger_voting/providers/candidateProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CandidateItem extends StatelessWidget {
  CandidateModel candidateModel;
  CandidateItem({Key? key, required this.candidateModel}) : super(key: key);

  popDialogBox(BuildContext context, CandidateModel candidateModel) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
          child: GestureDetector(
              onTap: () {
                Provider.of<CandidateProvider>(context, listen: false)
                    .updateVoteStatus(candidateModel);
                Navigator.pop(ctx);
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.fingerprint,
                      size: 56,
                    ),
                    const SizedBox(height: 16),
                    Text('Scan your fingerprint for ${candidateModel.name}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ],
                ),
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          tileColor: Colors.orange[100],
          leading: CircleAvatar(
            backgroundImage: NetworkImage(candidateModel.imageUrl),
            radius: 28,
          ),
          trailing: ElevatedButton(
            child: Text('Vote'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    candidateModel.isVoted ? Colors.grey : Colors.orange)),
            onPressed: () {
              if (!candidateModel.isVoted)
                popDialogBox(context, candidateModel);
            },
          ),
          title: Text(candidateModel.name,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.orange[700])),
        ));
  }
}
