import 'package:canban/utils/Network/BasicRestController.dart';

class RestController extends BasicRestController {
  RestController() {
    // TODO: implement RestController
  }

  void sendPostRequest(
      {required void Function({required String data, required int statusCode})
          onComplete,
      required void Function({required int statusCode}) onError,
      required String controller,
      required String data,
      String? accessToken}) {
    super.sendRequest(
        onComplete: onComplete,
        onError: onError,
        controller: controller,
        data: data,
        accessToken: accessToken,
        requestFunc: super.postRequest);
  }
}
