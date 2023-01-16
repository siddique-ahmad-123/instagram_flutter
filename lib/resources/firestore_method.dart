
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';
import 'package:instagram_flutter/models/post.dart';

class FirestoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //upload Post:

  Future<String> upLoadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async{
      String res ="Some Error Occured";
      try {
      // ignore: non_constant_identifier_names
      String PhotoUrl = await StorageMethods().uploadImageToStorage('Post', file, true);
        String postId = const Uuid().v1();
        Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId:postId,
          datePublished: DateTime.now(),
          postUrl: PhotoUrl,
          profImage: profImage,
          Likes: [],
        );
        _firestore.collection('posts').doc(postId).set(post.toJson(),);
        res="success";
      } catch(err){
          res=res.toString();
      }
      return res;
  }

  Future<void> LikePost(String postId, String uid, List Likes) async {
    try{
      if(Likes.contains(uid)){
       await  _firestore.collection('posts').doc(postId).update({
            'Likes' : FieldValue.arrayRemove([uid]),
        });
      } else {
        await  _firestore.collection('posts').doc(postId).update({
            'Likes' : FieldValue.arrayUnion([uid]),
      });
      
    }

    }catch(e){
      print(e.toString(),);
    }
  }

  Future<String>postComment(String postId, String text, String uid, String name, String profilePic) async {
    String res = "Some error occurred";
    try{
      if(text.isNotEmpty){
        String commentId = const Uuid().v1();
       await  _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
          'profilePic': profilePic,
          'name':name,
          'uid':uid,
          'text':text,
          'commentId':commentId,
          'datePublished': DateTime.now(),

        });
         res = 'success';
      }
      else {
        res= "please enter text";
      }
    }catch(err){
     res= err.toString();
    }
    return res;
  }

  //deleting the post:

  Future<void>deletePost(String postId) async {
    try {
     await  _firestore.collection('posts').doc(postId).delete();

    }catch(e){
      print(e.toString());
    }

  }
}