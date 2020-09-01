



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:qchatapp/Authentication/auth.dart';
import 'package:qchatapp/screens/main_screen.dart';
import 'package:qchatapp/widgets/button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final loginPassword = TextEditingController();
  final loginEmail = TextEditingController();






  bool clicked = false;
  bool showPassword = false;
  bool clickedLogin = false;
  bool showPasswordLogin = false;

  bool passwordEmailNotFound = false;
  bool forgotPasswordClicked = false;
  String forgotPasswordWarning;



  onClickLogin() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        child: Container(
          padding: EdgeInsets.only(left: 30,right: 30,top: 20,bottom: 10),
          height: MediaQuery.of(context).size.height*0.60,
          width: double.infinity,

          child: Form(
            key: _formKey,
            child: Column(
              children: [


                SizedBox(height: 20,),


                TextFormField(
                  controller: loginEmail,
                  validator: (value) {
                    if(value.isEmpty) {
                      return "Field is empty";
                    }
                    if(!RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                        .hasMatch(value)) {
                      return "Invalid Email";
                    }

                    return null;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: "Email"
                  ),
                ),


                SizedBox(height: 20,),

                TextFormField(
                  controller: loginPassword,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if(value.isEmpty) {
                      return "Field is Empty";
                    }
                    return null;
                  },
                  obscureText: showPasswordLogin == false ? true : false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: "Password",
                      suffixIcon: IconButton(
                        onPressed: (){
                          if(showPasswordLogin == true) {
                            setState(() {
                              showPasswordLogin = false;
                            });
                          }
                          else{
                            setState(() {
                              showPasswordLogin = true;
                            });
                          }

                        },
                        icon: showPasswordLogin == true ?  Icon(Icons.remove_red_eye,color: Colors.red)  :
                            Icon(Icons.remove_red_eye),
                      )

                  ),
                ),

                InkWell(
                  onTap: ()async{
                   if (_formKey.currentState.validate()) {
                     await  _authService.resetPassword(email : loginEmail.text.toString());
                     Navigator.pop(context);
                     setState(() {
                       forgotPasswordWarning = "Password Reset email has been sent to your email";
                     });
                   }
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.centerRight,
                    child : Text("Forgot Password" , style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontFamily: 'sf_pro_semi_bold'
                    ),
                    )
                  ),
                ),

                SizedBox(height: 20,),

                 CustomButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  onClickMethod: (){
                    onPressedLoginButton();
                  },
                  text: "Login",
                  width: MediaQuery.of(context).size.width,
                ),

                SizedBox(height: 10,),

                CustomButton(
                  color: Color(0xff2cb9b0),
                  textColor: Colors.white,
                  onClickMethod: (){
                     loginWithGoogle();
                  },
                  text: "Continue with Google",
                  width: MediaQuery.of(context).size.width,
                ),


              ],
            ),
          ),


        ),
      );
    });
  }

  //login with google ..
  loginWithGoogle() async {
   FirebaseUser user = await _authService.googleSignIn();

   await AuthService.saveUserIdSharedPref(user.uid);
   await AuthService.saveUserNameSharedPref(user.displayName.toString());

   Navigator.pop(context);
   Navigator.pushReplacement(context, MaterialPageRoute(
     builder : (context) => MainScreen(),
   ));
  }
  //login with google..

  onPressedLoginButton() async{
      if(_formKey.currentState.validate()) {

        setState(() {
          clickedLogin = true;
        });

       dynamic returnedValue =  await _authService.signInUserWithEmailAndPassword(loginEmail.text,
           loginPassword.text);
       if(returnedValue.toString().contains("ERROR_USER_NOT_FOUND") ||
       returnedValue.toString().contains("ERROR_WRONG_PASSWORD")) {
         setState(() {
           passwordEmailNotFound = true;
         });
         Navigator.pop(context);
         return;
       }

       String userName = "";

      await Firestore.instance.collection("Users").document(returnedValue.toString()).get().then((value){
         userName =  value.data['name'].toString();
      });

        await AuthService.saveUserIdSharedPref(returnedValue.toString());
        await AuthService.saveUserNameSharedPref(userName);

       setState(() {
         passwordEmailNotFound = false;
       });

       Navigator.pop(context);
       Navigator.pushReplacement(context, MaterialPageRoute(
         builder : (context) => MainScreen(),
       ));


      }
      else{
        setState(() {
          clickedLogin  = false;
        });
      }
  }

  void _onClickSignUp() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.only(left: 30,right: 30,top: 20,bottom: 10),
        height: MediaQuery.of(context).size.height*0.60,
        width: double.infinity,

        //sign up form..
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameTextEditingController,
                validator: (value) {
                  if(value.isEmpty) {
                    return "Field cannot be empty";
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: "Name"
                ),
              ),


              SizedBox(height: 20,),

              TextFormField(
                controller: emailTextEditingController,
                validator: (value) {
                  if(value.isEmpty) {
                    return "Field cannot be empty";
                  }
                  else  if(!RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$").hasMatch(value)) {
                    return "Invalid Email";
                  }
                  return null;
                },
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: "Email"
                ),
              ),


              SizedBox(height: 20,),

              TextFormField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: showPassword == false ? true : false,
                validator: (value) {
                  if(value.isEmpty) {
                    return "Field cannot be empty";
                  }
                  else if(value.length < 8) {
                    return "Password must be of at least 8 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye),

                      //onpressed icon method
                      onPressed: () {
                        if(showPassword == true) {
                          setState(() {
                            showPassword = false;
                          });
                        }
                        else{
                          setState(() {
                            showPassword = true;
                          });
                        }
                      },

                    )

                ),
              ),

              SizedBox(height: 20,),



              clicked == false ? CustomButton(
                color: Colors.green,
                textColor: Colors.white,
                onClickMethod: (){
                  onPressedSignUpButton();

                },
                text: "Sign Up",
                width: MediaQuery.of(context).size.width,
              ) : CircularProgressIndicator(),

              SizedBox(height: 20,),

              CustomButton(
                color: Color(0xff2cb9b0),
                textColor: Colors.white,
                onClickMethod: (){
                  loginWithGoogle();
                },
                text: "Continue with Google",
                width: MediaQuery.of(context).size.width,
              ),

            ],
          ),
        ),


      );
    });
  }


  onPressedSignUpButton() async {

    if (_formKey.currentState.validate()) {

      setState(() {
        clicked = true;
      });

      dynamic userId = await _authService.registerWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
        name: nameTextEditingController.text,
      );

      await AuthService.saveUserIdSharedPref(userId.toString());
      await AuthService.saveUserNameSharedPref(nameTextEditingController.text);

        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => MainScreen(),
        ));

    }
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          child: Stack(
            children: [



              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/login_image.jpg'),
                ),
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      passwordEmailNotFound == true ?   Text("Email or Password not Found", style: TextStyle(
                        fontFamily: 'sf_pro_bold',
                        fontSize: 24,
                        color: Colors.red,
                      ),) : Container(),
                      forgotPasswordWarning!=null ?
                          Text(
                            forgotPasswordWarning  , style: TextStyle(color: Colors.red, fontSize: 16,
                            fontFamily: 'sf_pro_bold',
                            ),
                          ): Container(),


                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Discover New People",
                            style: TextStyle(
                                fontFamily: 'sf_pro_bold',
                                color: Colors.white,
                                fontSize: 32
                            ),
                          ),
                        ),
                      ),
                      CustomButton(
                        onClickMethod: () {
                          onClickLogin();
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        text: "Have account? Login",
                      ),

                      SizedBox(height: 10,),

                      CustomButton(
                        onClickMethod: () {
                          _onClickSignUp();
                        },
                        color: Colors.white,
                        textColor: Colors.black,
                        text: "Join us, its free",
                      ),


                      SizedBox(height: 30,)

                    ],
                  )
              )
            ],
          ),
        ),
      );
    }
  }
