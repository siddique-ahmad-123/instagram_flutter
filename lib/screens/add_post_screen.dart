import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/firestore_method.dart';
import 'package:instagram_flutter/utilitise/colors.dart';
import 'package:instagram_flutter/utilitise/utilis.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../provider/user_provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;

  final TextEditingController _descriptionController = TextEditingController();
   bool _isLoading = false;
  void postImage(
       String uid,
       String username,
       String profImage) async
       {

        setState(() {
          _isLoading=true;
        });

        try {
          String res = await FirestoreMethod().upLoadPost(
              _descriptionController.text,
              _file!, 
              uid,
              username, 
              profImage
              );

              if(res=="success"){
                 // ignore: use_build_context_synchronously
                  setState(() {
                   _isLoading=false;
                 });
                 ClearImage();
                 // ignore: use_build_context_synchronously
                 showSnackBar('posted',context);
              } else{
                // ignore: use_build_context_synchronously
                 setState(() {
                   _isLoading=false;
                 });
                // ignore: use_build_context_synchronously
                showSnackBar(res,context);
              }

        } catch(e) {
               showSnackBar(e.toString(), context);
        }
      
  }

  _selectImage(BuildContext context) async {
    return showDialog(context: context, builder: (context) {
      return SimpleDialog(
        title: const Text('create a post'),
        children: [
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text('Take Photo'),

            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.camera,);
             
             setState(() {
               _file=file;
             });

            },
          ),
           SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: Text('choose from gallery'),

            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.gallery,);
             
             setState(() {
               _file=file;
             });

            },
          ),
           SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text('Cancel'),

            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
  void ClearImage(){
    setState(() {
      _file=null;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<UserProvider>(context).getUser;



    return _file==null? Center(
      child: IconButton( 
        icon: const Icon(Icons.upload),
        onPressed: () => _selectImage(context),
        ) ,
    ): Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading:IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: ClearImage,
          ),
          title: const Text('post to'),
          centerTitle: false,
          actions: [
            TextButton(
              onPressed: () =>  postImage(user.uid, user.username, user.photoUrl),
              child: const Text(
                'post',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                ),
               
              ),
            
          ],
          
      ),
      body: Column(
        children: [
          _isLoading? const LinearProgressIndicator(): const Padding(padding: EdgeInsets.only(top: 0),),
         const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: MemoryImage(_file!),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'write captions...',
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487/451,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(_file!),
                         fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                        
                        ),
                    ) ,
                  ),
                  ) ,
              ),
              const Divider(),

            ],

          )
        ],
      ),
    );






  }
  
  void showSnackBar(String s, BuildContext context) {
    showSnackBar('posted',context);
  }
}