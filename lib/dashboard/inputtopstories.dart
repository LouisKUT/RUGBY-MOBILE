import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugby_mobile/homepage/firestore/Topstoriesprovider.dart';
import 'package:rugby_mobile/homepage/firestore/Topstorymodel.dart';
import 'package:rugby_mobile/homepage/firestore/firestore_service.dart';
import 'package:file_picker/file_picker.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  FilePickerResult? result;
  late PlatformFile file;
  
  
  late final storyprovider = Provider.of<storyProvider>(context,listen: false);
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _authorController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();

  final TextEditingController _urlToImageController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  selectFiles() async {
  result = (await FilePicker.platform.pickFiles(
        withReadStream: true, allowMultiple: true, type: FileType.image))!;
              if(result == null){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('no image has been selected')));
                
              }
              
     file = result!.files.first ;
     final path = result!.files.single.path!;
    final fileName = result!.files.single.name;
    
    // ignore: use_build_context_synchronously
    uploadfile(path,fileName);
    
    // loadselectedfiles(result!.files);
    // setState(() {
      
    // });

}

 Future<void> uploadfile( String filepath, String fileName) async {
    File file = File(filepath);

    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      UploadTask uploadTask =
          storage.ref('TopStories/$fileName').putFile(file) as UploadTask;
      String url = await (await uploadTask).ref.getDownloadURL();

      storyprovider.changestoryurlToImage(url);
      

      print(url);
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            // TextField(
            //   controller: _urlToImageController,
            //   decoration: InputDecoration(labelText: 'URL to Image'),
            // ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
              TextButton(
          onPressed: (){

    selectFiles();

          },
           child: Text('upload News Picture'),
           
           ),
            SizedBox(height: 16.0),
            ElevatedButton(
                           
              onPressed: () {
                storyprovider.changestorytitle(_titleController.text);
                storyprovider.changestoryauthor(_authorController.text);
              storyprovider.changestorycontent(_contentController.text);
              
              storyprovider.changestorydate(_dateController.text);
              storyprovider.savestories();
              },
              child: Text('post'),
            ),
          ],
        ),
      ),
    );
  }
}
