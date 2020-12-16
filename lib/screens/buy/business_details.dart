import 'package:esol/screens/buy/business_rating.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BusinessDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 100,
              width: MediaQuery.of(context).size.width,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/city.png'),
                      fit: BoxFit.cover),
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                height: 197,
                width: MediaQuery.of(context).size.width,

                // width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 50,
                            width: 68,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(14.0),
                                bottomRight: Radius.circular(14.0),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Color.fromRGBO(23, 27, 36, 1),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Supermercado Candy',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: StarRating(
                    rating: 4.5, onRatingChanged: (rating) => rating = rating),
              ),
            ),
            Positioned(
              top: 150,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://image.shutterstock.com/image-photo/mountains-during-sunset-beautiful-natural-600w-407021107.jpg')),
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                ),
                height: 100,
                width: 100,
              ),
            ),
            Positioned(
              top: 100,
              left: 40,
              child: FittedBox(
                child: Container(
                  width: 100,
                  child: Flexible(
                    child: Text('Av Brasil 3416, Magdalena del Mar 15086, Perú',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 150,
              left: 50,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     fit: BoxFit.cover,
                  //     image: NetworkImage(
                  //         'https://image.shutterstock.com/image-photo/mountains-during-sunset-beautiful-natural-600w-407021107.jpg')),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Icon(Icons.call),
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              left: 50,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     fit: BoxFit.cover,
                  //     image: NetworkImage(
                  //         'https://image.shutterstock.com/image-photo/mountains-during-sunset-beautiful-natural-600w-407021107.jpg')),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    '!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 160,
              left: 120,
              child: Text(
                '+51 1 6366354',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              bottom: 90,
              left: 120,
              child: Text(
                'Mas detalles',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
