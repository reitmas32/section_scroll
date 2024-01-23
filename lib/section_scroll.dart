library section_scroll;

import 'package:flutter/material.dart';

class SectionScroll extends StatefulWidget {
  const SectionScroll({
    super.key,
    required this.controller,
    this.children = const <Widget>[],
    this.activeTab,
    this.deactiveTab,
    this.curve,
    this.duration,
  });
  final ScrollController controller;
  final List<Widget> children;
  final Widget? activeTab;
  final Widget? deactiveTab;
  final Duration? duration;
  final Curve? curve;

  @override
  SectionScrollState createState() => SectionScrollState();
}

class SectionScrollState extends State<SectionScroll> {
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateScrollPosition);
  }

  void _updateScrollPosition() {
    setState(() {
      _scrollPosition = widget.controller.position.pixels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          controller: widget.controller,
          itemCount: widget.children.length,
          itemExtent: MediaQuery.of(context).size.height,
          itemBuilder: (BuildContext context, int index) {
            return widget.children[index];
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...widget.children.asMap().entries.map((entry) {
                  int index = entry.key;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => updateSection(index),
                      child: isActive(index)
                          ? getActiveWidget()
                          : getDeactiveWidget(),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget getActiveWidget() {
    return widget.activeTab ??
        const CircleContainer(
          radius: 20,
          color: Colors.white,
        );
  }

  Widget getDeactiveWidget() {
    return widget.deactiveTab ??
        const CircleContainer(
          radius: 20,
          color: Colors.grey,
        );
  }

  bool isActive(index) {
    return (_scrollPosition + MediaQuery.of(context).size.height * 0.25) ~/
            MediaQuery.of(context).size.height ==
        index;
  }

  updateSection(index) => setState(() {
        widget.controller.animateTo(
          index * MediaQuery.of(context).size.height,
          duration: widget.duration ?? const Duration(milliseconds: 500),
          curve: widget.curve ?? Curves.linear,
        );
      });
}

class CircleContainer extends StatelessWidget {
  final double? radius;
  final Color? color;

  const CircleContainer({this.radius, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius ?? 20 * 2,
      height: radius ?? 20 * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
