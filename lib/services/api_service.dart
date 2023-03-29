import 'dart:convert';

import 'package:flutter_codigo_youapp/models/video_model.dart';
import 'package:flutter_codigo_youapp/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../models/channel_model.dart';

class APIService {
  Future<List<VideoModel>> getVideos() async {
    List<VideoModel> videosModel = [];
    String _path =
        "$pathProduction/search?part=snippet&key=$apiKey&maxResults=10&regionCode=PE";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      List videos = myMap["items"];
      videosModel = videos.map((e) => VideoModel.fromJson(e)).toList();

      for (int i = 0; i < videosModel.length; i++) {
        print(videosModel[i].id.videoId);

        await getChannel(videosModel[i].snippet.channelId.toString())
            .then((value) {
          videosModel[i].snippet.channelImg =
              value.snippet.thumbnails.thumbnailsDefault.url.toString();
        });
      }

      return videosModel;
    }
    return videosModel;
  }

  Future<List<VideoModel>> getRelatedToVideo(String id) async {
    List<VideoModel> videosModel = [];
    String _path =
        "$pathProduction/search?type=video&part=snippet&key=$apiKey&relatedToVideoId=$id";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      List videos = myMap["items"];
      videosModel = videos.map((e) => VideoModel.fromJson(e)).toList();

      for (int i = 0; i < videosModel.length; i++) {
        print(videosModel[i].id.videoId);

        await getChannel(videosModel[i].snippet.channelId.toString())
            .then((value) {
          videosModel[i].snippet.channelImg =
              value.snippet.thumbnails.thumbnailsDefault.url.toString();
        });
      }

      return videosModel;
    }
    return videosModel;
  }

  Future<ChannelModel> getChannel(String id) async {
    List<ChannelModel> channelsModel = [];

    String _path =
        "$pathProduction/channels?part=snippet%2CcontentDetails%2CbrandingSettings&id=$id&key=$apiKey";

    Uri _uri = Uri.parse(_path);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);

      List channels = myMap["items"];
      channelsModel = channels.map((e) => ChannelModel.fromJson(e)).toList();
      return channelsModel.first;
    }
    return channelsModel.first;
  }

  Future<List<VideoModel>> getChannelVideo(String id) async {
    List<VideoModel> videosModel = [];
    String _path =
        "$pathProduction/search?type=video&part=snippet&key=$apiKey&channelId=$id";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      List videos = myMap["items"];
      videosModel = videos.map((e) => VideoModel.fromJson(e)).toList();

      for (int i = 0; i < videosModel.length; i++) {
        print(videosModel[i].id.videoId);

        await getChannel(videosModel[i].snippet.channelId.toString())
            .then((value) {
          videosModel[i].snippet.channelImg =
              value.snippet.thumbnails.thumbnailsDefault.url.toString();
        });
      }

      return videosModel;
    }
    return videosModel;
  }
}
