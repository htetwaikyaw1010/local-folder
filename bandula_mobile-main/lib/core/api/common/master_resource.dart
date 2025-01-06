import 'package:bandula/core/viewobject/product.dart';

import 'master_status.dart';

class MasterResource<T> {
  MasterResource(this.status, this.message, this.data, {this.meta}) {
    if (message.contains('##')) {
      /**
       * Backend will reply error code within message 
       * Error code and message are seperated with '##' sign
       * 
       * Error code 10001 = // Totally No Record
       * Error code 10002 = // No More Record at pagination
       */

      final List<String> messageList = message.split('##');
      if (messageList.length > 1) {
        errorCode = messageList[0];
        message = messageList[0];
      }
    }
  }
  MasterStatus status;

  String message = '';
  String errorCode = '';
  T? data;
  Meta? meta;
}
