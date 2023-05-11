import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hackernews/service/story_service.dart';
import 'package:hackernews/views/comment_page.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../service/cmt_provider.dart';
import 'drawer_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  launchurl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Error showing the news';
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    FlutterNativeSplash.remove();
    final data = ref.watch(storyprovider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.search),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.replay),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
          ],
          title: const Text(
            "Hews",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: const Color.fromRGBO(255, 127, 80, 1),
        ),
        drawer: const DrawerPage(),
        body: data.when(
            data: (data) {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    int timeInSeconds = data[index].time!;

                    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                        timeInSeconds * 1000);

                    String formattedDateTime = DateFormat.H().format(dateTime);

                    return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Card(
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final Uri url = Uri.parse(data[index].url!);
                                  launchUrl(url);
                                },
                                child: SizedBox(
                                  height: 100,
                                  width: 320,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('by ${data[index].by!}'),
                                        Text(
                                          data[index].title!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text('$formattedDateTime hours ago'),
                                      ]),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          await ref
                                              .read(commentprov.notifier)
                                              .getcomments(
                                                  kids: data[index].kids);

                                          Get.to(() => CommentPage(data[index]),
                                              transition: Transition.downToUp);
                                        },
                                        icon: const Icon(Icons.comment),
                                        iconSize: 30,
                                        color: Colors.black38,
                                      ),
                                      Text(data[index].kids?.length == null
                                          ? "0"
                                          : data[index].kids!.length.toString())
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  });
            },
            error: (error, _) {
              return Text(error.toString());
            },
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )),
      ),
    );
  }
}
