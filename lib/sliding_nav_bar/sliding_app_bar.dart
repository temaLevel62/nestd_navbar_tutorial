import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navbar_visibility_supervisor.dart';

class SlidingPrefSizedWidget extends SlidingBar
    implements PreferredSizeWidget {

  final PreferredSizeWidget prefSizedChild;

  const SlidingPrefSizedWidget(
      {super.key, required child, super.axisAligment = 1})
      : prefSizedChild = child, super(child: child);

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  prefSizedChild.preferredSize;
}

class SlidingBar extends StatefulWidget {
  const SlidingBar({
    super.key,
    required this.child,
    this.axisAligment = -1,
  });

  final Widget child;
  final double axisAligment;

  @override
  State<SlidingBar> createState() => _SlidingBarState();
}

class _SlidingBarState extends State<SlidingBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
    final navBarNotifier = context.read<NavbarVisibilitySupervisor>();
    navBarNotifier.addListener(() => navBarNotifier.hideBottomNavBar
        ? _controller.reverse()
        : _controller.forward());
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: SizeTransition(
      sizeFactor: _controller,
      axisAlignment: widget.axisAligment,
      child: widget.child,
    ));
  }
}
