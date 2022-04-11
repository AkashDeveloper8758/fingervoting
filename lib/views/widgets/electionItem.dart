import 'package:finger_voting/models/electionMode.dart';
import 'package:finger_voting/views/candidateScreen.dart';
import 'package:flutter/material.dart';

class ElectionItem extends StatelessWidget {
  ElectionModel electionModel;
  int count;
  ElectionItem({Key? key, required this.electionModel, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle mystyle =
        const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) =>
                  CandidateScreen(electionName: this.electionModel.name)));
        },
        leading: Text(this.count.toString() + ' : ', style: mystyle),
        tileColor: Colors.orange[100],
        title: Text(this.electionModel.name, style: mystyle),
      ),
    );
  }
}
