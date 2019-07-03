import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'model/product.dart';

class Backdrop extends StatefulWidget {
  final Category currentCategory;
  final Widget backLayer;
  final Widget frontLayer;
  final Widget backTitle;
  final Widget frontTitle;

  const Backdrop({
    @required this.currentCategory,
    @required this.backLayer,
    @required this.frontLayer,
    @required this.backTitle,
    @required this.frontTitle,
  }): assert(currentCategory != null),
      assert(backLayer != null),
      assert(frontLayer != null),
      assert(backTitle != null),
      assert(frontTitle != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop> with SingleTickerProviderStateMixin{
  GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
