import 'package:cloudquizzer/core/models/bookmark.dart';
import 'package:cloudquizzer/features/bookmark/manager/bookmark_cubit.dart';
import 'package:cloudquizzer/features/bookmark/screen/widget/bookmark_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/color_manager.dart';
import '../../../../core/widgets/no_data_founded_screen.dart';
import '../../manager/bookmark_state.dart';

class BookmarkScreenBlocProvider extends StatelessWidget {
  const BookmarkScreenBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger the fetching of bookmarks.
    context.read<BookmarkCubit>().getBookmarks();

    return BlocBuilder<BookmarkCubit, BookmarkState>(
      builder: (context, state) => _buildStateWidget(state),
    );
  }

  // Handles widget rendering based on the state.
  Widget _buildStateWidget(BookmarkState state) {
    if (state is BookmarkLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: ColorManager.primaryColor,
        ),
      );
    }

    if (state is BookmarkLoaded) {
      return _buildBookmarkScreen(state.bookmarks);
    }

    if (state is BookmarkError) {
      return Center(
        child: Text(
          state.message,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    return const Center(
      child: Text(
        'An unexpected error occurred. Please try again later.',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  // Builds the main content screen or a "No Data" screen.
  Widget _buildBookmarkScreen(List<Bookmark> bookmarks) {
    if (bookmarks.isEmpty) {
      return const NoDataFoundedScreen();
    }
    return BookmarkScreenBody(bookmarks: bookmarks);
  }
}
