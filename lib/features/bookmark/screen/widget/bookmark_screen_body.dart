import 'package:cloudquizzer/core/models/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/color_manager.dart';
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
        color: ColorManager.black,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "Saved Questions",
              style: TextStyle(
                  color: ColorManager.white,
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
                              color: ColorManager.cultured),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.bookmarks[index].questionText,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Answer :',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.green),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            widget.bookmarks[index].answer
                                                .substring(2),
                                          ),
                                        ),
                                      ],
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
                                          color: ColorManager.red,
                                        ),
                                        onTap: () async {
                                          context.read<BookmarkCubit>().deleteBookmark(widget.bookmarks[index]);
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


}
