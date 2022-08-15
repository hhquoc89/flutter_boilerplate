import 'package:dio/dio.dart';

import '../configs/constants.dart';

///R = Raw type you get from response ( Ex: Using DIO is Response object)
///E = Expected type ( Ex: Common data format you want to get is Map<String,dynamic>
abstract class BaseAPIResponseDataTransformer<R, E> {
  E extractData(R response);
}

class DioResponseDataTransformer
    extends BaseAPIResponseDataTransformer<Response, Map<String, dynamic>> {
  @override
  Map<String, dynamic> extractData(Response response) {
    return {
      AppConstants.rootAPIDataFormat: response.data,
      AppConstants.rootAPIStatusFormat: response.statusCode,
      AppConstants.rootAPIStatusMessageFormat: response.statusMessage
    };
  }
}
