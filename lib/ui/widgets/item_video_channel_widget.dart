import 'package:flutter/material.dart';
import 'package:flutter_codigo_youapp/models/channel_model.dart';
import 'package:flutter_codigo_youapp/models/video_model.dart';
import 'package:flutter_codigo_youapp/pages/video_detail_page.dart';

class ItemVideoChannelWidget extends StatelessWidget {
  VideoModel videoModel;

  ItemVideoChannelWidget({super.key, required this.videoModel});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoDetailPage(
              videoModel: videoModel,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 80,
                    margin: EdgeInsets.only(left: 16.0, top: 16.0),
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                videoModel.snippet.thumbnails.high.url)),
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Text("xxx"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      color: Colors.black.withOpacity(0.7),
                      child: Text(
                        "23:22",
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      videoModel.snippet.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      " 6.5 M de vistas · hace 2 años",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4.0),
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
