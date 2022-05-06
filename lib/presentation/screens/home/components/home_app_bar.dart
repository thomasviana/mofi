import 'dart:io' show File, Platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../resources/resources.dart';
import '../../../routes/app_navigator.dart';
import '../../../utils/observer.dart';
import '../home_bloc/home_screen_bloc.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _HomeAppBarDelegate(),
    );
  }
}

class _HomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double _barHeight = 90.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    final Brightness _brightness =
        SchedulerBinding.instance!.window.platformBrightness;
    final bool _isDarkMode = _brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + _barHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (Platform.isIOS)
            Row(
              children: [
                const SizedBox(width: 16),
                Observer<HomeScreenBloc, HomeScreenState>(
                  onSuccess: (context, state) {
                    final user = state.user;
                    Widget? image;

                    if (user.imagePath != null) {
                      image = Image.file(
                        File(user.imagePath!),
                        fit: BoxFit.cover,
                      );
                    } else if (user.photoUrl != null) {
                      image = CachedNetworkImage(
                        imageUrl: user.photoUrl!,
                        progressIndicatorBuilder: (_, __, progress) =>
                            CircularProgressIndicator(value: progress.progress),
                        errorWidget: (_, __, ___) => const Icon(Icons.error),
                        fit: BoxFit.cover,
                      );
                    }
                    return InkWell(
                      onTap: () => AppNavigator.navigateToProfilePage(context),
                      child: ClipOval(
                        // ignore: sized_box_for_whitespace
                        child: Container(height: 32, width: 32, child: image),
                      ),
                    );
                  },
                ),
              ],
            )
          else
            const SizedBox(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: const [
                const Icon(
                  Icons.donut_large_outlined,
                  color: AppColors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  'mofi',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
          ),
          if (Platform.isAndroid) Spacer(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_on,
                    color: Colors.white,
                  ),
                ),
              ),
              if (Platform.isAndroid)
                Observer<HomeScreenBloc, HomeScreenState>(
                  onSuccess: (context, state) {
                    final user = state.user;
                    Widget? image;

                    if (user.imagePath != null) {
                      image = Image.file(
                        File(user.imagePath!),
                        fit: BoxFit.cover,
                      );
                    } else if (user.photoUrl != null) {
                      image = CachedNetworkImage(
                        imageUrl: user.photoUrl!,
                        progressIndicatorBuilder: (_, __, progress) =>
                            CircularProgressIndicator(value: progress.progress),
                        errorWidget: (_, __, ___) => const Icon(Icons.error),
                        fit: BoxFit.cover,
                      );
                    }
                    return InkWell(
                      onTap: () => AppNavigator.navigateToProfilePage(context),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: image,
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          )
        ],
      ),
      decoration: _isDarkMode
          ? BoxDecoration(
              color: Theme.of(context).bottomAppBarColor,
            )
          : BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset(1.1, 0.0),
                end: FractionalOffset(0.0, 0.0),
                stops: const [0.0, 1.0],
                colors: const [
                  AppColors.primaryColor,
                  AppColors.primaryVariant,
                ],
              ),
            ),
    );
  }

  @override
  double get maxExtent => _barHeight;

  @override
  double get minExtent => _barHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
