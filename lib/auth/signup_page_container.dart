import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:honeywouldyou/auth/signup_page.dart';
import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:honeywouldyou/services.dart';
import 'package:redux/redux.dart';

///
class SignUpPageContainer extends StatelessWidget {
  ///
  const SignUpPageContainer();

  ///
  @override
  Widget build(BuildContext context) => new StoreBuilder<AppState>(
        builder: (BuildContext context, Store<AppState> store) {
          final Injector injector = new Injector();
          return new SignUpPage(store.state.authentication.errorMessage,
              injector.authenticator, store.dispatch, injector.navigation,
              inProgress: store.state.authentication.authenticationStatus ==
                  AuthenticationStatus.inProgress);
        },
      );
}
