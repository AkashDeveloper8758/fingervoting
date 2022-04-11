import 'package:finger_voting/core/dummy_data.dart';
import 'package:finger_voting/views/widgets/electionItem.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Finger voting')),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                margin: const EdgeInsets.all(8),
                padding: EdgeInsets.all(4),
                color: Colors.orange[50],
                child: const Text('Running elections',
                    style: TextStyle(fontSize: 18))),
            SizedBox(height: 16),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: DummySupply.electionList.length,
                itemBuilder: (ctx, i) {
                  return ElectionItem(
                      count: i + 1, electionModel: DummySupply.electionList[i]);
                }),
          ],
        ),
      ),
    );
  }
}
