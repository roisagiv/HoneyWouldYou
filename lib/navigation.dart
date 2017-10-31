import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:honeywouldyou/home/home_page.dart';
import 'package:honeywouldyou/tasks/tasks_page.dart';

///
class Navigation {
  static final Router _router = new Router();

  static final Navigation _singleton = new Navigation._internal();

  ///
  factory Navigation() => _singleton;

  Navigation._internal();

  ///
  void configure() {
    _router
      ..define('/',
          handler: new Handler(
              handlerFunc: (context, params) => new HomePage(new Navigation())))
      ..define('/lists/:listId',
          handler: new Handler(
              handlerFunc: (context, params) =>
                  new TasksPage(params['listId'])));
  }

  ///
  void navigateTo(BuildContext context, String route,
          {TransitionType transition}) =>
      _router.navigateTo(context, route, transition: transition);
}
