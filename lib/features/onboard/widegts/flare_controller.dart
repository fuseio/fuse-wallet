import 'package:flare_flutter/flare.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare_controller.dart';

typedef void OnUpdated();

class HouseController extends FlareController {
  static const double DemoMixSpeed = 10;
  static const double FPS = 60;

  final OnUpdated demoUpdated;

  HouseController({this.demoUpdated});

  bool isDemoMode = true;
  double _rooms = 0;
  FlutterActorArtboard _artboard;

  ActorAnimation _arrange;

  double _time = 0;
  double _speed = 4;
  double _startFrom = 3;
  double _animationLength = 6;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {

    var def = (_startFrom + _time) - (_startFrom + step2 * _animationLength);
    if (def > 0.5 || def < -0.5) {
      if ((_startFrom + _time).round() < _startFrom + step2 * _animationLength) {
        _time += elapsed * _speed;
        _arrange.apply(_startFrom + _time, artboard, 1);
      } else {
        _time -= elapsed * _speed;
        _arrange.apply(_startFrom + _time, artboard, 1);
      }
    } else {
      //if (_time > 18) {
        //_arrange.apply(_startFrom + step2 * _animationLength, _artboard, 1);
      //}
    }

    return true;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    _arrange = artboard.getAnimation("Animation");
    _artboard = artboard;
    _arrange.apply(_startFrom, _artboard, 1);
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}

  var currentStep = 0.0;
  var frame = 0.0;
  var step = 0;
  var step2 = 0.0;

  set rooms(double value) {
    step = value.round();
    step2 = value;
  }

  double get rooms => _rooms;
}
