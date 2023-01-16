import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
import 'package:instagram_flutter/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User>getUserDetail() async{
  
  User currentUser = _auth.currentUser!;
  DocumentSnapshot snap = await _firestore.collection('user').doc(currentUser.uid).get();

  return model.User.fromSnap(snap);

  }
//signup user
Future<String> SignUpUser({
  required String username,
  required String password,
  required String email,
  required String bio,
  required Uint8List file,

}) async {
  String res = "Some error occured";
  try{
    if(username.isNotEmpty || password.isNotEmpty || email.isNotEmpty || bio.isNotEmpty){
      //register user:
    UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    print(cred.user!.uid);

   String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);
      //add user to database:
      model.User user = model.User(
       username:username,
       uid: cred.user!.uid,
       email: email,
       bio: bio,
       followers:[],
       following:[],
       photoUrl : photoUrl,
      );
      
    await _firestore.collection('user').doc(cred.user!.uid).set(user.toJson(),);

    //same as before:
   /* await _firestore.collection('user').add({
         'username':username,
       'uid': cred.user!.uid,
       'email': email,
       'bio': bio,
       'followers':[],
       'following':[],
    });*/


    res='success';
    }

  } 
  on FirebaseAuthException catch(err){
     if(err.code == 'invalid-mail'){
      res='email is badly formatted.';
     }
  }
  
  catch(err){
  res=err.toString();
  }
  return res;

}

//Loging i user:

Future<String> loginUser({

  required String email,
  required String password,

}) async{

  String res = "Some error occured";
  try
  {
    if(email.isNotEmpty || password.isNotEmpty){
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    }
    else
    {
      res ='please enter all the field';
    }
  }
  on FirebaseAuthException catch(e){
     if(e.code == 'user-not-found'){
      res='email is badly formatted.';
     }
  }
  catch(err){
    res=err.toString();
    
  }
  return res;

}






}