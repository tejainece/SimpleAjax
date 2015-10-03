// Copyright (c) 2015, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/*Future<HttpRequest> postAjaxForm(String url, FormData fdata) {
  HttpRequest req = new HttpRequest();
  return _postAjaxForm(req, url, fdata);
}

Future<HttpRequest> _postAjaxForm(HttpRequest req, String url, FormData fdata) {
  Completer completer = new Completer();

  req.open("POST", url);
  req.setRequestHeader('Accept', 'application/json');
  req.setRequestHeader("X-Requested-With", "XMLHttpRequest");

  req.onLoad.listen((ProgressEvent pe) {
    HttpRequest response = pe.target;
    if (response.status < 200 || response.status > 299) {
      completer.completeError(response);
    } else {
      completer.complete(response);
    }
  }, onError: (e) {
    completer.completeError(e);
  });

  req.onAbort.listen((_) {
    completer.completeError("Request aborted!");
  });
  try {
    req.send(fdata);
  } catch (e) {
    completer.completeError("Error: @postAjaxForm to url ${url} ${e}");
  }

  return completer.future;
}*/
