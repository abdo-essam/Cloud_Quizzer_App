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
}
