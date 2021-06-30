import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';

typedef void OnUpdated();

class HouseController extends FlareController {
  HouseController({
    required this.onUpdated,
  });

  final OnUpdated onUpdated;
  late ActorAnimation _arrange;
  late FlutterActorArtboard _artboard;
  double _time = 0;
  double _speed = 4;
  double _startFrom = 3;
  double _animationLength = 6;
  int step = 0;
  double step2 = 0.0;
  double _rooms = 0;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    double def = (_startFrom + _time) - (_startFrom + step2 * _animationLength);
    if (def > 0.5 || def < -0.5) {
      if ((_startFrom + _time).round() <
          _startFrom + step2 * _animationLength) {
        _time += elapsed * _speed;
        _arrange.apply(_startFrom + _time, artboard, 1);
      } else {
        _time -= elapsed * _speed;
        _arrange.apply(_startFrom + _time, artboard, 1);
      }
    }
    return true;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    _arrange = artboard.getAnimation("Animation")!;
    _artboard = artboard;
    _arrange.apply(_startFrom, _artboard, 1);
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}

  set rooms(double value) {
    step = value.round();
    step2 = value;
  }

  double get rooms => _rooms;
}
