import 'package:flutter/material.dart';
import 'package:morse_code/dependencies/dependencies.dart';

class InheritedDependencies extends InheritedWidget {
  const InheritedDependencies({
    required this.appWidget,
    required this.dependencies,
    super.key, 
  }) : super(child: appWidget);

  final Dependencies dependencies;
  final Widget appWidget;

  static Dependencies? maybeOf(BuildContext context) =>
      (context.getElementForInheritedWidgetOfExactType<InheritedDependencies>()?.widget as InheritedDependencies?)
          ?.dependencies;

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a InheritedDependencies of the exact type',
        'out_of_scope',
      );

  static Dependencies of(BuildContext context) => maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(InheritedDependencies oldWidget) => false;
}
