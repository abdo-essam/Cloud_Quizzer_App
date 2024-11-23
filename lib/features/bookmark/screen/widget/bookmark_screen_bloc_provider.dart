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
    context.read<BookmarkCubit>().getBookmarks();
    return BlocBuilder<BookmarkCubit, BookmarkState>(
      builder: (context, state) {
        if (state is BookmarkLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorManager.primaryColor,
            ),
          );
        }
        if (state is BookmarkLoaded) {
          return getBookmarkScreen(state.bookmarks);
        }


        if (state is BookmarkError) {
          return Center(
            child: Text(state.message),
          );
        }
        return const Center(
          child: Text('Something went wrong! , try again later'),
        );
      },
    );
  }

  Widget getBookmarkScreen(List<Bookmark> bookmarks) {
    if (bookmarks.isEmpty) {
      return const NoDataFoundedScreen();
    }
    return BookmarkScreenBody(bookmarks: bookmarks);
  }
}
