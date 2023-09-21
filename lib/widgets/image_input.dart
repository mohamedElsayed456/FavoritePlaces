import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key,required this.onPickImage});

  final Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  File? selectedImage;
  void takePicture()async{
   final imagepicker=ImagePicker();
   final pickedImage = await imagepicker.pickImage(source: ImageSource.camera,maxWidth: 600);

   if(pickedImage==null){
    return;
   }
   setState(() {
     selectedImage=File(pickedImage.path);
   });
   widget.onPickImage(selectedImage!);
  }

  @override
  Widget build(BuildContext context){

    Widget content = TextButton.icon(
        onPressed:takePicture,
        icon:const Icon(Icons.camera),
         label:const Text('Take Picture'),
         );

         if(selectedImage!=null){
          content = GestureDetector(
            onTap: takePicture,
            child: Image.file(
              selectedImage!,
              fit:BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              ),
          );
          }
     return Container(
       height: 200,
       width: double.infinity,
       decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
       ),
       child:content,

    );
  }
}