import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter/material.dart';
import 'bouncing_button.dart';

class ThreeDView extends StatefulWidget {
  const ThreeDView({Key? key}) : super(key: key);

  @override
  _ThreeDViewState createState() => _ThreeDViewState();
}

class _ThreeDViewState extends State<ThreeDView> {
  late Object material;
  @override
  initState() {
    // assigning name to the objects and providing the
    // object's file path (obj file)
    material = Object(
        scale: Vector3(2.0, 2.0, 2.0),
        lighting: true,
        fileName: 'assets/fileobj/12221_Cat_v1_l3.obj');
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
                if (filePath != null) updateProfile();
                scene.light.position.setFrom(Vector3(0, 5, 5));
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

  void updateProfile() {
    if (filePath != null)
      setState(() => this.material = Object(
            scale: Vector3(5.0, 5.0, 5.0),
            lighting: true,
            fileName: filePath.toString())
      );
  }
}
