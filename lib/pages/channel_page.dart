import 'package:flutter/material.dart';
import 'package:flutter_codigo_youapp/ui/general/colors.dart';

import '../models/channel_model.dart';
import '../models/video_model.dart';
import '../services/api_service.dart';
import '../ui/widgets/item_video_channel_widget.dart';
import '../ui/widgets/item_video_widget.dart';

class ChannelPage extends StatefulWidget {
  String channelId;

  ChannelPage({
    required this.channelId,
  });

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final APIService _apiService = APIService();
  ChannelModel? channel;
  bool isLoading = true;
  bool isVideo = true;
  List<VideoModel> videos = [];

  getData() {
    _apiService.getChannel(widget.channelId).then((value) {
      channel = value;
      isLoading = false;
      setState(() {});
    });
  }

  getDataVideo() {
    _apiService.getChannelVideo(widget.channelId).then((value) {
      videos = value;
      isVideo = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    getData();
    getDataVideo();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: kBrandPrimaryColor,
            appBar: AppBar(
              backgroundColor: kBrandPrimaryColor,
              elevation: 0,
              title: Text(channel!.snippet.title),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.cast,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                  ),
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.white,
                indicatorWeight: 2.7,
                tabs: [
                  Tab(
                    child: Text(
                      "PÁGINAS PRINCIPAL",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "VIDEOS",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "LISTA DE REPRODUCCIÓN",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "COMUNIDAD",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "CANALES",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "MÁS INFORMACIÓN",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Center(
                    child: Column(children: [
                      Image.network(
                        channel!.brandingSettings.image!.bannerExternalUrl
                            .toString(),
                        height: 150.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CircleAvatar(
                        maxRadius: 30.0,
                        backgroundColor: Colors.white12,
                        backgroundImage: NetworkImage(
                            channel!.snippet.thumbnails.thumbnailsDefault.url),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        channel!.snippet.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SUSCRITO",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(Icons.notifications_none, color: Colors.white),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "3.15 M suscriptores - 88455 views",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      isVideo
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
                            )
                    ]),
                  ),
                ),
                Center(
                  child: isVideo
                      ? CircularProgressIndicator()
                      : Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: videos.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ItemVideoChannelWidget(
                                  videoModel: videos[index],
                                );
                              },
                            ),
                          ],
                        ),
                ),
                Center(
                  child: Text(
                    "Página 3",
                  ),
                ),
                Center(
                  child: Text(
                    "Página 4",
                  ),
                ),
                Center(
                  child: Text(
                    "Página 5",
                  ),
                ),
                Center(
                  child: Text(
                    "Página 6",
                  ),
                ),
              ],
            ),
          );
  }
}
