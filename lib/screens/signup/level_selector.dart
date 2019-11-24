import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/widgets/main_scaffold.dart';

class LevelSelectorScreen extends StatefulWidget {
  @override
  _LevelSelectorScreenState createState() => _LevelSelectorScreenState();
}

class _LevelSelectorScreenState extends State<LevelSelectorScreen> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(title: "Choose what's best describes you", children: <Widget>[
      new StoreConnector<AppState, SignInViewModel>(converter: (store) {
              return null;
            }, 
            builder: (_, viewModel) {
              return Padding(
                padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                child: 
                Column(
          children: <Widget>[
            Container(height: 100, color: Colors.red,)
            ,
            Text("Choose what's best describes you",
              softWrap: true,
              //overflow: TextOverflow.visible,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.body1.color,
                      fontSize: 40,
                      fontWeight: FontWeight.w800))
          ],
        ),
              );
            })
          ]);
        }
      }
      
      class SignInViewModel {
}

