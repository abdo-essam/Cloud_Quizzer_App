import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../core/models/bookmark.dart';
import 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInitial());

  Future<List<Bookmark>> getBookmarks() async {
    try {
      emit(BookmarkLoading());
      final box = Hive.box('bookmarks');
      emit(BookmarkLoaded(bookmarks: box.values.cast<Bookmark>().toList()));
      return box.values.cast<Bookmark>().toList();
    } catch (e) {
      emit(BookmarkError(message: e.toString()));
      return [];
    }
  }

  Future<void> deleteBookmark(Bookmark bookmark) async {
    try {
      final box = Hive.box('bookmarks');

      // Locate the key associated with the bookmark
      final key = box.keys.firstWhere(
            (k) => box.get(k) == bookmark,
        orElse: () => null, // Handle if no key is found
      );

      if (key != null) {
        await box.delete(key); // Delete using the key
        emit(BookmarkDelete(bookmark: bookmark));
        getBookmarks(); // Refresh bookmarks
      } else {
        emit(BookmarkError(message: "Bookmark not found."));
      }
    } catch (e) {
      emit(BookmarkError(message: e.toString()));
    }
  }
}
