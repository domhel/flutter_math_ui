import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:math_ui/app_state.dart';
import 'package:math_ui/globals.dart';
import 'package:math_ui/models/matrix_operation.dart';
import 'package:math_ui/simple_ui/simple_dropdown.dart';
import 'package:signals_flutter/signals_flutter.dart';

class MatrixPropertiesPage extends StatelessWidget {
  const MatrixPropertiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = context.theme.typography.lg;
    return FScaffold(
      header: FHeader(
        title: const Text('1. Settings'),
        actions: [
          if (MediaQuery.of(context).size.width < sizeLg)
            FHeaderAction(
              icon: FIcon(FAssets.icons.save),
              onPress: state.canSaveProperties.watch(context)
                  ? () => state.validateAndSaveProperties()
                  : null,
            ),
        ],
      ),
      footer: MediaQuery.of(context).size.width >= sizeLg
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: FButton(
                onPress: state.canSaveProperties.watch(context)
                    ? () => state.validateAndSaveProperties()
                    : null,
                label: state.canSaveProperties.watch(context)
                    ? const Text('Save')
                    : const Text('Nothing to save'),
                suffix: FIcon(FAssets.icons.chevronRight),
              ),
            )
          : null,
      content: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Matrix Operation:',
                      style: titleStyle,
                    ),
                    const SizedBox(width: 16),
                    SimpleDropdown(
                      values: MatrixOperation.values,
                      initialValue: state.editingMatrixOperation.value,
                      onChanged: (newValue) {
                        if (newValue != null) {
                          state.editingMatrixOperation.value = newValue;
                        }
                      },
                    ),
                  ],
                ),
                const FDivider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Matrix 1 Dimension',
                      style: titleStyle,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FTextField(
                        label: const Text('N'),
                        description: const Text('Number of rows'),
                        keyboardType: const TextInputType.numberWithOptions(),
                        initialValue:
                            state.editingMatrixDimension1.value.$1.toString(),
                        onChange: (val) {
                          final n = int.tryParse(val);
                          if (n != null) {
                            state.editingMatrixDimension1.value =
                                (n, state.editingMatrixDimension1.value.$2);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FTextField(
                        label: const Text('M'),
                        description: const Text('Number of columns'),
                        keyboardType: const TextInputType.numberWithOptions(),
                        initialValue:
                            state.editingMatrixDimension1.value.$2.toString(),
                        onChange: (val) {
                          final n = int.tryParse(val);
                          if (n != null) {
                            state.editingMatrixDimension1.value =
                                (state.editingMatrixDimension1.value.$1, n);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Watch((_) {
                  if (state.showEditingMatrix2.value == false) {
                    return const SizedBox.shrink();
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const FDivider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Matrix 2 Dimension',
                              style: titleStyle,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: FTextField(
                                label: const Text('K'),
                                description: const Text('Number of rows'),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                initialValue: state
                                    .editingMatrixDimension2.value.$1
                                    .toString(),
                                onChange: (val) {
                                  final n = int.tryParse(val);
                                  if (n != null) {
                                    state.editingMatrixDimension2.value = (
                                      n,
                                      state.editingMatrixDimension2.value.$2
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: FTextField(
                                label: const Text('L'),
                                description: const Text('Number of columns'),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                initialValue: state
                                    .editingMatrixDimension2.value.$2
                                    .toString(),
                                onChange: (val) {
                                  final n = int.tryParse(val);
                                  if (n != null) {
                                    state.editingMatrixDimension2.value = (
                                      state.editingMatrixDimension2.value.$1,
                                      n
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
