
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profImage;
  final Likes;

  const Post
  ({
    
  required this.username,
  required this.uid,
  required this.postUrl,
  required this.postId,
  required this.description,
  required this.datePublished,
  required this.profImage, 
  required this.Likes,
    
});

Map<String,dynamic> toJson() => {
       'username':username,
       'uid': uid,
       'postId':postId,
       'description':description,
       'Likes':Likes,
       'datePublished':datePublished,
       'postUrl' : postUrl,
       'profImage':profImage,
       
};


static Post fromSnap(DocumentSnapshot snap) {
   
   var snapshot = snap.data() as Map< String , dynamic>;
      return Post(

 username: snapshot['username'],
 uid: snapshot['uid'],
 postUrl: snapshot['postUrl'],
 datePublished: snapshot['datePublished'],
 description: snapshot['description'],
 profImage: snapshot['profImage'],
 Likes: snapshot ['Likes'],
 postId: snapshot['postId'],
   );

}

} 