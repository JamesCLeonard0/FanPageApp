import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fanpageapp/signup/signup.dart';
import 'package:fanpageapp/Feed/RealFeed.dart';
import 'package:fanpageapp/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  LoginPage({ Key? key }) : super(key: key);
final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
 final _formKey = GlobalKey<FormState>();
 var _email = TextEditingController();
 var _password = TextEditingController();
var _display = TextEditingController();

var _displayname;
var _role;
bool _buttonvisible = false;


  get displayName => _displayname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Color.fromARGB(255, 199, 255, 126),

   appBar: AppBar(centerTitle: true,backgroundColor: Color.fromARGB(255, 0, 107, 27),title: Text("The Fantabulous Page for the Magnificent JAMES"),),
      body: Center( 
      child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.center ,mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
        /*
        Text("Display Name"),
TextFormField(controller: _display,
validator: (String? value){
  onSaved: (value){
  _display.text =  value!;
  };
}),
*/
Text("Email"),
TextFormField(controller: _email, onSaved: (value){
  _email.text =  value!;
  })
,
Text("Password"),
TextFormField(controller: _password,
obscureText: true,
validator: (String? value){
  if(value!.isEmpty){

    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Empty Password")));
    return ("Empty Password");
  }else if(value.length < 8){
    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Your password must be longer than 8 characters")));
    return ("Your password must be longer than 8 characters");
  }
  return null;
},
onSaved: (value){
  _password.text =  value!;
}
),
ElevatedButton(onPressed: (){

  signIn(context, _email.text, _password.text);

}, child: const Text("Enter")),
ElevatedButton(onPressed: (){
Navigator.push(context, MaterialPageRoute(builder:(context) =>  signuppage()));

}, child: const Text("Register")),
TextButton(onPressed: (){ 
_handleSignIn();

}, child: const Text("Sign in with Google"))
      ],)
      
      
      
      ,)
    )
    );
  }
   void signIn(BuildContext context, String email, String password) async {
    if(_formKey.currentState!.validate()){
      await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
               checkrole(context),
                
               
                ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Login Successful"))),
 //print(_buttonvisible.toString()),
                
               
        }).catchError((e){
          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Login Unsuccessful")));

        }
        );
    }


  }
  checkrole(BuildContext context) async{
    final firebaseuser = await FirebaseAuth.instance.currentUser!;
  if(firebaseuser != null){
    await FirebaseFirestore.instance
    .collection('users')
    .doc(firebaseuser.uid)
    .get()
    .then((ds){
      _role = ds.get('role');
       //ScaffoldMessenger.of(context).showSnackBar(  SnackBar(content: Text(_role.toString().contains('A').toString())));
        _buttonvisible = _role.toString().contains('A');
        //print(_buttonvisible);
        print(_role.toString().contains('A'));
           _displayname = ds.get('display_name');
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RealFeed(displayName: displayName, buttonvisible: _buttonvisible)));
         // print(displayName.toString());
     } ).catchError((e){
        print(e);

    });
  }
  

  
}
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
Future<void> _handleSignIn() async {
  try {
    await _googleSignIn.signIn();
  } catch (error) {
    print(error);
  }
}


}