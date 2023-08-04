// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/routes.dart';

class ZoomableImage extends StatelessWidget {
  const ZoomableImage({super.key, required this.imageUrl, required this.index});
  final int index;

  final dynamic imageUrl;
  // final String imageUrl;

  // const ZoomableImage({super.key, required this.imageUrl});
  // const ZoomableImage({
  //   Key? key,
  //   required this.imageUrl,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // leading: BackButton(),
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
          // color: Colors.red,
          child: Hero(
            tag: 'itemm_$index', // Use the same unique tag as in the GridView.builder

            child: PhotoView(
              imageProvider: NetworkImage(
                'http://${MyRoutes.ip}/Capstone/manager_panel_3/$imageUrl',
                // 'http://${MyRoutes.ip}/Capstone/manager_panel_3/${imageUrl["image"]}',
              ),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
              initialScale: PhotoViewComputedScale.contained,
              loadingBuilder: (context, event) => const Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
