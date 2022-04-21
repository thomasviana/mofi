import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../common/extensions.dart';
import '../../../core/date/date_bloc.dart';
import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _HomeHeaderDelegate(),
    );
  }
}

class _HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  static const double _defaultElevation = 4.0;
  static const double _defaultHeaderHeight = 148;
  static const double _mainCardHeight = 110;
  static const double _topPadding = 50;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double extentDiff = maxExtent - minExtent;
    final double elevation =
        (shrinkOffset > extentDiff) ? _defaultElevation : 0.0;
    final double shrinkRatio = shrinkOffset / extentDiff; // 0 ... 1
    final double opacity = 1 - shrinkRatio; // 1 ... 0
    const space = 95 - kToolbarHeight;
    final percent =
        lerpDouble(0.0, -pi / 2, ((shrinkOffset / 2) / space).clamp(0.0, 1.0));

    return AnimatedHeader(
      elevation: elevation,
      opacity: opacity,
      percent: percent,
    );
  }

  @override
  double get maxExtent =>
      _topPadding + _defaultHeaderHeight + (_mainCardHeight / 2);

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class AnimatedHeader extends StatefulWidget {
  const AnimatedHeader({
    Key? key,
    required this.elevation,
    required this.opacity,
    required this.percent,
  }) : super(key: key);

  final double elevation;
  final double opacity;
  final double? percent;

  @override
  State<AnimatedHeader> createState() => _AnimatedHeaderState();
}

class _AnimatedHeaderState extends State<AnimatedHeader>
    with SingleTickerProviderStateMixin {
  late DateBloc dateBloc;
  late Animation<double> _animation;
  late AnimationController _animationController;

  late double headerOpacity;
  late double scaleHeader;

  @override
  void initState() {
    headerOpacity = 0;
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.8, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {
          headerOpacity = _animation.value;
          scaleHeader = 1 - _animation.value;
        });
      });
    triggerAnimation();
    dateBloc = context.read<DateBloc>();
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedHeader old) {
    if (old.percent != 0) {
      triggerAnimation();
    }
    super.didUpdateWidget(old);
  }

  void triggerAnimation() {
    _animationController
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        return Material(
          elevation: widget.elevation,
          child: Stack(
            children: [
              Positioned.fill(
                bottom: 50 * widget.opacity,
                child: Container(
                  color: AppColors.primaryColor,
                ),
              ),
              Positioned(
                top: 12,
                left: 0,
                right: 0,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(widget.percent!)
                    ..scale(headerOpacity.clamp(0.8, 1)),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.misc_balance,
                        style: TextStyle(
                          color:
                              AppColors.white.withOpacity(0.5 * headerOpacity),
                        ),
                      ),
                      Text(
                        state.balance.toCurrencyFormat(),
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color:
                              AppColors.white.withOpacity(0.9 * headerOpacity),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Container(
                          height: 30,
                          constraints: BoxConstraints(minWidth: 200),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.white
                                .withOpacity(0.2 * headerOpacity),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                icon: Icon(
                                  Icons.chevron_left,
                                  color: AppColors.white
                                      .withOpacity(0.5 * headerOpacity),
                                ),
                                onPressed: () =>
                                    dateBloc.add(MonthDecremented()),
                              ),
                              Text(
                                DateFormat(
                                  'MMMM - yyyy',
                                  AppLocalizations.of(context)!.localeName,
                                ).format(state.date),
                                style: TextStyle(
                                  color: AppColors.white
                                      .withOpacity(0.5 * headerOpacity),
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: AppColors.white
                                      .withOpacity(0.5 * headerOpacity),
                                ),
                                onPressed: () =>
                                    dateBloc.add(MonthIncremented()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, -0.002)
                    ..scale(widget.opacity)
                    ..rotateX(-widget.percent!),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MiniCard(
                        icon: Icons.arrow_downward_rounded,
                        title: AppLocalizations.of(context)!
                            .misc_incomes
                            .toUpperCase(),
                        amount: state.incomes,
                        opacity: widget.opacity,
                      ),
                      MiniCard(
                        icon: Icons.arrow_upward_rounded,
                        title: AppLocalizations.of(context)!
                            .misc_expenses
                            .toUpperCase(),
                        amount: state.expenses,
                        opacity: widget.opacity,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
