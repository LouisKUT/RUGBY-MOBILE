import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class VideoDashboard extends StatefulWidget {
  @override
  _VideoDashboardState createState() => _VideoDashboardState();
}

class _VideoDashboardState extends State<VideoDashboard> {
  File? _pickedVideo;
  String? _videoUrl;
  File? _pickedImage;
  String? _imageUrl;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _lengthController = TextEditingController();

  void _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _pickedVideo = File(result.files.first.path!);
      });
    }
  }

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  Future<void> _uploadVideoAndImage() async {
    if (_pickedVideo != null && _pickedImage != null) {
      try {
        // Upload video to Firebase Storage
        final Reference videoStorageReference =
            FirebaseStorage.instance.ref().child('videos/${DateTime.now().millisecondsSinceEpoch}.mp4');
        final UploadTask videoUploadTask = videoStorageReference.putFile(_pickedVideo!);
        final TaskSnapshot videoSnapshot = await videoUploadTask;
        final String videoDownloadUrl = await videoSnapshot.ref.getDownloadURL();

        // Upload image to Firebase Storage
        final Reference imageStorageReference =
            FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
        final UploadTask imageUploadTask = imageStorageReference.putFile(_pickedImage!);
        final TaskSnapshot imageSnapshot = await imageUploadTask;
        final String imageDownloadUrl = await imageSnapshot.ref.getDownloadURL();

        setState(() {
          _videoUrl = videoDownloadUrl;
          _imageUrl = imageDownloadUrl;
        });

        // Save video details to Firestore
        final String title = _titleController.text;
        final String length = _lengthController.text;

        await FirebaseFirestore.instance.collection('videos').add({
          'title': title,
          'length': length,
          'url': videoDownloadUrl,
          'thumbnail': imageDownloadUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Video and Image uploaded successfully')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload video and image: $error')),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _lengthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Dashboard'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _lengthController,
              decoration: InputDecoration(
                labelText: 'Length',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text('Pick Video'),
            ),
            SizedBox(height: 16.0),
            if (_pickedVideo != null)
              Text('Video Selected: ${_pickedVideo!.path}'),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 16.0),
            if (_pickedImage != null)
              Text('Image Selected: ${_pickedImage!.path}'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _uploadVideoAndImage,
              child: Text('Upload Video and Image'),
            ),
            SizedBox(height: 16.0),
            if (_videoUrl != null)
              Text('Video URL: $_videoUrl'),
            SizedBox(height: 16.0),
            if (_imageUrl != null)
              Text('Image URL: $_imageUrl'),
          ],
        ),
      ),
    );
  }
}





// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class VideoDashboard extends StatefulWidget {
//   @override
//   _VideoDashboardState createState() => _VideoDashboardState();
// }

// class _VideoDashboardState extends State<VideoDashboard> {
//   File? _pickedVideo;
//   String? _videoUrl;
//   TextEditingController _titleController = TextEditingController();
//   TextEditingController _lengthController = TextEditingController();

//   void _pickVideo() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.video,
//     );

//     if (result != null && result.files.isNotEmpty) {
//       setState(() {
//         _pickedVideo = File(result.files.first.path!);
//       });
//     }
//   }

//   Future<void> _uploadVideo() async {
//     if (_pickedVideo != null) {
//       try {
//         final Reference storageReference =
//             FirebaseStorage.instance.ref().child('videos/${DateTime.now().millisecondsSinceEpoch}.mp4');
//         final UploadTask uploadTask = storageReference.putFile(_pickedVideo!);
//         final TaskSnapshot snapshot = await uploadTask;
//         final String downloadUrl = await snapshot.ref.getDownloadURL();

//         setState(() {
//           _videoUrl = downloadUrl;
//         });

//         // Save video details to Firestore
//         final String title = _titleController.text;
//         final String length = _lengthController.text;

//         await FirebaseFirestore.instance.collection('videos').add({
//           'title': title,
//           'length': length,
//           'url': downloadUrl,
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Video uploaded successfully')),
//         );
//       } catch (error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to upload video: $error')),
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _lengthController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Dashboard'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(
//                 labelText: 'Title',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _lengthController,
//               decoration: InputDecoration(
//                 labelText: 'Length',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _pickVideo,
//               child: Text('Pick Video'),
//             ),
//             SizedBox(height: 16.0),
//             if (_pickedVideo != null)
//               Text('Video Selected: ${_pickedVideo!.path}'),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _uploadVideo,
//               child: Text('Upload Video'),
//             ),
//             SizedBox(height: 16.0),
//             if (_videoUrl != null)
//               Text('Video URL: $_videoUrl'),
//           ],
//         ),
//       ),
//     );
//   }
// }


