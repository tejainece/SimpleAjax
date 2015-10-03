# SimpleAjax

A wrapper around Dart's HttpRequest to create
- Asynchronous Ajax calls
- with exceptions on failure
- Simple method based interface

## Usage

A simple usage example:

    import 'package:SimpleAjax/SimpleAjax.dart';

    main() {
      try {
        dynamic data = getAjaxJsonResp("/some/url", {"data1": "some", "data2": "thing"});
      } on AjaxRequestException catch(e) {
        //TODO Do something about the exception
      }
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][https://github.com/tejainece/SimpleAjax/issues].
