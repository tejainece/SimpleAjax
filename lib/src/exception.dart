// Copyright (c) 2015, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of simple_ajax.base;

const int AJAXEXCEPTION_REASON_SEND_ERROR = 1;
const int AJAXEXCEPTION_REASON_UNAUTHORIZED = 2;
const int AJAXEXCEPTION_REASON_ERROR = 2;

//TODO improve exceptions

class AjaxRequestException implements Exception {
  AjaxRequestException(HttpRequest req) {
    try {
      data = JSON.decode(req.responseText);
    } catch (e) {}

    //TODO fix this part

    if (req.status == 401) {
      reason = AJAXEXCEPTION_REASON_UNAUTHORIZED;
    } else if (req.status == 400) {
      reason = AJAXEXCEPTION_REASON_ERROR;

      if (data != null && data["Code"] is int) {
        errCode = data["Code"];
      }
    }
  }

  AjaxRequestException.OtherError(this.reason) {}

  int reason = 0;
  int errCode = 0;
  Map data;

  String toString() {
    return "${reason}";
  }
}

class UnauthorizedException implements Exception {
  AjaxRequestException() {

  }

  String toString() {
    return "Please login!";
  }
}

Exception _createException(HttpRequest req) {
  if(req.status == 401) {
    return new UnauthorizedException();
  } else {
    return new AjaxRequestException(req);
  }
}