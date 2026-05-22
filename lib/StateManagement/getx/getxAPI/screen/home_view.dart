import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/post_controller.dart';

class HomeViewGet2 extends StatelessWidget {
  HomeViewGet2({super.key});
  final PostController controller = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GetX API Example"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: controller.postList.length,
          itemBuilder: (context, index) {
            final post = controller.postList[index];
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
                leading: CircleAvatar(
                  child: Text(post.id.toString()),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}