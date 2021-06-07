import 'dart:io';
import 'package:flutter/material.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import '../theme.dart';

class BouncingButton extends StatefulWidget {
  @override
  _BouncingButtonState createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  late String dirPath;
  Directory? rootPath;
  final bool isDesktop = !(Platform.isAndroid || Platform.isIOS);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
    _prepareStorage();
  }

  Future<void> _prepareStorage() async {
    rootPath = Directory(path.dirname('/'));
    setState(() {});
  }

  Future<void> _pickDir(BuildContext context) async {
    String? path = await FilesystemPicker.open(
      title: 'Open resource folder',
      context: context,
      rootDirectory: rootPath!,
      fsType: FilesystemType.folder,
      pickText: 'Select this directory',
      folderIconColor: Colors.teal,
      requestPermission: !isDesktop
          ? () async => await Permission.storage.request().isGranted
          : null,
    );

    setState(() {
      dirPath = path;
      print(dirPath);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTapDown: _tapDown,
          onTapUp: _tapUp,
          child: Transform.scale(
            scale: _scale,
            child: _animatedButton(),
          ),
        ),
      ),
    );
  }

  Widget _animatedButton() {
    return Container(
      height: 70,
      width: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Color(0x80000000),
            blurRadius: 12.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
        color: selectedColor,
      ),
      child: Center(
        child: MediaQuery.of(context).size.width > 540
            ? Text(
                'Add new file',
                style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                    color: Colors.black),
              )
            : Icon(
                Icons.add,
                size: 32.0,
              ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
    _pickDir(context); //open dir picker
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
