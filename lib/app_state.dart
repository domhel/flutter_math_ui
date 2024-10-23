import 'package:domhel_vectors/models/matrix.dart';
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
  final showMatrix2 = signal(false);

  final canEditInput = signal(false);

  final matrixOperation = signal(MatrixOperation.multiply);
  final matrixDimension1 = signal((0, 0));
  final matrix1 = signal(const Matrix([[]]));
  final matrixDimension2 = signal((0, 0));
  final matrix2 = signal(const Matrix([[]]));

  final resultIsUpToDate = signal(false);

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

  Matrix _matrixFromDimensions((int, int) dimensions,
          [Matrix? valuesFromOldMatrix]) =>
      Matrix(
        List.generate(
          dimensions.$1,
          (i) => List.generate(
              dimensions.$2,
              (j) =>
                  valuesFromOldMatrix?.value
                      .elementAtOrNull(i)
                      ?.elementAtOrNull(j) ??
                  0),
        ),
      );

  bool validateAndSaveProperties() {
    if (!validate()) {
      return false;
    }
    matrixOperation.value = editingMatrixOperation.value;
    matrixDimension1.value = editingMatrixDimension1.value;
    matrixDimension2.value = editingMatrixDimension2.value;
    canEditInput.value = true;
    showMatrix2.value = showEditingMatrix2.value;

    matrix1.value = _matrixFromDimensions(
      matrixDimension1.value,
      matrix1.value,
    );
    matrix2.value = _matrixFromDimensions(
      matrixDimension2.value,
      showMatrix2.value ? matrix2.value : null,
    );
    assert(matrix1.value.dimension[0] == matrixDimension1.value.$1);
    assert(matrix1.value.dimension[1] == matrixDimension1.value.$2);
    assert(matrix2.value.dimension[0] == matrixDimension2.value.$1);
    assert(matrix2.value.dimension[1] == matrixDimension2.value.$2);
    return true;
  }

  void resetProperties() {
    canEditInput.value = false;
  }
}
