import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/widgets/widgets.dart';
import 'widgets_formatting.dart';

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class Authentication extends StatelessWidget {
  const Authentication({
    Key? key,
    required this.loginState,
    required this.email,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
    required this.signOut,
  }) : super(key: key);

  final ApplicationLoginState loginState;
  final String? email;
  final void Function() startLoginFlow;
  final void Function(
    String email,
    void Function(Exception e) error,
  ) verifyEmail;
  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
  ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
    String email,
    String displayName,
    String password,
    void Function(Exception e) error,
  ) registerAccount;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedOut:
        Preferences.isLoggedIn = false;
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: StyledButton(
                onPressed: () {
                  startLoginFlow();
                },
                child: const Text('Login RSVP'),
              ),
            ),
          ],
        );
      case ApplicationLoginState.emailAddress:
        return EmailForm(
            callback: (email) => verifyEmail(
                email, (e) => _showErrorDialog(context, 'Invalid email', e)));
      case ApplicationLoginState.password:
        return PasswordForm(
          email: email!,
          login: (email, password) {
            signInWithEmailAndPassword(email, password,
                (e) => _showErrorDialog(context, 'Failed to sign in', e));
          },
          cancel: () {
            cancelRegistration();
          },
        );
      case ApplicationLoginState.register:
        return RegisterForm(
          email: email!,
          cancel: () {
            cancelRegistration();
          },
          registerAccount: (
            email,
            displayName,
            password,
          ) {
            registerAccount(
                email,
                displayName,
                password,
                (e) =>
                    _showErrorDialog(context, 'Failed to create account', e));
          },
        );
      case ApplicationLoginState.loggedIn:
        Preferences.isLoggedIn = true;
        return Padding(
          padding: const EdgeInsets.symmetric( horizontal: 50.0, vertical: 70.0 ),
          child: Column(
            children: [
              const LoginAccount(),
              StyledMaterialButton(
                onPressed: () {
                  signOut();
                },
                child: const Text('LOGOUT', style: TextStyle( fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold), ), 
              )             
            ],
          ),
          /* child: StyledMaterialButton(
            onPressed: () {
              signOut();
            },
            child: const Text('LOGOUT'),
          ), */
        );
      default:
        return Row(
          children: const [
            Text("Internal error, this shouldn't happen..."),
          ],
        );
    }
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            StyledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}

class EmailForm extends StatefulWidget {
  const EmailForm({Key? key, required this.callback}) : super(key: key);
  final void Function(String email) callback;
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //const Header('Sign in with email'),
        Padding(
          padding: const EdgeInsets.symmetric( horizontal: 50.0, vertical: 70.0 ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor, ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor,),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor,), 
                    ),                      
                    //hintText: 'Email',
                    label: const Center(
                      child: Text("Email"),
                    ),
                    //labelText: 'Email',
                    labelStyle: const TextStyle(
                      color: kPrimaryColor,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    //hintStyle: kStInputFieldLog
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your email address to continue';
                    }
                    return null;
                  },
                ),
                const SizedBox( height: 16.0, ),
                StyledMaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      widget.callback(_controller.text);
                    }
                  },
                  child: const Text('NEXT', style: TextStyle( fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold), ),
                ),

                const LoginMethods(),

                /* const SizedBox(height: 95.0,),
                const Text('Sign up',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: kPrimaryColor,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0,),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () { Navigator.pushNamed(context, 'login_signup_screen'); },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(const BorderSide( color: kPrimaryColor, ), ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                        padding: MaterialStateProperty.all( const EdgeInsets.symmetric( vertical: 14 ), ),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 16,
                          //fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                        ))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.email_outlined, size: 28.0, color: Color(0xFF0BB48B), ),
                        SizedBox(width : 10),
                        Text("Continue with Email", style: TextStyle( color: kPrimaryColor, ),),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12.0,),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(const BorderSide( color: kPrimaryColor, ), ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                        padding: MaterialStateProperty.all( const EdgeInsets.symmetric( vertical: 14 ), ),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 16,
                          //fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                        ))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/icons_methods/icon_apple.png"),
                        const SizedBox(width : 10),
                        const Text("Continue with Apple", style: TextStyle( color: kPrimaryColor, ),),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12.0,),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(const BorderSide( color: kPrimaryColor, ), ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                        padding: MaterialStateProperty.all( const EdgeInsets.symmetric( vertical: 14 ), ),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 16,
                          //fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                        ))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/icons_methods/Google_2.png"),
                        const SizedBox(width : 10),
                        const Text("Continue with Google", style: TextStyle( color: kPrimaryColor, ),),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12.0,),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(const BorderSide( color: kPrimaryColor, ), ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                        padding: MaterialStateProperty.all( const EdgeInsets.symmetric( vertical: 14 ), ),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 16,
                          //fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                        ))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/icons_methods/icon_facebook.png"),
                        const SizedBox(width : 10),
                        const Text("Continue with Facebook", style: TextStyle( color: kPrimaryColor, ),),
                      ],
                    ),
                  ),
                ), */





              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
    required this.registerAccount,
    required this.cancel,
    required this.email,
  }) : super(key: key);
  final String email;
  final void Function(String email, String displayName, String password)
      registerAccount;
  final void Function() cancel;
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //const Header('Create account'),
        Padding(
          padding: const EdgeInsets.symmetric( horizontal: 50.0, vertical: 70.0 ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor, ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor,),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor,), 
                    ), 
                    label: const Center(
                      child: Text("Enter your email"),
                    ),
                    labelStyle: const TextStyle(
                      color: kPrimaryColor,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,

                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your email address to continue';
                    }
                    return null;
                  },
                ),
                const SizedBox( height: 16.0, ),
                TextFormField(
                  controller: _displayNameController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor, ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor,),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor,), 
                    ), 
                    label: const Center(
                      child: Text("First & last name"),
                    ),
                    labelStyle: const TextStyle(
                      color: kPrimaryColor,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your account name';
                    }
                    return null;
                  },
                ),
                const SizedBox( height: 16.0, ),
                TextFormField(
                  controller: _passwordController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor, ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor,),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor,), 
                    ), 
                    label: const Center(
                      child: Text("Password"),
                    ),
                    labelStyle: const TextStyle(
                      color: kPrimaryColor,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox( height: 16.0, ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle( color: Color(0xFF58595B), fontSize: 12.0, ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Password must consist of at least 6 characters.\nand be strong enough.'
                      )
                    ]
                  )
                ),
                const SizedBox( height: 32.0, ),
                StyledMaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.registerAccount(
                            _emailController.text,
                            _displayNameController.text,
                            _passwordController.text,
                          );
                        }
                      },
                  child: const Text('REGISTER', style: TextStyle( fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold), ), 
                ),
                const SizedBox( height: 16.0, ),
                StyledMaterialButton(
                  onPressed: widget.cancel,
                  child: const Text('CANCEL', style: TextStyle( fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold), ), 
                ),
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //const SizedBox(width: 32),
                    MaterialButton(
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22.0 ),
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0) ),
                      color: kSecondaryColor,
                      onPressed: widget.cancel,
                      child: const Text('CANCEL', style: TextStyle( fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold), ),
                    ),
                    const SizedBox(width: 16),
                    MaterialButton(
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0 ),
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0) ),
                      color: kSecondaryColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.registerAccount(
                            _emailController.text,
                            _displayNameController.text,
                            _passwordController.text,
                          );
                        }
                      },
                      child: const Text('REGISTER', style: TextStyle( fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold), ),
                    ),
                    //const SizedBox(width: 30),
                  ],
                ), */
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordForm extends StatefulWidget {
  const PasswordForm({
    Key? key,
    required this.login,
    required this.email,
    required this.cancel,
  }) : super(key: key);
  final String email;
  final void Function(String email, String password) login;
  final void Function() cancel;
  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //const Header('Sign in'),
        Padding(
          padding: const EdgeInsets.symmetric( horizontal: 50.0, vertical: 70.0 ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor, ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor,),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor,), 
                    ), 
                    //hintText: 'Enter your email',
                    label: const Center(
                      child: Text("Email"),
                    ),
                    labelStyle: const TextStyle(
                      color: kPrimaryColor,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your email address to continue';
                    }
                    return null;
                  },
                ),
                const SizedBox( height: 16.0, ),
                TextFormField(
                  controller: _passwordController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor, ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor,),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor,), 
                    ), 
                    //hintText: 'Password',
                    label: const Center(
                      child: Text("Password"),
                    ),
                    labelStyle: const TextStyle(
                      color: kPrimaryColor,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox( height: 16.0, ),
                StyledMaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.login(
                        _emailController.text,
                        _passwordController.text,
                      );
                    }
                  },
                  child: const Text('SIGN IN', style: TextStyle( fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold), ),
                ),
                const SizedBox(height: 16),
                StyledMaterialButton(
                  onPressed: widget.cancel,
                  child: const Text( 'CANCEL', style: TextStyle( fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold), ), 
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
