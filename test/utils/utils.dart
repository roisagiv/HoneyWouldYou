import 'dart:async';

///
Future<Null> aBit() =>
    new Future<Null>.delayed(new Duration(milliseconds: 100));

///
Future<Null> aBitLonger() =>
    new Future<Null>.delayed(new Duration(milliseconds: 200));
