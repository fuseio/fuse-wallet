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
  // double _lastDemoValue = 0.0;
  FlutterActorArtboard _artboard;
  // FlareAnimationLayer _demoAnimation;
  // FlareAnimationLayer _skyAnimation;

  // final List<FlareAnimationLayer> _roomAnimations = [];

  ActorAnimation _arrange;

  double _time = 0;
  double _speed = 8;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    var def = (2 + _time) - (2 + step2 * 8);
    if (def > 0.5 || def < -0.5) {
      if (_time.round() < step2 * 8) {
        _time += elapsed * _speed;
        _arrange.apply(2 + _time, artboard, 0.5);
        // print(_time);
      } else {
        _time -= elapsed * _speed;
        _arrange.apply(2 + _time, artboard, 0.5);
        // print(-_time);
      }
    }

    return true;
  }

  /// Grab the references to the right animations, and
  /// packs them into [FlareAnimationLayer] objects
  @override
  void initialize(FlutterActorArtboard artboard) {
    _arrange = artboard.getAnimation("part1");

    _artboard = artboard;
    // _demoAnimation = FlareAnimationLayer()
      // ..animation = _artboard.getAnimation("part1");

    _arrange.apply(2, _artboard, 1);
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}

  // Timer _timer;
  var currentStep = 0.0;
  var frame = 0.0;
  var step = 0;
  var step2 = 0.0;

  set rooms(double value) {
    step = value.round();
    step2 = value;

    return;

    // var nextStep = (value % 8).round().toDouble();

    // if (_timer == null || !_timer.isActive) {
    //   _timer =
    //       new Timer.periodic(const Duration(microseconds: 400), (Timer timer) {
    //     if (nextStep >= currentStep) {
    //       frame += 0.003;
    //     } else {
    //       frame -= 0.003;
    //     }

    //     var s = 2 + frame;
    //     _arrange.apply(s, _artboard, 1);

    //     // print(s);

    //     if (nextStep >= currentStep) {
    //       if (s > 2 + (nextStep) * 8) {
    //         currentStep = nextStep;
    //         timer.cancel();
    //       }
    //     } else {
    //       if (s < 2 + (nextStep) * 8) {
    //         currentStep = nextStep;
    //         timer.cancel();
    //       }
    //     }
    //   });
    // }

    //var time = 2 + (value * 8).abs();
    //print(time);
    //_arrange.apply(time, _artboard, 1);
  }

  double get rooms => _rooms;
}
