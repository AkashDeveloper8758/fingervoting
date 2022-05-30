import 'package:finger_voting/models/electionMode.dart';
import 'package:finger_voting/views/widgets/candidateScreen.dart';
import 'package:flutter/material.dart';

class ElectionItem extends StatelessWidget {
  final ElectionModel electionModel;
  final int count;
  const ElectionItem(
      {Key? key, required this.electionModel, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle mystyle =
        const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => CandidateScreen(electionModel: electionModel)));
        },
        leading: Text(count.toString() + ' : ', style: mystyle),
        tileColor: Colors.orange[100],
        title: Text(electionModel.name, style: mystyle),
      ),
    );
  }
}
