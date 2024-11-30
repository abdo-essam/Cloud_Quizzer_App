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
  static const double _verticalSpacing = 10.0;
  static const double _horizontalPadding = 15.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorManager.black,
        child: Column(
          children: [
            const SizedBox(height: 50),
            _buildHeader(),
            Expanded(child: _buildBookmarkList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      "Saved Questions",
      style: TextStyle(
        color: ColorManager.white,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    );
  }

  Widget _buildBookmarkList() {
    if (widget.bookmarks.isEmpty) {
      return Center(
        child: Text(
          "No saved questions yet.",
          style: TextStyle(color: ColorManager.white, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding, vertical: _verticalSpacing),
      itemCount: widget.bookmarks.length,
      itemBuilder: (context, index) {
        final bookmark = widget.bookmarks[index];
        return _buildBookmarkItem(bookmark);
      },
    );
  }

  Widget _buildBookmarkItem(Bookmark bookmark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _verticalSpacing),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorManager.cultured,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 15,
              child: _buildBookmarkContent(bookmark),
            ),
            _buildDeleteButton(bookmark),
          ],
        ),
      ),
    );
  }

  Widget _buildBookmarkContent(Bookmark bookmark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bookmark.questionText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text(
              'Answer:',
              style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.green),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(bookmark.answer.substring(2)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeleteButton(Bookmark bookmark) {
    return InkWell(
      onTap: () => context.read<BookmarkCubit>().deleteBookmark(bookmark),
      child: const Icon(Icons.close, color: ColorManager.red),
    );
  }
}
