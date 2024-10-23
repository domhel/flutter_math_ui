import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:math_ui/models/matrix_operation.dart';
import 'package:math_ui/pages/matrix_properties/+page.dart';
import 'package:math_ui/simple_ui/simple_dropdown.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          colorSchemeSeed: Colors.black,
        ),
        builder: (context, child) => FTheme(
          data: FThemes.zinc.light,
          child: child!,
        ),
        home: FScaffold(
          content: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final h = constraints.maxHeight;
              final axis = w > 840 ? Axis.horizontal : Axis.vertical;
              final (a, b, c) = axis == Axis.horizontal
                  ? (w / 3, w / 3, w / 3)
                  : (h / 3, h / 3, h / 3);
              return FResizable(
                axis: axis,
                children: [
                  FResizableRegion(
                    initialExtent: a,
                    minExtent: 100,
                    builder: (_, data, __) => const MatrixPropertiesPage(),
                  ),
                  FResizableRegion(
                    initialExtent: b,
                    minExtent: 100,
                    builder: (_, data, __) => const FScaffold(
                      header: FHeader(title: Text('2. Input')),
                      content: Center(
                        child: Text('settings go here'),
                      ),
                    ),
                  ),
                  FResizableRegion(
                    initialExtent: c,
                    minExtent: 100,
                    builder: (_, data, __) => const FScaffold(
                      header: FHeader(title: Text('3. Result')),
                      content: Center(
                        child: Text('settings go here'),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
}
