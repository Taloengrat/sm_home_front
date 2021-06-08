import 'package:flutter/material.dart';
import 'package:dotted_decoration/dotted_decoration.dart';

class SymbolDragObject extends StatefulWidget {
  final String id;
  final Offset initPos;
  final Color itmColor;
  final Widget itemWidget;
  final Size scopeArea;

  SymbolDragObject({
    Key key,
    this.id,
    this.initPos,
    this.itmColor,
    this.itemWidget,
    this.scopeArea,
  }) : super(key: key);

  @override
  _SymbolDragObjectState createState() => _SymbolDragObjectState();
}

class _SymbolDragObjectState extends State<SymbolDragObject> {
  GlobalKey _key;
  Size scopeArea;
  Offset position = Offset(100, 100);
  Offset posOffset = Offset(0.0, 0.0);
  bool selected = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    _key = widget.key;

    position = Offset((widget.initPos.dx / widget.scopeArea.width),
            (widget.initPos.dy / widget.scopeArea.height)) -
        posOffset;

    scopeArea = widget.scopeArea;
    print('initState');
    super.initState();
  }

  void _getRenderOffsets() {
    final RenderBox renderBoxWidget = _key.currentContext.findRenderObject();
    final offset = renderBoxWidget.localToGlobal(Offset.zero);

    // posOffset = offset - position;
  }

  void _afterLayout(_) {
    _getRenderOffsets();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.scopeArea);
    print('build => ' + position.dx.toString() + ', ' + position.dy.toString());

    print('real position => ' +
        (position.dx * widget.scopeArea.width).toString() +
        ', ' +
        (position.dy * widget.scopeArea.height).toString());
    return Positioned(
      left: position.dx * widget.scopeArea.width,
      top: position.dy * widget.scopeArea.height,
      child: Listener(
        child: Draggable(
          child: InkWell(
            onTap: () {
              setState(() {
                selected = !selected;
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              width: 80,
              height: 80,
              decoration: selected
                  ? DottedDecoration(
                      shape: Shape.circle,
                      strokeWidth: 5,
                      color: Colors.black,
                    )
                  : BoxDecoration(
                      shape: BoxShape.circle,
                    ),
              child: widget.itemWidget,
            ),
          ),
          feedback: Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: widget.itemWidget,
          ),
          childWhenDragging: Container(),
          onDragEnd: (drag) {
            setState(() {
              if (drag.offset.dx > 100 &&
                  drag.offset.dx < scopeArea.width &&
                  drag.offset.dy > 100 &&
                  drag.offset.dy < scopeArea.height) {
                var percentX = drag.offset.dx / widget.scopeArea.width;
                var percentY = drag.offset.dy / widget.scopeArea.height;

                print('drag x' + drag.offset.dx.toString());
                print('drag y' + drag.offset.dy.toString());
                // position = Offset(x, y);
                position = Offset(percentX, percentY);
              } else {
                position = widget.initPos;
              }

              print('update position => ' + position.toString());
            });
          },
        ),
      ),
    );
  }
}
