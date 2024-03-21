part of 'home_screen.dart';

AppBar _homeAppBar({
  required VoidCallback onFilterPressed,
  required VoidCallback onDeletePressed,
}) {
  return AppBar(
    title: const Text(Strings.TITLE),
    actions: [
      IconButton(
        onPressed: onFilterPressed,
        icon: const Icon(
          Icons.filter_list_alt,
          color: Colors.white,
        ),
      ),
      IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        onPressed: onDeletePressed,
      ),
    ],
  );
}
