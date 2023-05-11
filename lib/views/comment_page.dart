import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/news.dart';
import '../service/cmt_provider.dart';

class CommentPage extends ConsumerWidget {
  const CommentPage(this.news, {super.key});
  final News news;

  @override
  Widget build(BuildContext context, ref) {
    final cmtdata = ref.watch(commentprov);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        backgroundColor: const Color.fromRGBO(255, 127, 80, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            Text(
              news.title!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(news.url!),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('+ ${news.score}'),
                const SizedBox(
                  width: 15,
                ),
                Text('${news.kids!.length} comments'),
                const SizedBox(
                  width: 10,
                ),
                Text('by : ${news.by}'),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Comment Section",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: cmtdata.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(
                        cmtdata[index].by == null
                            ? "User"
                            : cmtdata[index].by!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          cmtdata[index].text == null
                              ? 'No comments'
                              : cmtdata[index].text!,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
