import 'dart:math';
import 'dart:ui';

import 'package:flare_flutter/flare.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/animation.dart';

typedef void OnUpdated();

class HouseController extends FlareController {
  static const double DemoMixSpeed = 10;
  static const double FPS = 60;

  final OnUpdated demoUpdated;

  HouseController({this.demoUpdated});

  bool isDemoMode = true;
  double _rooms = 0;
  double _lastDemoValue = 0.0;
  FlutterActorArtboard _artboard;
  FlareAnimationLayer _demoAnimation;
  FlareAnimationLayer _skyAnimation;

  final List<FlareAnimationLayer> _roomAnimations = [];

  ActorAnimation _arrange;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {

    return true;
  }

  /// Grab the references to the right animations, and
  /// packs them into [FlareAnimationLayer] objects
  @override
  void initialize(FlutterActorArtboard artboard) {

    _arrange = artboard.getAnimation("Animations");


    _artboard = artboard;
    _demoAnimation = FlareAnimationLayer()
      ..animation = _artboard.getAnimation("Animations");

    /*
    
    _skyAnimation = FlareAnimationLayer()
      ..animation = _artboard.getAnimation("Sun Rotate")
      ..mix = 1.0;
    ActorAnimation endAnimation = artboard.getAnimation("to 6");
    if (endAnimation != null) {
      endAnimation.apply(endAnimation.duration, artboard, 1.0);
    }
    */
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}
/*
  /// Use the [demoUpdated] callback to relay the current number of rooms
  /// to the [Page] widget, so it can position the slider accordingly. 
  _checkRoom() {
    double demoFrame = _demoAnimation.time * FPS;
    double demoValue = 0.0;
    if (demoFrame <= 15) {
      demoValue =
          lerpDouble(6.0, 5.0, Curves.easeInOut.transform(demoFrame / 15));
    } else if (demoFrame <= 36) {
      demoValue = 5.0;
    } else if (demoFrame <= 50) {
      demoValue = lerpDouble(
          5.0, 4.0, Curves.easeInOut.transform((demoFrame - 36) / (50 - 36)));
    } else if (demoFrame <= 72) {
      demoValue = 4.0;
    } else if (demoFrame <= 87) {
      demoValue = lerpDouble(
          4.0, 3.0, Curves.easeInOut.transform((demoFrame - 72) / (87 - 72)));
    } else if (demoFrame <= 128) {
      demoValue = 3.0;
    } else if (demoFrame <= 142) {
      demoValue = lerpDouble(3.0, 6.0,
          Curves.easeInOut.transform((demoFrame - 128) / (142 - 128)));
    } else if (demoFrame <= 164) {
      demoValue = 6.0;
    }

    if (_lastDemoValue != demoValue) {
      _lastDemoValue = demoValue;
      this._rooms = demoValue.toInt();
      /// Use the callback to let the [Page] widget know that the current value
      /// has been changed so that the Slider can be updated.
      if (demoUpdated != null) {
        demoUpdated();
      }
    }
    
  }
*/

/*
  _enqueueAnimation(String name) {
    ActorAnimation animation = _artboard.getAnimation(name);
    if (animation != null) {
      _roomAnimations.add(FlareAnimationLayer()..animation = animation);
    }
  }
*/

  set rooms(double value) {
    _arrange.apply(value, _artboard, 1);
  }

  double get rooms => _rooms;
}