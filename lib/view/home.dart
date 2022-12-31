
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/page_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeController pageController = Get.put(HomeController());
  // @override
  // State<HomePage> createState() => _HomePageState();
// }
// class _HomePageState extends State<HomePage> {
  // We will fetch data from this Rest api
  // final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('pagination Demo'),
      ),
      body: Obx(()=>
      pageController.isFirstLoadRunning.isTrue
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: pageController.controller,
              itemCount: pageController.posts.length,
              itemBuilder: (_, index) => Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 8, horizontal: 10),
                child: ListTile(
                  title: Text( pageController.posts[index]['title']),
                  subtitle: Text( pageController.posts[index]['body']),
                ),
              ),
            ),
          ),

          pageController.isLoadMoreRunning.isTrue?
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 40),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ):const SizedBox(),

          if (pageController.hasNextPage.isFalse)
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 40),
              color: Colors.amber,
              child: const Center(
                child: Text('You have fetched all of the content'),
              ),
            ),
        ],
      ),
      ),
    );
  }
}