import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(),
      home: new FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final ScaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    final form = formKey.currentState;

    if (form!.validate()) {
      form.save();

      performLogin();
    }
  }

  void performLogin() {
    final snackBar = SnackBar(
      content: Text("Email : $_email, password : $_password"),
    );
    ScaffoldKey.currentState!.showSnackBar(snackBar);
  }

  String _validatePassword(String pass) {
    final passwordExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (passwordExp.hasMatch(pass)) {
      return "pass";
    } else {
      return "Notpass";
    }
  }

  String? conform;

  Widget build(BuildContext context) {
    return new Scaffold(
      key: ScaffoldKey,
      appBar: new AppBar(
        title: Text("Form Filling page"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(labelText: "Email"),
                validator: (val) =>
                    !val!.contains('@') ? 'Invalid Email' : null,
                onSaved: (val) => _email = val,
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: "Password"),
                validator: (val) {
                  conform = _validatePassword(val!);
                  conform!.contains("pass")
                      ? val = null
                      : val = 'Invalid password';
                },
                obscureText: true,
                onSaved: (val) => _password = conform!,
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new RaisedButton(
                child: new Text("Login"),
                onPressed: _submit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
