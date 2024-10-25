import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:math_ui/app_state.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) {
        return FScaffold(
          header: FHeader(
            title: Text(
              '3. Result',
              style: state.isResultUpToDate.value
                  ? null
                  : context.theme.headerStyle.rootStyle.titleTextStyle
                      .copyWith(color: context.theme.colorScheme.muted),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Result Matrix',
                  style: context.theme.typography.lg,
                ),
                const SizedBox(height: 8),
                for (var i = 0; i < state.resultMatrix.value.value.length; ++i)
                  Row(
                    children: [
                      for (var j = 0;
                          j < state.resultMatrix.value.value[i].length;
                          ++j)
                        Expanded(
                          child: FTextField(
                            enabled: false,
                            suffix: Text(
                              '(${i + 1},${j + 1})',
                              style: context.theme.textFieldStyle.enabledStyle
                                  .hintTextStyle,
                            ),
                            initialValue:
                                state.resultMatrix.value.value[i][j].toString(),
                          ),
                        )
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
