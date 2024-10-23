import 'package:math_ui/models/matrix_operation.dart';
import 'package:signals_flutter/signals_flutter.dart';

final state = AppState.instance;

class AppState {
  AppState._();
  static final instance = AppState._();

  final editingMatrixOperation = signal(MatrixOperation.multiply);
  final editingMatrixDimension1 = signal((3, 3));

  late final showEditingMatrix2 =
      computed(() => switch (editingMatrixOperation.value) {
            MatrixOperation.scale => false,
            MatrixOperation.add => true,
            MatrixOperation.subtract => true,
            MatrixOperation.multiply => true,
            MatrixOperation.determinant => false,
            MatrixOperation.transpose => false,
            MatrixOperation.inverse => false,
            MatrixOperation.trace => false,
            MatrixOperation.evd => false,
            MatrixOperation.svd => false,
          });
  final editingMatrixDimension2 = signal((3, 3));

  final isPropertiesReady = signal(false);
  final matrixOperation = signal(MatrixOperation.multiply);
  final matrixDimension1 = signal((3, 3));
  final matrixDimension2 = signal((3, 3));

  late final canSaveProperties = computed(() {
    return editingMatrixOperation.value != matrixOperation.value ||
        matrixDimension1.value.$1 != editingMatrixDimension1.value.$1 ||
        matrixDimension1.value.$2 != editingMatrixDimension1.value.$2 ||
        matrixDimension2.value.$1 != editingMatrixDimension2.value.$1 ||
        matrixDimension2.value.$2 != editingMatrixDimension2.value.$2;
  });

  bool validate() {
    return true;
  }

  bool validateAndSaveProperties() {
    if (!validate()) {
      return false;
    }
    matrixOperation.value = editingMatrixOperation.value;
    matrixDimension1.value = editingMatrixDimension1.value;
    matrixDimension2.value = editingMatrixDimension2.value;
    isPropertiesReady.value = true;
    return true;
  }

  void resetProperties() {
    isPropertiesReady.value = false;
  }
}
