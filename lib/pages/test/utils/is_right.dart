import 'package:testerx/models/core.dart';

EIsRight isRightCheck(List<RightList?>? rightList, int itemIndex, int index,
    List<String?> rights, String? element) {
  final isRight = rightList?.firstWhere(
    (el) => el?.index == itemIndex,
    orElse: () {
      return null;
    },
  );
  if (isRight == null) {
    return EIsRight.blank;
  }
  if (isRight.isTrue == true && isRight.selected!.contains(index)) {
    return EIsRight.right;
  }
  if (isRight.selected!.contains(index)) {
    return EIsRight.wrong;
  }
  if (rights.contains(element)) {
    return EIsRight.correct;
  }
  return EIsRight.blank;
}

enum EIsRight { right, wrong, correct, blank }
