import 'package:cloudquizzer/core/models/bookmark.dart';
import 'package:cloudquizzer/features/bookmark/screen/widget/bookmark_screen_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/show_back_alert_dialog.dart';
import '../../manager/bookmark_cubit.dart';

class BookmarkScreenBody extends StatefulWidget {
  const BookmarkScreenBody({super.key, required this.bookmarks});
  final List<Bookmark> bookmarks;
  @override
  State<BookmarkScreenBody> createState() => _BookmarkScreenBodyState();
}

class _BookmarkScreenBodyState extends State<BookmarkScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "Saved Questions",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: widget.bookmarks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [],
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "question: ${widget.bookmarks[index].questionText}",
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "answer: ${widget.bookmarks[index].answer}",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        InkWell(
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                            onTap: () async {
                                                deleteScore(index);
                                            }),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      }),
                ))
          ],
        ),
      ),
    );
  }

  void deleteScore(int index) async {
    final bookmarkToDelete = widget.bookmarks[index];
    await bookmarkToDelete.delete();

    setState(() {
      widget.bookmarks.removeAt(index);
    });
  }
}





