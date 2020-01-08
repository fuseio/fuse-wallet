import 'dart:async';
import 'package:flare_flutter/flare.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';

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

  double _time = 0;
  double _speed = 4;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    if (2 + _time.round() != 2 + step * 8) {
      if (_time.round() < step * 8) {
        _time += elapsed * _speed;
        _arrange.apply(2 + _time, artboard, 1);
      } else {
        _time -= elapsed * _speed;
        _arrange.apply(2 + _time, artboard, 1);
      }

      print(step);
    }

    //FlareAnimationLayer layer = (FlareAnimationLayer()..animation = _arrange);
    //if (layer.time < 8) {

    //layer.time += 2;
    //layer.mix = min(1.0, layer.time / 0.07);
    //layer.apply(artboard);

    //}

    return true;
  }

  /// Grab the references to the right animations, and
  /// packs them into [FlareAnimationLayer] objects
  @override
  void initialize(FlutterActorArtboard artboard) {
    _arrange = artboard.getAnimation("part1");

    _artboard = artboard;
    _demoAnimation = FlareAnimationLayer()
      ..animation = _artboard.getAnimation("part1");

/*var t = 0.0;
    const oneSec = const Duration(seconds: 1);
  Timer.periodic(
    oneSec,
    (Timer timer) => () {
      t +=1;
      print(t);
      _arrange.apply(t, _artboard, 1);
      if (t > 10) {
        timer.cancel();
      }
    },
  );*/

    _arrange.apply(2, _artboard, 1);

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

  Timer _timer;
  var currentStep = 0.0;
  var frame = 0.0;
  var step = 0;

  set rooms(double value) {
    step = value.round();

    return;

    var nextStep = (value % 8).round().toDouble();

    print(nextStep);
    if (_timer == null || !_timer.isActive) {
      _timer =
          new Timer.periodic(const Duration(microseconds: 400), (Timer timer) {
        if (nextStep >= currentStep) {
          frame += 0.003;
        } else {
          frame -= 0.003;
        }

        var s = 2 + frame;
        _arrange.apply(s, _artboard, 1);

        print(s);

        if (nextStep >= currentStep) {
          if (s > 2 + (nextStep) * 8) {
            currentStep = nextStep;
            timer.cancel();
          }
        } else {
          if (s < 2 + (nextStep) * 8) {
            currentStep = nextStep;
            timer.cancel();
          }
        }
      });
    }

    //var time = 2 + (value * 8).abs();
    //print(time);
    //_arrange.apply(time, _artboard, 1);
  }

  double get rooms => _rooms;
}