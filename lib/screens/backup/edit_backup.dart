import 'package:auto_route/auto_route.dart';
import 'package:esol/screens/home/home_page.dart';
import 'package:esol/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class MainMneomic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: InkWell(
          child: Image.asset('assets/images/Group 2309.png'),
          onTap: () {
            ExtendedNavigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Respaldar con frases',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Text(
                  'mneomónicas',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 8,
          ),
          Center(
            child: Text(
              'Escriba en orden las palabras mneomónicas',
              // textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 35,
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 8),
              child: EditMneomic(
                number: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 8),
              child: EditMneomic(
                number: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 8),
              child: EditMneomic(
                number: 3,
              ),
            ),
          ]),
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 8),
              child: EditMneomic(
                number: 4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 8),
              child: EditMneomic(
                number: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 8),
              child: EditMneomic(
                number: 6,
              ),
            ),
          ]),
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 8),
              child: EditMneomic(
                number: 7,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 8),
              child: EditMneomic(
                number: 8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 8),
              child: EditMneomic(
                number: 9,
              ),
            ),
          ]),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 8),
                child: EditMneomic(
                  number: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 8),
                child: EditMneomic(
                  number: 11,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 8),
                child: EditMneomic(
                  number: 12,
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: PrimaryButton(
                label: 'Hecho',
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ),
          )
          // EditMneomic()
        ],
      ),
    );
  }
}

// class EditMneomic extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Mneomic'),
//       ),
//       body: Container(
//         child: Stack(
//           children: [
//             Positioned(
//               top: 0,
//               child: Container(
//                   color: Colors.red,

//                   child: Image.asset('assets/images/contentImage.png')),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// bool isEmpty = false;

// class EditMneomic extends StatefulWidget {
//   @override
//   _EditMneomicState createState() => _EditMneomicState();
// }

// class _EditMneomicState extends State<EditMneomic> {
//   FocusNode _focusNode;
//   TextEditingController controller;
//   final _formKey = GlobalKey<FormState>();
//   Function _function(String controller){
// print(object)
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _focusNode.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     // if (_formKey.currentState.validate() == null)
//     _focusNode = new FocusNode();
//     _focusNode.addListener(_onOnFocusNodeEvent);
//   }

//   _onOnFocusNodeEvent() {
//     setState(() {
//       // Re-renders
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('Changing Colors'),
//       ),
//       body: new Container(
// //         height: 50,
// //         width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(
//               Radius.circular(20),
//             ),
//             color: _getContainerBackgroundColor(),
//           ),
//           // padding: new EdgeInsets.all(40.0),
//           child: Form(
//             key: _formKey,
//             autovalidate: true,
//             child: new TextFormField(
//               controller: _controller,
//               // onEditingComplete: () {
//               //   print('true');
//               // },

//               // autovalidate: true,
//               // validator: (value) {
//               //   // if(value.isEmpty){}
//               //   if (value.isEmpty) {
//               //     isEmpty = true;
//               //     return 'Please enter some text';
//               //   }
//               //   return null;
//               //   // if (_controller.text == "") {
//               //   //   _getContainerBackgroundColor();
//               //   // } else {
//               //   //   return null;
//               //   // }
//               // },
//               decoration: InputDecoration(
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Color.fromRGBO(255, 255, 255, 1),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(10.0),
//                       ),
//                     ),
//                     child: Text(
//                       '1',
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   // gapPadding: 10,
//                   borderSide: BorderSide(
//                     color: Colors.white,
//                   ),
//                 ),
//                 filled: true,
//                 // focusedBorder: OutlineInputBorder(
//                 //     borderSide: BorderSide(color: Colors.red),
//                 //     borderRadius: BorderRadius.circular(20)),
//                 // border: OutlineInputBorder(
//                 //   borderRadius: const BorderRadius.all(
//                 //     const Radius.circular(25.0),
//                 //   ),
//                 // ),
//               ),
//               // style: new TextStyle(color: _getInputTextColor()),
//               focusNode: _focusNode,
//             ),
//           )),
//     );
//   }

//   Color _getContainerBackgroundColor() {
//     // return (isEmpty == true) ? Colors.white  : Colors.orange;
//     return _focusNode.hasFocus
//         ? (isEmpty) ? Color.fromRGBO(233, 238, 249, 1) : Colors.red
//         : Color.fromRGBO(0, 85, 255, 1);
//   }

// //   Color _getAppBarBackgroundColor() {
// //     return _focusNode.hasFocus ? Colors.green : Colors.red;
// //   }

//   Color _getInputTextColor() {
//     return _focusNode.hasFocus ? Colors.white : Colors.pink;
//   }
// }

class EditMneomic extends StatefulWidget {
  final int number;
  EditMneomic({@required this.number});
  @override
  _EditMneomicState createState() => _EditMneomicState();
}

class _EditMneomicState extends State<EditMneomic> {
  FocusNode _focusNode;
  TextEditingController _controller;
  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
  }

  // Use this flag in your _getContainerBackgroundColor or directly in your build method
  bool textFieldIsEmpty = true;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = new FocusNode();
    _focusNode.addListener(_onOnFocusNodeEvent);
    super.initState();
  }

  bool emptystate = true;
  bool focusstate = false;
  bool contentstate = false;
  String image = 'assets/images/image_empty_content.png';
  Color color = Colors.white;
  // Color color1 = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Stack(
        children: [
          Container(
            child: Image.asset(image.toString()),
            // color: Colors.red,
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Center(
                child: new Text(
                  "${widget.number}",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          //Get the way to get the content is Empty or not.
          Positioned(
            top: 3,
            left: 45,
            child: Container(
              width: 60,
              child: TextFormField(
                controller: _controller,
                onFieldSubmitted: (value) {
                  setState(() {
                    if (_controller.text.toString().isEmpty) {
                      emptystate = true;
                      contentstate = false;
                      focusstate = false;
                      image = 'assets/images/image_empty_content.png';
                      color = Colors.white;
                    } else {
                      contentstate = true;
                      emptystate = false;
                      focusstate = false;
                      image = 'assets/images/contentImage.png';
                      color = Colors.white;
                    }
                  });
                },
                onChanged: (value) {
                  if ((_controller.text.toString().isNotEmpty)) {
                    setState(() {
                      focusstate = true;
                      contentstate = false;
                      emptystate = false;
                      color = Colors.blue;
                      image = 'assets/images/image_focus.png';
                    });
                  }
                  if (_controller.text.toString().isEmpty) {
                    setState(() {
                      emptystate = true;
                      contentstate = false;
                      focusstate = false;
                      color = Colors.white;
                      image = 'assets/images/image_empty_content.png';
                    });
                  }
                },
                style: TextStyle(color: color),
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
          )
        ],
      ),
    );
  }
}
