import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:honeywouldyou/auth/signup_page_container.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/home/home_page.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:honeywouldyou/tasks/tasks_page.dart';
import 'package:redux/redux.dart';

///
class Navigation {
  static final Router _router = new Router();

  static final Navigation _singleton = new Navigation._();

  ///
  factory Navigation() => _singleton;

  Navigation._();

  ///
  void configure({Store<AppState> store}) {
    _router
      ..define('/', handler: new Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        if (store.state.authentication.authenticationStatus ==
            AuthenticationStatus.authenticated) {
          return new HomePage(this);
        } else {
          return const SignUpPageContainer();
        }
      }))
      ..define('/lists/:listId',
          handler: new Handler(
              handlerFunc:
                  (BuildContext context, Map<String, dynamic> params) =>
                      new TasksPage(params['listId'])));
  }

  ///
  void navigateTo(BuildContext context, String route,
          {TransitionType transition}) =>
      _router.navigateTo(context, route, transition: transition);
}
