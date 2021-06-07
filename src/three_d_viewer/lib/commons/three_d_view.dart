import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter/material.dart';

class ThreeDView extends StatefulWidget {
  const ThreeDView({Key? key}) : super(key: key);

  @override
  _ThreeDViewState createState() => _ThreeDViewState();
}

class _ThreeDViewState extends State<ThreeDView> {
  late Object material;

  void initState() {
    // assigning name to the objects and providing the
    // object's file path (obj file)
    material = Object(fileName: "fileobj/12221_Cat_v1_l3.obj");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(56, 0, 0, 0),
      child: Container(
          child: Column(
        children: [
          Expanded(
            child: Cube(
              onSceneCreated: (Scene scene) {
                scene.world.add(material);
                scene.camera.zoom =
                    MediaQuery.of(context).size.width > 540 ? 10 : 5;
              },
            ),
          ),
        ],
      )),
    );
  }
}
