// Copyright (c) 2015, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of simple_ajax.base;

Future<Object> deleteAjaxJsonResp(String url, dynamic data) async {
  HttpRequest aReq = await deleteAjaxJson(url, data);

  if(aReq.responseText.length == 0) {
    return null;
  }

  Object lRet = JSON.decode(aReq.responseText);
  return lRet;
}

Future<HttpRequest> deleteAjaxJson(String url, dynamic data) async {
  HttpRequest req = new HttpRequest();
  req.open("DELETE", url);
  addJSONHeaders(req, data != null);

  try {
    req.send(JSON.encode(data));
  } catch (e) {
    throw new AjaxRequestException.OtherError(AJAXEXCEPTION_REASON_SEND_ERROR);
  }

  HttpRequest ret;
  await for (ProgressEvent pe in req.onLoad) {
    HttpRequest response = pe.target;
    if (response.status < 200 || response.status > 299) {
      Exception bException = _createException(response);
      throw bException;
    } else {
      ret = response;
      break;
    }
  }

  return ret;
}