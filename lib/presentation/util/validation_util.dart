import 'package:calendar_scheduler/presentation/util/toast_util.dart';
import '../const/strings.dart';

class ValidationUtil {
  ValidationUtil._();

  static bool checkInputValidations(int startTime, int endTime, String content) {
    if (!isTimeInputValid(startTime, endTime)) {
      ToastUtil().showDefaultToast(Strings.INPUT_ERROR_TIME);
      return false;
    }

    if (!isContentInputValid(content)) {
      ToastUtil().showDefaultToast(Strings.INPUT_ERROR_CONTENT);
      return false;
    }

    return true;
  }

  static bool isTimeInputValid(int startTime, int endTime) => startTime < endTime;

  static bool isContentInputValid(String content) => content.isNotEmpty;
}
