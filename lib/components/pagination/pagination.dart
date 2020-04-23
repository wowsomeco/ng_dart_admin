import 'dart:async';

import 'package:angular/angular.dart';

@Component(
  selector: 'w-pagination',
  templateUrl: 'pagination.html',
  directives: [coreDirectives],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class PaginationComponent {
  /// The current page
  @Input('page')
  int page = 1;

  /// The number of items per page.
  @Input('pageSize')
  int pageSize;

  /// The number of items in your paginated collection.
  @Input('collectionSize')
  int collectionSize;

  final _pageChanged = StreamController<int>();
  @Output()
  Stream<int> get pageChange => _pageChanged.stream;

  void changePage(int idx) => _pageChanged.add(idx);

  void nextPage() {
    if (!nextDisabled) _pageChanged.add(_clamp(page + 1));
  }

  void prevPage() {
    if (!previousDisabled) _pageChanged.add(_clamp(page - 1));
  }

  int get pageCount => (collectionSize / pageSize).ceil();

  List<int> get pages => List.generate(pageCount, (i) => i + 1);

  bool get hasPrevious => page > 1;

  bool get hasNext => page < pageCount;

  bool get nextDisabled => !hasNext;

  bool get previousDisabled => !hasPrevious;

  String get className => 'dim br2 ba b--light-blue mh1 pa2';

  int _clamp(int page) => page.clamp(1, pageSize);
}
