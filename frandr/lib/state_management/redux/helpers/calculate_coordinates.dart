import 'package:frandr/displays/models.dart';

DisplayOffset calculateDisplayCoordinates(
  double xOffset,
  double yOffset,
  Display display,
  Setup setup,
  int wiggleRoom,
) {
  final x = _calculateXForDisplayArea(xOffset, display, setup, wiggleRoom)
      .clamp(0, setup.maxWidth);
  final y = _calculateYForDisplayArea(yOffset, display, setup, wiggleRoom)
      .clamp(0, setup.maxHeight);

  return DisplayOffset(x, y);
}

int _calculateXForDisplayArea(
  double x,
  Display display,
  Setup setup,
  int wiggleRoom,
) {
  if (x < 0) return 0;

  var width = display.resolution.width;
  if (x + width > setup.maxWidth) {
    return setup.maxWidth - width;
  }

  final leftMeetsRight =
      _getLeftMeetsRightNeighbor(x, display, setup.displays, wiggleRoom);
  if (leftMeetsRight != null) {
    return leftMeetsRight.offset.x + leftMeetsRight.resolution.width;
  }

  final leftMeetsLeft =
      _getLeftMeetsLeftNeighbor(x, display, setup.displays, wiggleRoom);
  if (leftMeetsLeft != null) {
    return leftMeetsLeft.offset.x;
  }

  final rightMeetsLeft =
      _getRightMeetsLeftNeighbor(x, display, setup.displays, wiggleRoom);
  if (rightMeetsLeft != null) {
    return rightMeetsLeft.offset.x - display.resolution.width;
  }

  final rightMeetsRight =
      _getRightMeetsRightNeighbor(x, display, setup.displays, wiggleRoom);
  if (rightMeetsRight != null) {
    return rightMeetsRight.offset.x -
        display.resolution.width +
        rightMeetsRight.resolution.width;
  }

  return x.toInt();
}

int _calculateYForDisplayArea(
  double y,
  Display display,
  Setup setup,
  int wiggleRoom,
) {
  if (y < 0) return 0;

  var height = display.resolution.height;
  if (y + height > setup.maxHeight) {
    return setup.maxHeight - height;
  }

  final topMeetsTop =
      _getTopMeetsTopNeighbor(y, display, setup.displays, wiggleRoom);
  if (topMeetsTop != null) {
    return topMeetsTop.offset.y;
  }

  final bottomMeetsTop =
      _getBottomMeetsTopNeighbor(y, display, setup.displays, wiggleRoom);
  if (bottomMeetsTop != null) {
    return (bottomMeetsTop.offset.y - display.resolution.height);
  }

  final bottomMeetsBottom =
      _getBottomMeetsBottomNeighbor(y, display, setup.displays, wiggleRoom);
  if (bottomMeetsBottom != null) {
    return bottomMeetsBottom.offset.y -
        display.resolution.height +
        bottomMeetsBottom.resolution.height;
  }

  final topMeetsBottom =
      _getTopMeetsBottomNeighbor(y, display, setup.displays, wiggleRoom);
  if (topMeetsBottom != null) {
    return topMeetsBottom.offset.y + topMeetsBottom.resolution.height;
  }

  return y.toInt();
}

// get the neighbor whose right edge meets the display's left edge
Display? _getLeftMeetsRightNeighbor(
  double x,
  Display display,
  List<Display> displays,
  int wiggleRoom,
) {
  final index = displays.indexWhere((el) {
    if (el == display) return false;

    final width = el.resolution.width;
    final rightEdge = el.offset.x + width;
    return isInRange(x, rightEdge, wiggleRoom);
  });

  return index < 0 ? null : displays[index];
}

// get the neighbor whose left edge meets the display's left edge
Display? _getLeftMeetsLeftNeighbor(
  double x,
  Display display,
  List<Display> displays,
  int wiggleRoom,
) {
  final index = displays.indexWhere((el) {
    if (el == display) return false;

    final leftEdge = el.offset.x;
    return isInRange(x, leftEdge, wiggleRoom);
  });

  return index < 0 ? null : displays[index];
}

// get the neighbor whose right edge meets the display's right edge
Display? _getRightMeetsRightNeighbor(
  double x,
  Display display,
  List<Display> displays,
  int wiggleRoom,
) {
  final displayRightEdge = x + display.resolution.width;
  final index = displays.indexWhere((el) {
    if (el == display) return false;

    final rightEdge = el.offset.x + el.resolution.width;
    return isInRange(displayRightEdge, rightEdge, wiggleRoom);
  });

  return index < 0 ? null : displays[index];
}

// get the neighbor whose left edge meets the display's right edge
Display? _getRightMeetsLeftNeighbor(
  double x,
  Display display,
  List<Display> displays,
  int wiggleRoom,
) {
  final index = displays.indexWhere((el) {
    if (el == display) return false;

    final leftEdge = el.offset.x;
    return isInRange(x + display.resolution.width, leftEdge, wiggleRoom);
  });

  return index < 0 ? null : displays[index];
}

Display? _getTopMeetsTopNeighbor(
  double y,
  Display display,
  List<Display> displays,
  int wiggleRoom,
) {
  final index = displays.indexWhere((el) {
    if (el == display) return false;

    final topEdge = el.offset.y;
    return isInRange(y, topEdge, wiggleRoom);
  });

  return index < 0 ? null : displays[index];
}

Display? _getBottomMeetsTopNeighbor(
  double y,
  Display display,
  List<Display> displays,
  int wiggleRoom,
) {
  final index = displays.indexWhere((el) {
    if (el == display) return false;

    final topEdge = el.offset.y;
    return isInRange(y + display.resolution.height, topEdge, wiggleRoom);
  });

  return index < 0 ? null : displays[index];
}

Display? _getBottomMeetsBottomNeighbor(
  double y,
  Display display,
  List<Display> displays,
  int wiggleRoom,
) {
  final index = displays.indexWhere((el) {
    if (el == display) return false;

    final bottomEdge = el.offset.y + el.resolution.height;
    return isInRange(y + display.resolution.height, bottomEdge, wiggleRoom);
  });

  return index < 0 ? null : displays[index];
}

Display? _getTopMeetsBottomNeighbor(
  double y,
  Display display,
  List<Display> displays,
  int wiggleRoom,
) {
  final index = displays.indexWhere((el) {
    if (el == display) return false;

    final bottomEdge = el.offset.y + el.resolution.height;
    return isInRange(y, bottomEdge, wiggleRoom);
  });

  return index < 0 ? null : displays[index];
}

bool isInRange(double offset, int edge, int wiggleRoom) =>
    offset < edge + wiggleRoom && offset > edge - wiggleRoom;
