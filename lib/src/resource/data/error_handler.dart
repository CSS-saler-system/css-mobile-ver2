import 'package:dio/dio.dart';

import 'failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError,
  firebaseAuthError,
  registerDuplicateEmailError
}

class ResponseCode {
  // API status codes
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no content
  static const int badRequest = 400; // failure, api rejected the request
  static const int forbidden = 403; // failure, api rejected the request
  static const int unauthorised = 401; // failure user is not authorised
  static const int notFound =
      404; // failure, api url is not correct and not found
  static const int internalServerError =
      500; // failure, crash happened in server side

  // local status code
  static const int defaultError = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;

  //firebase status error
  static const int firebaseAuthError = -100;
}

class ResponseMessage {
  // // API status codes
  // // API response codes
  // static String success = AppStrings.success.tr(); // success with data
  // static String noContent =
  //     AppStrings.noContent.tr(); // success with no content
  // static String badRequest =
  //     AppStrings.badRequestError.tr(); // failure, api rejected our request
  // static String forbidden =
  //     AppStrings.forbiddenError.tr(); // failure,  api rejected our request
  // static String unauthorised =
  //     AppStrings.unauthorizedError.tr(); // failure, user is not authorised
  // static String notFound = AppStrings.notFoundError
  //     .tr(); // failure, API url is not correct and not found in api side.
  // static String internalServerError = AppStrings.internalServerError
  //     .tr(); // failure, a crash happened in API side.

  // // local responses codes
  // static String defaultError =
  //     AppStrings.defaultError.tr(); // unknown error happened
  // static String connectTimeout =
  //     AppStrings.timeoutError.tr(); // issue in connectivity
  // static String cancel =
  //     AppStrings.defaultError.tr(); // API request was cancelled
  // static String receiveTimeout =
  //     AppStrings.timeoutError.tr(); //  issue in connectivity
  // static String sendTimeout =
  //     AppStrings.timeoutError.tr(); //  issue in connectivity
  // static String cacheError = AppStrings.defaultError
  //     .tr(); //  issue in getting data from local data source (cache)
  // static String noInternetConnection =
  //     AppStrings.noInternetError.tr(); // issue in connectivity

  // static String firebaseAuthError = AppStrings.firebaseAuthError.tr();
}

class ApiInternalStatus {
  static const int success = 200;
  static const int failure = 400;
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // dio error so its error from response of the API
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.defaultError.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure();
          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure();
          case ResponseCode.unauthorised:
            return DataSource.unauthorised.getFailure();
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure();
          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure();
          default:
            return DataSource.defaultError.getFailure();
        }
      case DioErrorType.cancel:
        return DataSource.cancel.getFailure();
      case DioErrorType.other:
        return DataSource.defaultError.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, "");
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, "");
      case DataSource.unauthorised:
        return Failure(ResponseCode.unauthorised, "");
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, "");
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError, "");
      case DataSource.connectTimeout:
        return Failure(ResponseCode.connectTimeout, "");
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, "");
      case DataSource.receiveTimeout:
        return Failure(ResponseCode.receiveTimeout, "");
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, "");
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, "");
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection, "");
      case DataSource.firebaseAuthError:
        return Failure(ResponseCode.firebaseAuthError, "");
      case DataSource.defaultError:
        return Failure(ResponseCode.defaultError, "");
      default:
        return Failure(ResponseCode.defaultError, "");
    }
  }
}
