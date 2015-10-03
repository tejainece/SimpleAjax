// Copyright (c) 2015, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library simple_ajax.base;

import 'dart:html';
import 'dart:convert';
import 'dart:async';

part 'put.dart';
part 'delete.dart';
part 'get.dart';
part 'post.dart';
part 'exception.dart';

/**
 * addJSONHeaders adds content type, accept and requested with
 * headers to the provided request.
 */
void addJSONHeaders(HttpRequest aReq) {
  aReq.setRequestHeader('Content-type', 'application/json');
  aReq.setRequestHeader('Accept', 'application/json');
  aReq.setRequestHeader("X-Requested-With", "XMLHttpRequest");
}