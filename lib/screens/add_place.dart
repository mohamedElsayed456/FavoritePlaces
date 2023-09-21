import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPLaceScreen extends ConsumerStatefulWidget {
  const AddPLaceScreen({super.key});

  @override
  ConsumerState<AddPLaceScreen> createState() => _AddPLaceScreenState();
}

class _AddPLaceScreenState extends ConsumerState<AddPLaceScreen> {

final titleController = TextEditingController();
File? _selectedImage;
PlaceLocation? _selectedlocation;

void savePlace(){
  final enteredtitle = titleController.text;
  if(enteredtitle.isEmpty || _selectedImage==null || _selectedlocation==null){
    return;
  }
  ref.read(userPlacesProvider.notifier).addPlace(
    enteredtitle,_selectedImage!,
    _selectedlocation!,
   );

  Navigator.of(context).pop();
}

@override
  void dispose(){
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Add new place'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration:const InputDecoration(
                  labelText: 'Title',
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                controller: titleController,
              ),
              const SizedBox(height: 16,),
                ImageInput(
                 onPickImage:(image) { 
                  _selectedImage = image;
                },
              ),
              const SizedBox(height: 16,),
              LocationInput(
                onselectlocation:(location){
                  _selectedlocation=location;
                } ,
               ),
               ElevatedButton.icon(
                 onPressed:savePlace,
                icon:const Icon(Icons.add),
                 label: const Text('Add place'),
               ),
            ],
          ),
        ),
      ),
    );
  }
}