import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:math_ui/app_state.dart';
import 'package:signals_flutter/signals_flutter.dart';

class InputPage extends StatelessWidget {
  const InputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) {
        return FScaffold(
          header: FHeader(
            title: Text(
              '2. Input',
              style: state.canEditInput.value
                  ? null
                  : context.theme.headerStyle.rootStyle.titleTextStyle
                      .copyWith(color: context.theme.colorScheme.muted),
            ),
          ),
          content: state.canEditInput.value
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Matrix 1',
                        style: context.theme.typography.lg,
                      ),
                      const SizedBox(height: 8),
                      for (var i = 0; i < state.matrix1.value.value.length; ++i)
                        Row(
                          children: [
                            for (var j = 0;
                                j < state.matrix1.value.value[i].length;
                                ++j)
                              Expanded(
                                child: FTextField(
                                  suffix: Text(
                                    '(${i + 1},${j + 1})',
                                    style: context.theme.textFieldStyle
                                        .enabledStyle.hintTextStyle,
                                  ),
                                  initialValue: state.matrix1.value.value[i][j]
                                      .toString(),
                                ),
                              )
                          ],
                        ),
                      if (state.showMatrix2.value) ...[
                        const FDivider(),
                        Text(
                          'Matrix 2',
                          style: context.theme.typography.lg,
                        ),
                        const SizedBox(height: 8),
                        for (var i = 0;
                            i < state.matrix2.value.value.length;
                            ++i)
                          Row(
                            children: [
                              for (var j = 0;
                                  j < state.matrix2.value.value[i].length;
                                  ++j)
                                Expanded(
                                  child: FTextField(
                                    suffix: Text(
                                      '(${i + 1},${j + 1})',
                                      style: context.theme.textFieldStyle
                                          .enabledStyle.hintTextStyle,
                                    ),
                                    initialValue: state
                                        .matrix2.value.value[i][j]
                                        .toString(),
                                  ),
                                )
                            ],
                          ),
                      ],
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
