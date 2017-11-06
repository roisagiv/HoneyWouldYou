import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:honeywouldyou/auth/authenticator.dart';
import 'package:honeywouldyou/navigation.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:honeywouldyou/theme.dart';
import 'package:honeywouldyou/widgets/main_app_bar.dart';
import 'package:redux/redux.dart';

///
typedef OnButtonClicked = Function(String email, String password);

///
class SignUpPage extends StatefulWidget {
  final NextDispatcher _dispatcher;

  final String _errorMessage;

  final bool _inProgress;

  final Authenticator _authenticator;

  final Navigation _navigation;

  ///
  const SignUpPage(this._errorMessage, this._authenticator, this._dispatcher,
      this._navigation,
      {bool inProgress})
      : _inProgress = inProgress;

  @override
  State<StatefulWidget> createState() => new SignUpPageState();
}

///
class SignUpPageState extends State<SignUpPage> {
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  static final GlobalKey<FormFieldState<String>> _emailKey =
      new GlobalKey<FormFieldState<String>>();

  static final GlobalKey<FormFieldState<String>> _passwordKey =
      new GlobalKey<FormFieldState<String>>();

  ///
  SignUpPageState();

  ///
  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new MainAppBar(
          title: new Text(
            'Honey!',
            style: AppTextStyles.appBarTitle(context),
          ),
          subtitle: new Text(
            'Welcome',
            style: AppTextStyles.appBarSubtitle(context),
          )),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Container(
              height: 1.0,
              child: new LinearProgressIndicator(
                value: widget._inProgress ? null : 0.0,
              )),
          new Container(
            padding: const EdgeInsets.all(16.0),
            child: new Container(
              padding: const EdgeInsets.all(8.0),
              child: _signUpForm(context, widget._errorMessage),
            ),
          )
        ],
      ));

  Form _signUpForm(BuildContext context, String errorMessage) => new Form(
        key: _formKey,
        autovalidate: true,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _textFormFieldRow(
                new TextFormField(
                  key: _emailKey,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  decoration: new InputDecoration(
                      hintText: 'email@email.com',
                      hideDivider: true,
                      errorStyle: AppTextStyles.textErrorMessage(context)),
                ),
                new Icon(Icons.email)),
            _textFormFieldRow(
                new TextFormField(
                  key: _passwordKey,
                  obscureText: true,
                  validator: _validatePassword,
                  decoration: new InputDecoration(
                    hintText: 'password',
                    hideDivider: true,
                    errorStyle: AppTextStyles.textErrorMessage(context),
                  ),
                ),
                new Icon(Icons.lock)),
            new ListTile(
                title: new Text(
              errorMessage ?? '',
              style: AppTextStyles.textErrorMessage(context),
            )),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new RaisedButton(
                  child: new Text(
                    'Sign Up',
                    style: AppTextStyles.buttonText(context),
                  ),
                  color: AppColors.radicalRed,
                  onPressed: _register,
                ),
                new Container(
                  decoration: new BoxDecoration(
                      border:
                          new Border.all(color: AppColors.black, width: 1.0),
                      borderRadius: kMaterialEdges[MaterialType.button]),
                  child: new FlatButton(
                    onPressed: _login,
                    child: new Text(
                      'Log In',
                      style: AppTextStyles.buttonTextDark(context),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );

  ///
  Widget _textFormFieldRow(Widget child, Widget icon) => new Card(
        child: new ListTile(
          leading: icon,
          subtitle: new Text(''),
          title: child,
        ),
      );

  Future<Null> _login() async {
    if (_formKey.currentState.validate() == false) {
      return;
    }
    final String email = _emailKey.currentState.value;
    final String password = _passwordKey.currentState.value;

    widget._dispatcher(
        new OnLoginButtonClickedAction(email: email, password: password));

    final Result<AuthenticatedUser> result = await widget._authenticator
        .signInWithEmailAndPassword(email: email, password: password);

    if (result.isValue) {
      widget._dispatcher(
          new OnUserAuthenticationSucceedAction(result.asValue.value));
      widget._navigation.navigateTo(context, '/');
    } else {
      widget._dispatcher(
          new OnUserAuthenticationFailedAction(result.asError.error));
    }
  }

  Future<Null> _register() async {
    if (_formKey.currentState.validate() == false) {
      return;
    }

    final String email = _emailKey.currentState.value;
    final String password = _passwordKey.currentState.value;

    widget._dispatcher(
        new OnLoginButtonClickedAction(email: email, password: password));

    final Result<AuthenticatedUser> result = await widget._authenticator
        .createUserWithEmailAndPassword(email: email, password: password);

    if (result.isValue) {
      widget._dispatcher(
          new OnUserAuthenticationSucceedAction(result.asValue.value));
      widget._navigation.navigateTo(context, '/');
    } else {
      widget._dispatcher(
          new OnUserAuthenticationFailedAction(result.asError.error));
    }
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'E-Mail is required.';
    }
    final RegExp emailExp =
        new RegExp(r'^([\w-\\.]+)@((?:[\w]+\.)+)([a-zA-Z]){2,4}$');
    if (!emailExp.hasMatch(value)) {
      return 'Please enter a valid e-mail adresse';
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length <= 5) {
      return 'The password must be 6 characters long or more.';
    }
    return null;
  }
}
