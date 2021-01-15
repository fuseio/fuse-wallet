import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:peepl/constans/keys.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:peepl/redux/actions/cash_wallet_actions.dart';
import 'package:peepl/services.dart';
import 'package:peepl/utils/send.dart';
import 'package:peepl/widgets/main_scaffold.dart';
import 'package:peepl/widgets/primary_button.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';

class HelpScreen extends StatefulWidget {
  HelpScreen();
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen>
    with SingleTickerProviderStateMixin {
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Help',
      children: <Widget>[Container(
        margin: EdgeInsets.only(left: 15, top: 25, bottom: 0, right: 15),
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How do I pay?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              textAlign: TextAlign.left),
            Text('We keep fees low for your local restaurants by avoiding expensive credit card processors. Instead, you pay restaurants directly, from your Peepl wallet. Tap “Home”, then the menu icon, then “Top up” to add money to your wallet, straight from your bank account.'),
            SizedBox(height: 10),
            Text(
                'My bank doesn’t appear as an option during the top-up process.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Text('Most UK banks are supported. But if yoursThe quickest way to resolve issues with your order is by contacting the restaurant you ordered from, directly. Their phone number is included on the confirmation email we sent you when you ordered. If you don’t get anywhere with that, or you’ve lost your confirmation email, then contact us at help@itsaboutpeepl.com and we’ll do our best to put you in touch with the venue. isn’t, contact us at help@itsaboutpeepl.com and we’ll help you top up your wallet with a transfer via your bank’s app or website.'),
            SizedBox(height: 10),
            Text(
                'Where can I see my past orders?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Text('We don’t currently have a way to show past orders yet, but it’s coming! In the meantime, check ur email inbox for the confirmation message we sent after you first made your order – it will have come from help@itsaboutpeepl.com.'),
            SizedBox(height: 10),
            Text(
                "My order hasn't turned up",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Text("The quickest way to resolve issues with your order is by contacting the restaurant you ordered from, directly. Their phone number is included on the confirmation email we sent you when you ordered. If you don’t get anywhere with that, or you’ve lost your confirmation email, then contact us at help@itsaboutpeepl.com and we’ll do our best to put you in touch with the venue."),
            SizedBox(height: 10),
            Text(
                "Who are you?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Text('We’re a group of scousers with a vision for creating a fairer, more inclusive local economy. We want to stop money leaving the city region, going to banks and silicon valley monopolies, and instead reinvest that money into the businesses and people that make the Liverpool City Region so special. You can find out more at itsaboutpeepl.com.'),
            SizedBox(height: 10),
            Text(
                "What information do you store about me?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Text('When you provide your email address, phone number, and delivery address as part of your order, we store those details so that we can send them to the restaurant for delivery of your order. We also store your Peepl wallet ID, so that can match up your order with your payment. We don’t share any of that data with anyone else. And we don’t store any other data about you or your device. You can contact us at any time to ask for a copy of all data we hold about you, or to remove all data we hold about you. Just email help@itsaboutpeepl.com.'),
            SizedBox(height: 10),
            Text(
                "Can I list my own business on Peepl?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Text('We’re rolling out Peepl very carefully at the moment, and working with a small number of partners to make sure the experience is just right. But if you’re interested in joining our pilot, email help@itsaboutpeepl.com.'),
            SizedBox(height: 10),
            Text(
                "Something doesn't seem right, how can I send you feedback?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Text('Email us at help@itsaboutpeepl.com'),
            SizedBox(height: 10)
          ]
        )
    )
      )]
    );
  }
    }