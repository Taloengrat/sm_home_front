import 'package:flutter/material.dart';

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
  Offset position;
  Offset posOffset = Offset(0.0, 0.0);
  bool selected = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    _key = widget.key;
    position = widget.initPos;
    scopeArea = widget.scopeArea;
    super.initState();
  }

  void _getRenderOffsets() {
    final RenderBox renderBoxWidget = _key.currentContext.findRenderObject();
    final offset = renderBoxWidget.localToGlobal(Offset.zero);

    posOffset = offset - position;
  }

  void _afterLayout(_) {
    _getRenderOffsets();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.scopeArea);
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Listener(
        child: Draggable(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.itmColor,
              border: Border.all(
                  color: selected ? Colors.blue : Colors.transparent, width: 3),
            ),
            child: InkWell(
              onTap: () {},
              onHover: (event) {
                if (event) {
                  setState(() {
                    print('true');
                    selected = true;
                  });
                } else {
                  setState(() {
                    print('false');
                    selected = false;
                  });
                }
              },
              child: widget.itemWidget,
            ),
          ),
          feedback: Container(
            width: 82,
            height: 82,
            color: widget.itmColor,
          ),
          childWhenDragging: Container(),
          onDragEnd: (drag) {
            setState(() {
              if (drag.offset.dx > 100 &&
                  drag.offset.dx < scopeArea.width &&
                  drag.offset.dy > 100 &&
                  drag.offset.dy < scopeArea.height) {
                position = drag.offset - posOffset;
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
