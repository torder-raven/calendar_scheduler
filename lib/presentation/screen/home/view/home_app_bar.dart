part of 'home_screen.dart';

AppBar _homeAppBar({
  required VoidCallback onFilterPressed,
  required VoidCallback onDeletePressed,
  required VoidCallback onSearchPressed,
}) {
  return AppBar(
    title: const Text(Strings.TITLE),
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
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        onPressed: onDeletePressed,
      ),
    ],
  );
}
