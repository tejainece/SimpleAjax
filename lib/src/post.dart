// Copyright (c) 2015, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of simple_ajax.base;

Future<Object> postAjaxJsonResp(String url, Map data) async {
  HttpRequest a_req = await postAjaxJson(url, data);
  Object l_ret = JSON.decode(a_req.responseText);
  return l_ret;
}

Future<HttpRequest> postAjaxJson(String url, Map data) async {
  HttpRequest req = new HttpRequest();
  req.open("POST", url);
  addJSONHeaders(req);

  try {
    req.send(JSON.encode(data));
  } catch (e) {
    throw new AjaxRequestException.OtherError(AJAXEXCEPTION_REASON_SEND_ERROR);
  }

  HttpRequest ret;
  await for (ProgressEvent pe in req.onLoad) {
    HttpRequest response = pe.target;
    if (response.status < 200 || response.status > 299) {
      throw new AjaxRequestException(response);
    } else {
      ret = response;
      break;
    }
  }

  return ret;
}