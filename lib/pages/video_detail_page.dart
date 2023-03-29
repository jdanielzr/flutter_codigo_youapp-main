import 'package:flutter/material.dart';
import 'package:flutter_codigo_youapp/pages/channel_page.dart';
import 'package:flutter_codigo_youapp/ui/general/colors.dart';
import 'package:flutter_codigo_youapp/ui/widgets/item_video_detail_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/video_model.dart';
import '../services/api_service.dart';
import '../ui/widgets/item_video_widget.dart';

class VideoDetailPage extends StatefulWidget {
  VideoModel videoModel;

  VideoDetailPage({
    required this.videoModel,
  });

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late YoutubePlayerController _playerController;
  final APIService _apiService = APIService();
  List<VideoModel> videos = [];
  bool isLoading = true;
  getData() {
    _apiService.getRelatedToVideo(widget.videoModel.id.videoId).then((value) {
      videos = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _playerController = YoutubePlayerController(
      initialVideoId: widget.videoModel.id.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        hideControls: false,
      ),
    );
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      body: Column(
        children: [
          SizedBox(
            height: height * 0.35,
            child: YoutubePlayer(
              controller: _playerController,
              progressColors: ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.red,
                bufferedColor: Colors.white54,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          ListTile(
            title: Text(
              widget.videoModel.snippet.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(height: 1.3, color: Colors.white, fontSize: 14.0),
            ),
            subtitle: Text(
              "6.5 M de vistas · hace 2 años",
              style: TextStyle(color: Colors.white54, fontSize: 13.0),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ItemVideoDetailWidget(
                            text: "53 K",
                            icon: Icons.thumb_up_alt_outlined,
                          ),
                          ItemVideoDetailWidget(
                            text: "No me gusta",
                            icon: Icons.thumb_down_alt_outlined,
                          ),
                          ItemVideoDetailWidget(
                            text: "Compartir",
                            icon: Icons.share,
                          ),
                          ItemVideoDetailWidget(
                            text: "Crear",
                            icon: Icons.play_arrow_rounded,
                          ),
                          ItemVideoDetailWidget(
                            text: "Descargar",
                            icon: Icons.download_rounded,
                          ),
                          ItemVideoDetailWidget(
                            text: "Compartir",
                            icon: Icons.share,
                          ),
                          ItemVideoDetailWidget(
                            text: "Crear",
                            icon: Icons.play_arrow_rounded,
                          ),
                          ItemVideoDetailWidget(
                            text: "Descargar",
                            icon: Icons.download_rounded,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.white24,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChannelPage(
                              channelId: widget.videoModel.snippet.channelId),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      backgroundImage: NetworkImage(
                          widget.videoModel.snippet.channelImg.toString()),
                    ),
                    title: Text(
                      widget.videoModel.snippet.channelTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                    subtitle: Text(
                      "1.43 M de suscriptores",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12.0,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "SUSCRITO",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Icon(
                          Icons.notifications_none,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white24,
                  ),
                  isLoading
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: videos.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemVideoWidget(
                              videoModel: videos[index],
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
