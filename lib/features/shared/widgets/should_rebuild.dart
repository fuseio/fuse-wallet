import 'package:flutter/material.dart';

typedef ShouldRebuildFunction<T> = bool Function(T oldWidget, T newWidget);

class ShouldRebuild<T extends Widget> extends StatefulWidget {
  final T child;
  final ShouldRebuildFunction<T> shouldRebuild;
  const ShouldRebuild({
    required this.child,
    required this.shouldRebuild,
    Key? key,
  }) : super(key: key);
  @override
  State<ShouldRebuild> createState() => _ShouldRebuildState<T>();
}

class _ShouldRebuildState<T extends Widget> extends State<ShouldRebuild<T>> {
  @override
  ShouldRebuild<T> get widget => super.widget;
  T? oldWidget;
  @override
  Widget build(BuildContext context) {
    final T newWidget = widget.child;
    if (oldWidget == null || widget.shouldRebuild(oldWidget!, newWidget)) {
      oldWidget = newWidget;
    }
    return oldWidget!;
  }
}
