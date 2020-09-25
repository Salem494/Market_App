
import 'package:flutter/material.dart';
import 'package:marketapp/provider/auth.dart';
import 'package:marketapp/screens/product_overview_screen.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Container(
                      transform: Matrix4.rotationZ(0.1),
                      width: 400,
                      height: 225,
                      padding: EdgeInsets.all(25.0),
                      margin: EdgeInsets.all(40.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle
                      ),
                      child: Image.asset('assets/shop.jpg',fit: BoxFit.cover,),
                    ),
                  SizedBox(height: 15.0,),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin {

  final GlobalKey<FormState> _formKey = GlobalKey();

  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;


  AnimationController _controller ;
  Animation<Size>_heightAnimation;
  final _passwordController = TextEditingController();


  @override
      void initState() {
        _controller = AnimationController(vsync: this ,duration: Duration(microseconds: 300));
        super.initState();
        _heightAnimation = Tween<Size>(begin: Size(double.infinity,280),
            end: Size(double.infinity,320)).animate(
            CurvedAnimation(parent: _controller,curve:Curves.fastOutSlowIn

            ),
        );

//        _heightAnimation.addListener(() {});
        
      }
   @override
  void dispose() {
   _controller.dispose();
   _passwordController.dispose();
    super.dispose();
  }

  void _submit() async{
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      // Log user in
     await Provider.of<Auth>(context,listen: false).login(
          _authData['email'],
          _authData['email'],
      );
     Navigator.of(context).pushReplacementNamed(OverViewScreen.routeName);
    } else {
      // Sign user up
    await  Provider.of<Auth>(context,listen: false).signup(
          _authData['email'],
          _authData['password'],
      );
    Navigator.of(context).pushReplacementNamed(OverViewScreen.routeName);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });

      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
//    Navigator.of(context).pushReplacementNamed(OverViewScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedBuilder(
        animation: _heightAnimation,
        builder: (context, ch) => Container(
//        height: _authMode == AuthMode.Signup ? 320 : 260,
        height: _heightAnimation.value.height,
          constraints: BoxConstraints(minHeight:_heightAnimation.value.height),
          width: deviceSize.width * 0.75,
          padding: EdgeInsets.all(16.0),
        child: ch,
        ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'E-Mail'),
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                  if (_authMode == AuthMode.Signup)
                    TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration: InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          // ignore: missing_return
                          ? (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match!';
                        }
                      }
                          : null,
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    RaisedButton(
                      child:
                      Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                      onPressed: _submit,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryTextTheme.button.color,
                    ),
                  FlatButton(
                    child: Text(
                        '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                    onPressed: _switchAuthMode,
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}

