import 'dart:convert';
import 'dart:io';
import 'package:esol/redux/actions/cash_wallet_actions.dart';
import 'package:esol/redux/actions/user_actions.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:native_screenshot/native_screenshot.dart';
import 'package:esol/models/app_state.dart';
import 'dart:core';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

class VeifyFaceDetect extends StatefulWidget {
  @override
  _VeifyFaceDetectState createState() => _VeifyFaceDetectState();
}

class _VeifyFaceDetectState extends State<VeifyFaceDetect> {
  String detectString = 'No Face Found';
  String verifiedString = 'Data';

  CameraLensDirection cameraLensDirection = CameraLensDirection.front;
  FaceDetector detector =
      FirebaseVision.instance.faceDetector(FaceDetectorOptions(
    enableClassification: true,
    enableTracking: true,
    enableLandmarks: true,
    mode: FaceDetectorMode.accurate,
  ));

  Future<void> uploadData(
    _VeifyFaceModel viewModel,
    String base64Image,
    String imgPath,
  ) async {
    File deleteVar = File(imgPath);
    try {
      if (mounted) {
        setState(() {
          detectString = 'Verifying Face';
        });
      }
      final url = 'https://dot.innovatrics.com/core/api/v6/face/detect';
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'image': {
              "data": base64Image,
              "faceSizeRatio": {
                "min": 0.01,
                "max": 0.9,
              }
            },
            'template': true,
            'cropImage': true,
            'faceAttributes': true,
            'facialFeatures': true,
            'icaoAttributes': true,
          },
        ),
      );
      Map<String, dynamic> data = responseHandler(response);
      if (data.containsKey('errorCode')) {
        if (mounted) {
          setState(() {
            detectString = 'No Face Found';
          });
        }
        deleteVar.delete();
        print('errorCode - ${data['errorCode']}');
      } else {
        print('response ${response.body.toString()}');
        if (this.mounted) {
          setState(() {
            verifiedString = 'Face is Verified';
          });
        }
        viewModel.setFaceVerified();
        deleteVar.delete();
        Future.delayed(Duration(seconds: 5), () {
          if (verifiedString == 'Face is Verified') {
            Navigator.of(context).pop();
          }
        });
      }
    } catch (e) {
      deleteVar.delete();
      print('Error in uploadData verify-face ${e.toString()}');
    }
  }

  _takeScreenShot(_VeifyFaceModel viewModel) async {
    final dataValue = await NativeScreenshot.takeScreenshot();
    if (dataValue != null) {
      String base64Image = base64Encode(File(dataValue).readAsBytesSync());
      if (verifiedString != 'Face is Verified') {
        uploadData(viewModel, base64Image, dataValue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _VeifyFaceModel>(
        distinct: true,
        onInitialBuild: (viewModel) {
          Segment.screen(screenName: '/verify-face-screen');
        },
        converter: _VeifyFaceModel.fromStore,
        builder: (_, viewModel) {
          return Scaffold(
            backgroundColor: Color.fromRGBO(0, 85, 255, 1),
            appBar: AppBar(
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            body: Stack(children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: (verifiedString == "Data")
                      ? Text(detectString,
                          style: TextStyle(color: Colors.white, fontSize: 30))
                      : Icon(
                          Icons.verified,
                          color: Colors.green,
                          size: 80,
                        )),
              Center(
                child: Container(
                  height: 300,
                  width: 300,
                  child: ClipOval(
                    child: CameraMlVision<List<Face>>(
                      cameraLensDirection: cameraLensDirection,
                      detector: (FirebaseVisionImage image) {
                        return detector.processImage(image);
                      },
                      // overlayBuilder: (c) {
                      //   return Text('Data is Verified');
                      // },
                      onResult: (faces) {
                        if (faces == null || faces.isEmpty || !mounted) {
                          return;
                        }
                        if (!mounted) return;
                        if (faces[0].rightEyeOpenProbability <= 0.5 &&
                            faces[0].leftEyeOpenProbability <= 0.5) {
                          if (this.mounted) {
                            setState(() {
                              detectString = 'Open your Eyes';
                            });
                          }
                        }
                        if (faces[0].rightEyeOpenProbability >= 0.9 &&
                            faces[0].leftEyeOpenProbability >= 0.9 &&
                            faces[0].boundingBox.isEmpty == false) {
                          if (this.mounted) {
                            setState(() {
                              detectString = 'Face detected';
                            });
                          }
                          _takeScreenShot(viewModel);
                        }
                      },
                      onDispose: () {
                        detector.close();
                      },
                    ),
                  ),
                ),
              ),
            ]),
          );
        });
  }
}

class _VeifyFaceModel extends Equatable {
  final bool isFaceVerified;
  final Function setFaceVerified;

  _VeifyFaceModel({
    this.isFaceVerified,
    this.setFaceVerified,
  });

  static _VeifyFaceModel fromStore(Store<AppState> store) {
    return _VeifyFaceModel(
      isFaceVerified: store.state.userState?.isFaceVerified ?? false,
      setFaceVerified: () {
        store.dispatch(SetIsFaceVerified(isFaceVerified: true));
      },
    );
  }

  @override
  List<Object> get props => [
        isFaceVerified,
      ];
}
