import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';

class CashHeader extends StatelessWidget {
  CashHeader(
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260.0,
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        boxShadow: [
      BoxShadow(
        color: Colors.black.withAlpha(20),
        blurRadius: 30.0,
        spreadRadius: 0.0,
        offset: Offset(
          0.0,
          3.0,
        ),
      )
    ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColorDark,
            ],
          ),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisSize: MainAxisSize.max,
        //mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            onTap: () {
           Scaffold.of(context).openDrawer();
         },
            child: Image.asset('assets/images/menu.png', width: 18,)),
           
          Expanded(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 0.0),
              child: new RichText(
                text: new TextSpan(
                  style: Theme.of(context).textTheme.title,
                  children: <TextSpan>[
                    new TextSpan(
                        text: I18n.of(context).hi,
                        style: TextStyle(
                            fontSize: 42,
                            color: Colors.black,
                            fontWeight: FontWeight.w300)),
                    new TextSpan(
                        text: ' ' + "Mark", //viewModel.user.firstName,
                        style: TextStyle(
                            fontSize: 42,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          )),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(bottom: 0.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                verticalDirection: VerticalDirection.up,
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        child: Text(I18n.of(context).balance,
                            style:
                                TextStyle(color: Colors.black.withAlpha(150), fontSize: 14.0)),
                        padding: EdgeInsets.only(bottom: 6.0),
                      ),
                      new RichText(
                          text: new TextSpan(
                            style: Theme.of(context).textTheme.title,
                            children: <TextSpan>[
                              new TextSpan(
                                  text: 
                                      "\$", //viewModel.token?.symbol.toString(),
                                  style: new TextStyle(
                                      fontSize: 42,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      height: 0.0)),
                              new TextSpan(
                                  text: "525" //viewModel.balance
                                      .toString(),
                                  style: new TextStyle(
                                      fontSize: 42,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              
                            ],
                          ),
                        )
                    ],
                  ),
                  new Container(
                    child: new FloatingActionButton(
                        backgroundColor: const Color(0xFF292929),
                        elevation: 0,
                        child: Image.asset(
                          'assets/images/scan.png',
                          width: 25.0,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          Navigator.pushNamed(context, '/SendContact');
                        }),
                    width: 50.0,
                    height: 50.0,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
