import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
// import 'package:vibration/vibration.dart';

typedef IndexedHeight = double Function(int);

class AlphabetScrollListHeader {
  final List<Widget> widgetList;
  final Icon icon;
  final IndexedHeight indexedHeaderHeight;

  AlphabetScrollListHeader(
      {@required this.widgetList,
      @required this.icon,
      @required this.indexedHeaderHeight});
}

class _SpecialHeaderAlphabet {
  final String id;
  final Icon icon;

  _SpecialHeaderAlphabet(this.id, this.icon);
}

class AlphabetListScrollView extends StatefulWidget {
  final List<String> strList;
  final IndexedHeight indexedHeight;
  final IndexedWidgetBuilder itemBuilder;
  final TextStyle highlightTextStyle;
  final TextStyle normalTextStyle;
  final bool showPreview;
  final bool keyboardUsage;
  final List<AlphabetScrollListHeader> headerWidgetList;

  const AlphabetListScrollView(
      {Key key,
      @required this.strList,
      this.itemBuilder,
      this.highlightTextStyle = const TextStyle(color: Colors.red),
      this.normalTextStyle = const TextStyle(color: Colors.black),
      this.showPreview = false,
      this.headerWidgetList = const [],
      @required this.indexedHeight,
      this.keyboardUsage = false})
      : super(key: key);

  @override
  _AlphabetListScrollViewState createState() => _AlphabetListScrollViewState();
}

class _AlphabetListScrollViewState extends State<AlphabetListScrollView> {
  List<String> alphabetList = [];

  var controller = ScrollController();
  VoidCallback _callback;
  GlobalKey _screenKey = GlobalKey();
  GlobalKey _mainKey = GlobalKey();
  GlobalKey _sideKey = GlobalKey();
  double screenHeight = 0;
  double sideHeight = 0;
  int selectedIndex = 0;
  String selectedChar = "A";
  Map<String, int> strMap = {};
  Map<String, double> heightMap = {};
  int savedIndex = 0;
  bool isXFlag = false;
  Timer _debounce;
  bool _visible = false;
  final _pixelUpdates = StreamController<double>();
  var totalHeight = 0.0;
  var heightList = <double>[];
  double maxLimit = 0;
  List<_SpecialHeaderAlphabet> specialList = [];

  List<String> strList = [];

  // _initScrollCallback() {
  //   Observable(_pixelUpdates.stream).listen((pixels) {
  //     var childLength = strList.length;
  //     double maxScrollExtent = controller.position.maxScrollExtent > 0
  //         ? controller.position.maxScrollExtent
  //         : 1;
  //     var tempSelectedIndex =
  //         ((pixels / maxScrollExtent) * childLength).toInt();
  //     if (tempSelectedIndex >= childLength) {
  //       tempSelectedIndex = childLength - 1;
  //     }
  //     String mapKey;
  //     if (tempSelectedIndex < 0 || tempSelectedIndex >= strList.length) {
  //       return;
  //     }
  //     if (strList[tempSelectedIndex].contains(RegExp("^x\\d\$"))) {
  //       mapKey = (strList[tempSelectedIndex]);
  //     } else {
  //       mapKey = strList[tempSelectedIndex][0].toUpperCase();
  //     }

  //     if (tempSelectedIndex != selectedIndex && selectedChar != mapKey) {
  //       var tempIndex = alphabetList.indexOf(mapKey);

  //       if (tempIndex != -1) {
  //         setState(() {
  //           selectedIndex = tempIndex;
  //           selectedChar = mapKey;
  //         });
  //       }
  //     }
  //   });
  // }

  @override
  void initState() {
    _initList();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
    _updateStrList();
    // _initScrollCallback();
    _callback = () {
      _pixelUpdates.add(controller.position.pixels);
    };
    controller.addListener(_callback);
  }

  _updateStrList() {
    strList = [];
    for (var i = 0; i < widget.headerWidgetList.length; i++) {
      var header = widget.headerWidgetList[i];
      for (var j = 0; j < header.widgetList.length; j++) {
        strList.add("x$i");
      }
    }
    strList.addAll(widget.strList);
  }

  @override
  void didUpdateWidget(AlphabetListScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initList();
    _updateHeightMap();
    _updateStrList();
  }

  _updateHeightMap() {
    double maxLimit;
    if (totalHeight - screenHeight > 0) {
      maxLimit = totalHeight - screenHeight;
    } else {
      maxLimit = 0;
    }
    heightMap.forEach((k, v) {
      if (v > maxLimit) {
        heightMap[k] = maxLimit;
      }
    });
  }

  _afterLayout(_) {
    _getScreenHeight();
    _getSideSizes();
    _updateHeightMap();
  }

  _initList() {
    alphabetList = [];
    var tempList = widget.strList;
    tempList.sort();
    tempList.sort((a, b) {
      if (a.codeUnitAt(0) < 65 ||
          a.codeUnitAt(0) > 122 &&
              b.codeUnitAt(0) >= 65 &&
              b.codeUnitAt(0) <= 122) {
        return 1;
      } else if (b.codeUnitAt(0) < 65 ||
          b.codeUnitAt(0) > 122 &&
              a.codeUnitAt(0) >= 65 &&
              a.codeUnitAt(0) <= 122) {
        return -1;
      }
      return a.compareTo(b);
    });
    if (widget.headerWidgetList.length > 0) {
      totalHeight = 0;
      for (var i = 0; i < widget.headerWidgetList.length; i++) {
        var header = widget.headerWidgetList[i];
        var id = "x$i";
        alphabetList.add(id);
        heightMap[id] = totalHeight;
        specialList.add(_SpecialHeaderAlphabet(id, header.icon));
        double headerHeight = 0;
        for (var j = 0; j < header.widgetList.length; j++) {
          headerHeight += header.indexedHeaderHeight(j);
        }
        totalHeight += headerHeight;
      }
    }
    for (var i = 0; i < tempList.length; i++) {
      var currentStr = tempList[i][0];
      _initAlphabetMap(currentStr, i);
    }
  }

  String _currentAlphabet = "";

  _initAlphabetMap(String currentStr, int i) {
    var currentHeight = widget.indexedHeight(i);
    if (_currentAlphabet == "#") {
      return;
    }

    if (currentStr.codeUnitAt(0) < 65 || currentStr.codeUnitAt(0) > 122) {
      strMap["#"] = i;
      alphabetList.add("#");
      _currentAlphabet = "#";
      heightMap["#"] = totalHeight;
    } else if (_currentAlphabet != currentStr) {
      strMap[currentStr] = i;
      alphabetList.add(currentStr);
      _currentAlphabet = currentStr;
      heightMap[currentStr] = totalHeight;
    }
    totalHeight += currentHeight;
  }

  _getSideSizes() {
    final RenderBox renderBoxRed = _sideKey.currentContext.findRenderObject();
    final sizeRed = renderBoxRed.size;
    sideHeight = sizeRed.height;
  }

  _getScreenHeight() {
    final RenderBox renderBoxRed = _mainKey.currentContext.findRenderObject();
    final sizeRed = renderBoxRed.size;
    screenHeight = sizeRed.height;
  }

  _currentWidgetIndex(double position) {
    var tempPosition = position;
    if (position >= sideHeight) {
      tempPosition = sideHeight;
    } else if (position <= 1) {
      tempPosition = 0;
    }
    var tempHeight = tempPosition / sideHeight;
    var tempIndex = tempHeight * alphabetList.length;

    if (tempIndex >= alphabetList.length - 1) {
      tempIndex = (alphabetList.length - 1).toDouble();
    }

    setState(() {
      selectedIndex = tempIndex.round();
    });

    if (savedIndex != selectedIndex) {
      savedIndex = selectedIndex;
      // _select(selectedIndex);

      if (_debounce?.isActive ?? false) _debounce.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        setState(() {
          _visible = false;
        });
      });
      setState(() {
        _visible = true;
      });
    }
  }

//   _select(int index) async {
//     if (await Vibration.hasVibrator()) {
//       Vibration.vibrate(duration: 20);
//     }
//     var height = heightMap[alphabetList[index]];
//     controller.jumpTo(height);
// //    controller.scrollToIndex(
// //      strMap[alphabetList[index]],
// //      duration: Duration(milliseconds: 1),
// //    );
//   }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_callback);
  }

  List<SliverList> _headerWidgetList() {
    List<SliverList> sliverList = [];
    for (var i = 0; i < widget.headerWidgetList.length; i++) {
      var headerWidget = widget.headerWidgetList[i];
      List<Widget> widgetList = [];
      for (var j = 0; j < headerWidget.widgetList.length; j++) {
        widgetList.add(Container(
          height: headerWidget.indexedHeaderHeight(j),
          child: headerWidget.widgetList[j],
        ));
      }
      sliverList.add(SliverList(
        delegate: SliverChildListDelegate([
          ...widgetList,
        ]),
      ));
    }
    return sliverList;
  }

  @override
  Widget build(BuildContext context) {
    Widget textview;
    if (selectedIndex >= 0 && selectedIndex < alphabetList.length) {
      if (alphabetList[selectedIndex].length > 1) {
        var header = specialList
            .firstWhere((sp) => sp.id == alphabetList[selectedIndex]);
        textview = IconTheme(
          data: IconThemeData(
            color: Colors.white,
            size: 42,
          ),
          child: header.icon,
        );
      } else {
        textview = Text(
          "${alphabetList[selectedIndex]}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 60,
          ),
        );
      }
    } else {
      textview = Text("");
    }
    return Container(
      key: _screenKey,
      child: Stack(
        children: <Widget>[
          CustomScrollView(
            key: _mainKey,
            controller: controller,
            slivers: <Widget>[
              ..._headerWidgetList(),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  var currentIndex = index;
                  return Container(
                    height: widget.indexedHeight(index),
                    child: widget.itemBuilder(context, currentIndex),
                  );
                }, childCount: widget.strList.length),
              )
            ],
          ),
          if (widget.showPreview)
            IgnorePointer(
              child: AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Container(
                      width: 160,
                      height: 160,
                      color: Colors.black54,
                      child: Center(child: textview),
                    ),
                  ),
                ),
              ),
            ),
          _AlphabetListScollView(
            insideKey: _sideKey,
            specialHeader: widget.headerWidgetList.isNotEmpty,
            specialList: specialList,
            strList: alphabetList,
            selectedIndex: selectedIndex,
            keyboardUsage: widget.keyboardUsage,
            positionCallback: (position) {
              _currentWidgetIndex(position);
            },
            highlightTextStyle: widget.highlightTextStyle,
            normalTextStyle: widget.normalTextStyle,
          ),
        ],
      ),
    );
  }
}

typedef AlphabetCallback = Function(int, String);
typedef DoubleCallback = Function(double);

class _AlphabetListScollView extends StatefulWidget {
  final AlphabetCallback callback;
  final DoubleCallback positionCallback;
  final List<String> strList;
  final Widget child;
  final int selectedIndex;
  final GlobalKey insideKey;
  final TextStyle highlightTextStyle;
  final TextStyle normalTextStyle;
  final bool specialHeader;
  final List<_SpecialHeaderAlphabet> specialList;
  final bool keyboardUsage;

  const _AlphabetListScollView({
    Key key,
    this.callback,
    this.strList,
    this.child,
    this.selectedIndex,
    this.positionCallback,
    this.insideKey,
    this.highlightTextStyle = const TextStyle(color: Colors.red),
    this.normalTextStyle = const TextStyle(color: Colors.black),
    this.specialHeader = false,
    this.specialList = const [],
    this.keyboardUsage,
  }) : super(key: key);

  @override
  _AlphabetListScollViewState createState() => _AlphabetListScollViewState();
}

class _AlphabetListScollViewState extends State<_AlphabetListScollView> {
  int savedIndex = 0;
  double alphabetHeight = 0;
  Map<String, int> strMap = {};

  @override
  void initState() {
    super.initState();
  }

  List<Widget> aToZ() {
    List<Widget> charList = [];

    for (var x = 0; x < widget.strList.length; x++) {
      Widget textview;

      if (widget.strList[x].length > 1) {
        var header =
            widget.specialList.firstWhere((sp) => sp.id == widget.strList[x]);
        textview = IconTheme(
          data: IconThemeData(
            size: 18,
            color: widget.selectedIndex == x
                ? widget.highlightTextStyle.color
                : widget.normalTextStyle.color,
          ),
          child: header.icon,
        );
      } else {
        textview = Text(
          widget.strList[x],
          textAlign: TextAlign.justify,
          style: widget.selectedIndex == x
              ? widget.highlightTextStyle
              : widget.normalTextStyle,
        );
      }
      charList.add(Padding(
        padding: const EdgeInsets.all(2.0),
        child: textview,
      ));
    }
    return charList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Center(
          child: Container(
            key: widget.insideKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onPanStart: (details) {
                  widget.positionCallback(details.localPosition.dy);
                },
                onPanUpdate: (details) {
                  widget.positionCallback(details.localPosition.dy);
                },
                onTapDown: (details) {
                  widget.positionCallback(details.localPosition.dy);
                },
                child: _column(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _column() {
    if (!widget.keyboardUsage) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: aToZ(),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: aToZ(),
        ),
      );
    }
  }
}
