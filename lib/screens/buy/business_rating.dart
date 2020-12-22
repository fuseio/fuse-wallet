import 'package:esol/generated/i18n.dart';
import 'package:esol/screens/buy/business_details.dart';
import 'package:esol/widgets/header.dart';
import 'package:esol/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';

class BusinessRating extends StatefulWidget {
  @override
  _BusinessRatingState createState() => _BusinessRatingState();
}

class _BusinessRatingState extends State<BusinessRating> {
  @override
  Widget build(BuildContext context) {
    double rating = 3.5;
    return MainScaffold(
        drawerIcon: Padding(
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: Image.asset(
            'assets/images/menu_white.png',
          ),
        ),
        expandedHeight: MediaQuery.of(context).size.height * 0.29,
        newHeaderAppBar: Header(
          image: null,
          imageshow: false,
          contactEmpty: true,
          textshow: true,
        ),
        // TODO - added map with all business
        // actions: <Widget>[
        //   IconButton(
        //     icon: InkWell(
        //         onTap: () {
        //           Navigator.pushNamed(context, '/Map');
        //         },
        //         child: Padding(
        //             padding: EdgeInsets.all(0),
        //             child: Image.asset(
        //               'assets/images/pin_drop.png',
        //               width: 30,
        //               height: 30,
        //             ))),
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/Map');
        //     },
        //   ),
        // ],
        automaticallyImplyLeading: false,
        title: Text(I18n.of(context).buy),
        children: <Widget>[
          BusinessStarDetatils(rating: rating),
          BusinessStarDetatils(rating: rating),
          BusinessStarDetatils(rating: rating),
          BusinessStarDetatils(rating: rating),
          BusinessStarDetatils(rating: rating),
        ]);
  }
}

class BusinessStarDetatils extends StatelessWidget {
  const BusinessStarDetatils({
    Key key,
    @required this.rating,
  }) : super(key: key);

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 10),
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              // border: Border(
              //   bottom: BorderSide(
              //     color: Color(0xFFE8E8E8),
              //   ),
              // ),
              ),
          child: ListTile(
            contentPadding:
                EdgeInsets.only(top: 5, bottom: 5, left: 16, right: 16),
            leading: Container(
              height: 50,
              width: 50,
              // child: Image.asset('assets\images\gift.png'),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: DecorationImage(
                  image: AssetImage('assets/images/anom.png') ??
                      AssetImage('assets/images/anom.png'),
                  fit: BoxFit.contain,
                ),
                // border: Border.all(
                //     // color: Colors.black,
                //     // width: 8,
                //     ),
                borderRadius: BorderRadius.circular(17),
              ),
            ),
            // CircleAvatar(
            //   backgroundColor: Color(0xFFE0E0E0),
            //   radius: 25,
            //   backgroundImage: image ?? AssetImage('assets/images/anom.png'),
            // ),
            title: Text(
              'Business Name',
              style: TextStyle(
                  fontSize: 15, color: Theme.of(context).primaryColor),
            ),
            // trailing: trailing,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BusinessDetails()),
              );
            },
            subtitle: StarRating(
                rating: rating, onRatingChanged: (rating) => rating = rating),
          ),
        ),
      ),
    );
  }
}

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  StarRating(
      {this.starCount = 5, this.rating = .0, this.onRatingChanged, this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        color: Theme.of(context).buttonColor,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).buttonColor,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: color ?? Theme.of(context).buttonColor,
      );
    }
    return new InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        children:
            new List.generate(starCount, (index) => buildStar(context, index)));
  }
}
