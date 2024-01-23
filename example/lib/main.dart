import 'package:flutter/material.dart';
import 'package:section_scroll/section_scroll.dart';

void main() {
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
        child: Scaffold(
          body: SectionScroll(
            controller: controller,
            children: List.generate(
              20,
              (index) => Container(
                color: index % 2 == 0 ? Colors.blue : Colors.green,
                child: Center(
                  child: Text(
                    'Item $index',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
