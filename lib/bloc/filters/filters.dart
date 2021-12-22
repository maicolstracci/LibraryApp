enum FilterType { name }

abstract class BookFilter {
  FilterType type;

  BookFilter(this.type);
}

class NameFilter extends BookFilter {
  final String name;

  NameFilter({required this.name, required FilterType type}) : super(type);
}
