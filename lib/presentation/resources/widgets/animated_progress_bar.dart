import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../resources.dart';

class AnimatedProgressBar extends StatefulWidget {
  AnimatedProgressBar({
    Key? key,
    this.currentValue = 0,
    this.maxValue = 100,
    this.size = 30,
    this.animatedDuration = const Duration(milliseconds: 300),
    this.direction = Axis.horizontal,
    this.verticalDirection = VerticalDirection.down,
    BorderRadiusGeometry? borderRadius,
    this.border,
    this.backgroundColor = const Color(0x00FFFFFF),
    this.progressColor = AppColors.green,
    this.changeColorValue,
    this.changeProgressColor = AppColors.red,
    this.displayText,
    this.displayTextStyle =
        const TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),
  })  : _borderRadius = borderRadius ?? BorderRadius.circular(8),
        super(key: key);
  final double currentValue;
  final int maxValue;
  final double size;
  final Duration animatedDuration;
  final Axis direction;
  final VerticalDirection verticalDirection;
  final BorderRadiusGeometry _borderRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final Color progressColor;
  final int? changeColorValue;
  final Color changeProgressColor;
  final String? displayText;
  final TextStyle displayTextStyle;

  @override
  _FAProgressBarState createState() => _FAProgressBarState();
}

class _FAProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  double _currentBegin = 0;
  double _currentEnd = 0;

  @override
  void initState() {
    _controller =
        AnimationController(duration: widget.animatedDuration, vsync: this);
    _animation = Tween<double>(begin: _currentBegin, end: _currentEnd)
        .animate(_controller);
    triggerAnimation();
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedProgressBar old) {
    triggerAnimation();
    super.didUpdateWidget(old);
  }

  void triggerAnimation() {
    setState(() {
      _currentBegin = _animation.value;

      if (widget.currentValue == 0 || widget.maxValue == 0) {
        _currentEnd = 0;
      } else if (widget.currentValue.isInfinite) {
        _currentEnd = widget.maxValue.toDouble();
      } else {
        _currentEnd = widget.currentValue / widget.maxValue;
      }

      _animation = Tween<double>(begin: _currentBegin, end: _currentEnd)
          .animate(_controller);
    });
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) => _AProgressBar(
        isInfinite: widget.currentValue.isInfinite,
        animation: _animation,
        widget: widget,
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _AProgressBar extends AnimatedWidget {
  final AnimatedProgressBar widget;
  final bool isInfinite;

  const _AProgressBar({
    Key? key,
    required Animation<double> animation,
    required this.widget,
    required this.isInfinite,
  }) : super(key: key, listenable: animation);

  double transformValue(num x, num begin, num end, num before) {
    final double y = (end * x - (begin - before)) * (1.0 / before);
    return y < 0 ? 0 : ((y > 1) ? 1 : y);
  }

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    Color progressColor = widget.progressColor;

    if (widget.changeColorValue != null) {
      final _colorTween = ColorTween(
        begin: widget.progressColor,
        end: widget.changeProgressColor,
      );

      progressColor = _colorTween.transform(
        transformValue(
          animation.value,
          widget.changeColorValue!,
          widget.maxValue,
          5,
        ),
      )!;
    }

    final List<Widget> progressWidgets = [];
    final Widget progressWidget = Container(
      decoration: BoxDecoration(
        color: progressColor,
        borderRadius: widget._borderRadius,
        border: widget.border,
      ),
    );
    progressWidgets.add(progressWidget);

    if (widget.displayText != null) {
      final Widget textProgress = Container(
        alignment: widget.direction == Axis.horizontal
            ? FractionalOffset(0.98, 0.5)
            : (widget.verticalDirection == VerticalDirection.up
                ? FractionalOffset(0.5, 0.05)
                : FractionalOffset(0.5, 0.95)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            isInfinite
                ? AppLocalizations.of(context)!.widgets_progress_bar_no_budget
                : '${(animation.value * widget.maxValue).toInt().toString()} ${widget.displayText!} ',
            softWrap: false,
            style: widget.displayTextStyle,
          ),
        ),
      );
      progressWidgets.add(textProgress);
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: widget.direction == Axis.vertical ? widget.size : null,
        height: widget.direction == Axis.horizontal ? widget.size : null,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget._borderRadius,
          border: widget.border,
        ),
        child: Flex(
          direction: widget.direction,
          verticalDirection: widget.verticalDirection,
          children: <Widget>[
            Expanded(
              flex: (animation.value * 100).toInt(),
              child: Stack(
                children: progressWidgets,
              ),
            ),
            Expanded(
              flex: 100 - (animation.value * 100).toInt(),
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
