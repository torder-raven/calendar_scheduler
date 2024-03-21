import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const/strings.dart';
import '../component/app_bar.dart';

AppBar homeAppBar({
  required BuildContext context,
  required VoidCallback onFilterPressed,
  required VoidCallback onDeletePressed,
  required VoidCallback onSearchPressed,
}) {
  return appBar(
    context: context,
    title: Strings.TITLE,
    actions: [
      IconButton(
        icon: const Icon(Icons.search, color: Colors.white),
        onPressed: onSearchPressed,
      ),
      IconButton(
        onPressed: onFilterPressed,
        icon: const Icon(
          Icons.filter_list_alt,
          color: Colors.white,
        ),
      ),
      IconButton(
        onPressed: onDeletePressed,
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    ],
  );
}
