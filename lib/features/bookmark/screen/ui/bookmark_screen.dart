import 'package:cloudquizzer/features/bookmark/screen/widget/bookmark_screen_bloc_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/bookmark_cubit.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookmarkCubit(),
      child: BookmarkScreenBlocProvider(),
    );
  }
}
