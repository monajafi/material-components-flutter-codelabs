import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'model/product.dart';

const double _kFlingVelocity = 2.0;

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

class _FrontLayer extends StatelessWidget {

  const _FrontLayer({Key key,this.child}): super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: child,
          )
        ],
      ),
    );
  }
}

class _BackdropState extends State<Backdrop> with SingleTickerProviderStateMixin{
  GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;
  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this
    );
  }

  bool get _frontLayerVisible{
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || 
           status == AnimationStatus.forward;
  }

  void toggleBackdropLayerVisibility(){
    _controller.fling(
      velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity
    );
  }

  @override 
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  Widget _buildStack(BuildContext context,BoxConstraints constraints){
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;
    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0)
      ).animate(_controller.view);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        _FrontLayer(child: widget.frontLayer,)
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
