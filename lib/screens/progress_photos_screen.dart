import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:your_app/services/progress_photos_service.dart';
import 'package:your_app/widgets/photo_comparison_widget.dart';

class ProgressPhotosScreen extends StatefulWidget {
  @override
  _ProgressPhotosScreenState createState() => _ProgressPhotosScreenState();
}

class _ProgressPhotosScreenState extends State<ProgressPhotosScreen> {
  List<XFile> _photos = [];
  final ProgressPhotosService _progressPhotosService = ProgressPhotosService();

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    final photos = await _progressPhotosService.getPhotos();
    setState(() {
      _photos = photos;
    });
  }

  Future<void> _pickPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      await _progressPhotosService.addPhoto(photo);
      _loadPhotos();
    }
  }

  void _deletePhoto(int id) async {
    await _progressPhotosService.deletePhoto(id);
    _loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Photos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: _photos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => _deletePhoto(_photos[index].id),
                  child: Image.file(
                    File(_photos[index].path),
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _pickPhoto,
            child: Text('Upload Photo'),
          ),
          if (_photos.length >= 2)
            PhotoComparisonWidget(
              beforePhoto: _photos[_photos.length - 2],
              afterPhoto: _photos[_photos.length - 1],
            ),
        ],
      ),
    );
  }
}
