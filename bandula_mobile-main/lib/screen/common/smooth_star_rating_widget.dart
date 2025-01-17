import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(double? rating);

class SmoothStarRating extends StatefulWidget {
  const SmoothStarRating({
    Key? key,
    this.isRTl,
    this.starCount = 5,
    this.isReadOnly = false,
    this.spacing = 0.0,
    this.rating = 0.0,
    this.defaultIconData = Icons.star_border,
    this.onRated,
    this.color,
    this.borderColor,
    this.size = 25,
    this.filledIconData = Icons.star,
    this.halfFilledIconData = Icons.star_half,
    this.allowHalfRating = true,
  }) : super(key: key);

  final int starCount;
  final double rating;
  final bool? isRTl;
  final RatingChangeCallback? onRated;
  final Color? color;
  final Color? borderColor;
  final double size;
  final bool allowHalfRating;
  final IconData filledIconData;
  final IconData halfFilledIconData;
  final IconData
      defaultIconData; //this is needed only when having fullRatedIconData && halfRatedIconData
  final double spacing;
  final bool isReadOnly;

  @override
  State<SmoothStarRating> createState() => _SmoothStarRatingState();
}

class _SmoothStarRatingState extends State<SmoothStarRating> {
  final double halfStarThreshold =
      0.53; //half star value starts from this number

  //tracks for user tapping on this widget
  bool isWidgetTapped = false;
  double? currentRating;
  Timer? debounceTimer;
  @override
  void initState() {
    currentRating = widget.rating;
    super.initState();
  }

  @override
  void dispose() {
    debounceTimer?.cancel();
    debounceTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Wrap(
          alignment: WrapAlignment.start,
          spacing: widget.spacing,
          children: List<Widget>.generate(
              widget.starCount, (int index) => buildStar(context, index))),
    );
  }

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= currentRating!) {
      icon = Icon(
        widget.defaultIconData,
        color: widget.borderColor ?? Theme.of(context).primaryColor,
        size: widget.size,
      );
    } else if (index >=
            currentRating! -
                (widget.allowHalfRating ? halfStarThreshold : 1.0) &&
        index < currentRating!) {
      icon = Icon(
        widget.halfFilledIconData,
        color: widget.color ?? Theme.of(context).primaryColor,
        size: widget.size,
      );
    } else {
      icon = Icon(
        widget.filledIconData,
        color: widget.color ?? Theme.of(context).primaryColor,
        size: widget.size,
      );
    }
    final Widget star = widget.isReadOnly
        ? icon
        : kIsWeb
            ? MouseRegion(
                onExit: (PointerExitEvent event) {
                  if (widget.onRated != null && !isWidgetTapped) {
                    //reset to zero only if rating is not set by user
                    setState(() {
                      currentRating = 0;
                    });
                  }
                },
                onEnter: (PointerEnterEvent event) {
                  isWidgetTapped = false; //reset
                },
                onHover: (PointerHoverEvent event) {
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  final Offset pos = box.globalToLocal(event.position);
                  final double i = pos.dx / widget.size;
                  double newRating =
                      widget.allowHalfRating ? i : i.round().toDouble();
                  if (newRating > widget.starCount) {
                    newRating = widget.starCount.toDouble();
                  }
                  if (newRating < 0) {
                    newRating = 0.0;
                  }
                  setState(() {
                    if (widget.isRTl!) {
                      currentRating = widget.starCount - newRating;
                    } else {
                      currentRating = newRating;
                    }
                  });
                },
                child: GestureDetector(
                  onTapDown: (TapDownDetails detail) {
                    isWidgetTapped = true;

                    final RenderBox box =
                        context.findRenderObject() as RenderBox;
                    final Offset pos = box.globalToLocal(detail.globalPosition);
                    final double i = (pos.dx - widget.spacing) / widget.size;
                    double newRating =
                        widget.allowHalfRating ? i : i.round().toDouble();
                    if (newRating > widget.starCount) {
                      newRating = widget.starCount.toDouble();
                    }
                    if (newRating < 0) {
                      newRating = 0.0;
                    }
                    setState(() {
                      if (widget.isRTl!) {
                        currentRating = widget.starCount - newRating;
                      } else {
                        currentRating = newRating;
                      }
                    });

                    widget.onRated!(currentRating);
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails dragDetails) {
                    isWidgetTapped = true;

                    final RenderBox box =
                        context.findRenderObject() as RenderBox;
                    final Offset pos =
                        box.globalToLocal(dragDetails.globalPosition);
                    final double i = pos.dx / widget.size;
                    double newRating =
                        widget.allowHalfRating ? i : i.round().toDouble();
                    if (newRating > widget.starCount) {
                      newRating = widget.starCount.toDouble();
                    }
                    if (newRating < 0) {
                      newRating = 0.0;
                    }
                    setState(() {
                      if (widget.isRTl!) {
                        currentRating = widget.starCount - newRating;
                      } else {
                        currentRating = newRating;
                      }
                    });
                    debounceTimer?.cancel();
                    debounceTimer =
                        Timer(const Duration(milliseconds: 100), () {
                      widget.onRated!(currentRating);
                    });
                  },
                  child: icon,
                ),
              )
            : GestureDetector(
                onTapDown: (TapDownDetails detail) {
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  final Offset pos = box.globalToLocal(detail.globalPosition);
                  final double i = (pos.dx - widget.spacing) / widget.size;
                  double newRating =
                      widget.allowHalfRating ? i : i.round().toDouble();
                  if (newRating > widget.starCount) {
                    newRating = widget.starCount.toDouble();
                  }
                  if (newRating < 0) {
                    newRating = 0.0;
                  }
                  newRating = normalizeRating(newRating);
                  setState(() {
                    if (widget.isRTl!) {
                      currentRating = widget.starCount - newRating;
                    } else {
                      currentRating = newRating;
                    }
                  });
                },
                onTapUp: (TapUpDetails e) {
                  if (widget.onRated != null) {
                    widget.onRated!(currentRating);
                  }
                },
                onHorizontalDragUpdate: (DragUpdateDetails dragDetails) {
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  final Offset pos =
                      box.globalToLocal(dragDetails.globalPosition);
                  final double i = pos.dx / widget.size;
                  double newRating =
                      widget.allowHalfRating ? i : i.round().toDouble();
                  if (newRating > widget.starCount) {
                    newRating = widget.starCount.toDouble();
                  }
                  if (newRating < 0) {
                    newRating = 0.0;
                  }
                  setState(() {
                    if (widget.isRTl!) {
                      currentRating = widget.starCount - newRating;
                    } else {
                      currentRating = newRating;
                    }
                  });
                  debounceTimer?.cancel();
                  debounceTimer = Timer(const Duration(milliseconds: 100), () {
                    if (widget.onRated != null) {
                      widget.onRated!(currentRating);
                    }
                  });
                },
                child: icon,
              );

    return star;
  }

  double normalizeRating(double newRating) {
    final double k = newRating - newRating.floor();
    if (k != 0) {
      //half stars
      if (k >= halfStarThreshold) {
        newRating = newRating.floor() + 1.0;
      } else {
        newRating = newRating.floor() + 0.5;
      }
    }
    return newRating;
  }
}
