import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:word_toob/common/app_constants/general.dart';
import 'package:word_toob/views/theme/app_color.dart';


class ImageUploadWidget extends StatefulWidget {
  final File image;
  final VoidCallback onTap;
  final VoidCallback onTapRemove;
  final Color color;
  final double edgeInsetsGeometry;



  const ImageUploadWidget({super.key, required this.image, required this.onTap, required this.onTapRemove, required this.color, required this.edgeInsetsGeometry});

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.transparent,
          ),
          child: Stack(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.borderColor3.withOpacity(0.7)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.file(
                    widget.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: widget.onTapRemove,
                  child: Container(
                    height: 30,
                    width: 30,
                    color: Colors.transparent,
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: const Center(
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 15,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoUploadWidget extends StatefulWidget {
  final String video;
  final VoidCallback onTap;
  final VoidCallback onTapRemove;
  final bool isEditPressed ;



  const VideoUploadWidget({super.key, required this.video, required this.onTap, required this.onTapRemove, required this.isEditPressed});

  @override
  State<VideoUploadWidget> createState() => _VideoUploadWidgetState();
}

class _VideoUploadWidgetState extends State<VideoUploadWidget> {
  String? generatedFile;
  bool isLoading = true;
  setLoading(bool loading){
    setState(() {
      isLoading = loading;
    });
  }

  generateThumbnail() async {
    Directory dir = await getApplicationCacheDirectory();
    final fileName = await VideoThumbnail.thumbnailFile(
      video: widget.video,
      thumbnailPath: dir.path,
      imageFormat: ImageFormat.PNG,
      maxHeight: 20,
      // maxWidth: 80,
      quality: 100,
    );
    printLog(fileName);
    if(fileName != null){
      setState(() {
        generatedFile = fileName;
      });
    }
    printLog(generatedFile);
    setLoading(false);
  }

  @override
  void initState() {
    generateThumbnail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: context.height*0.14,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.transparent,
          ),
          child: Row(
            children: [
            widget.isEditPressed?  GestureDetector(
                onTap: widget.onTapRemove,
                child: Container(
                  margin: EdgeInsets.all(5),
                  height: 30,
                  width: 30,
                  color: Colors.transparent,
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: const Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 15,
                        )),
                  ),
                ),
              ):Container(),

              Expanded(
                child: Container(
                  height: context.height*0.4,
                
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.borderColor3.withOpacity(0.7)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: isLoading ? Center(
                    child: const Padding(
                      padding: EdgeInsets.all(25.0),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ) :
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.file(
                      File(generatedFile!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({super.key, required this.url});
  final String url;

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}
class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.asset(widget.url,
        videoPlayerOptions: VideoPlayerOptions(

        ))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(

                    _controller),
              )
                  : const CircularProgressIndicator(),
            ),
            IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: Container(

                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey[300]!.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(200)
                ),
                child: Icon(Icons.arrow_back,
                    size: 10,
                    color: Theme.of(context).inputDecorationTheme.iconColor),
              ),
            ),
            // Center(
            //   child: IconButton(
            //     onPressed: (){
            //       Navigator.of(context).pop();
            //     },
            //     icon: Container(
            //
            //       padding: const EdgeInsets.all(5),
            //       decoration: BoxDecoration(
            //           color: Colors.grey[300]!,
            //           borderRadius: BorderRadius.circular(200)
            //       ),
            //       child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            //           size: 20,
            //           color: Theme.of(context).inputDecorationTheme.iconColor),
            //     ),
            //   ),
            // ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

class FileUploadWidget extends StatefulWidget {
  final File file;
  final VoidCallback onTapRemove;



  const FileUploadWidget({super.key, required this.file, required this.onTapRemove});

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.transparent,
        ),
        child: Stack(
          children: [
            Container(
              height: 80,
              width: 80,
              /*decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(5),
              ),*/
              child: Column(
                children: [
                  Expanded(
                    child: Container(

                      decoration: BoxDecoration(
                        // image: DecorationImage( image: AssetImage(ImageString.uploadFile)),
                        color: AppColor.appPrimaryColor,
                        border: Border.all(color: AppColor.appPrimaryColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.file.path.split(".").last}",
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: AppColor.white,
                                fontSize: 14
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(3),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${widget.file.path.split("/").last}",
                            maxLines: 2,
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontSize: 9
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: widget.onTapRemove,
                child: Container(
                  height: 30,
                  width: 30,
                  color: Colors.transparent,
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: const Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 15,
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}