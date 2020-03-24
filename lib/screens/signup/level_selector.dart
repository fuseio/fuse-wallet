import 'package:flutter/material.dart';
import 'package:localdollarmx/widgets/main_scaffold.dart';

class LevelSelectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        withPadding: true,
        title: "Select mode",
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, left: 30, right: 30),
            child: Column(
              children: <Widget>[
                Text("Choose what's best describes you",
                    softWrap: true,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.body1.color,
                        fontSize: 20,
                        fontWeight: FontWeight.w800)),
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      'New to Crypto',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
                  child: RaisedButton(
                    onPressed: null,
                    child: Text(
                      'Pro',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]);
  }
}
