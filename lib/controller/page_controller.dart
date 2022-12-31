import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  int page = 0;
  final int limit = 10;
  RxBool hasNextPage = true.obs;
  RxBool isFirstLoadRunning = false.obs;
  RxBool isLoadMoreRunning = false.obs;
  RxList posts = [].obs;
  final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  late ScrollController controller;


  @override
  void onInit() {
    firstLoad();
    controller = ScrollController()..addListener(loadMore);
    super.onInit();
  }

  @override
  void dispose() {
    controller.removeListener(loadMore);
    super.dispose();
  }
  void firstLoad() async {
      isFirstLoadRunning.value = true;
    try {
      final res =
      await http.get(Uri.parse("$_baseUrl?_page=$page&_limit=$limit"));
        posts.value = json.decode(res.body);
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }
      isFirstLoadRunning.value = false;
  }

  void loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        controller.position.extentAfter < 300) {

        isLoadMoreRunning.value = true;

      page += 1;
      try {
        final res =
        await http.get(Uri.parse("$_baseUrl?_page=$page&_limit=$limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
            posts.addAll(fetchedPosts);
        } else {
          hasNextPage.value = false;
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }
        isLoadMoreRunning.value = false;
    }
  }
}
