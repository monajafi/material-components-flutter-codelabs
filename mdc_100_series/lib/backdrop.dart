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
  Widget _buildStack(){
    return Stack(
      key: _backdropKey,
      children: <Widget>[
        widget.backLayer,
        widget.frontLayer
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        titleSpacing: 0.0,
        leading: Icon(Icons.menu),
        title: Text('SHRINE'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
            },
          ),
          IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: () {
            },
          ),
        ],
      );
    return Scaffold(
      appBar: appBar,
      body: _buildStack(),
    );
  }
}
