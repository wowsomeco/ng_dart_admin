import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

class _SelectItem2 {
  final int idSelect1;
  final int id;

  _SelectItem2(this.idSelect1, this.id);
}

@Component(
    selector: 'chain-select',
    templateUrl: 'chain_select.html',
    directives: [
      coreDirectives,
      formDirectives,
      ngAdminDirectives,
      WSelectComponent
    ])
class ChainSelectComponent implements AfterChanges {
  @Input('selected1')
  int selected1;

  final _select1Change = StreamController<int>();
  @Output()
  Stream<int> get selected1Change => _select1Change.stream;
  void changeSelect1(int id) => _select1Change.add(id);

  @Input('selected2')
  int selected2;

  final _select2Change = StreamController<int>();
  @Output()
  Stream<int> get selected2Change => _select2Change.stream;
  void changeSelect2(int id) => _select2Change.add(id);

  WSelectAdapter<int> selectAdapter1 =
      WSelectAdapter<int>(fetchOptions: () async {
    await Future.delayed(Duration(seconds: 1));
    return List.generate(2, (idx) => idx + 1)
        .map((l) => WSelectOption<int>('Item $l', l))
        .toList();
  });

  WSelectAdapter<int> selectAdapter2;

  @override
  void ngAfterChanges() {
    if (selected1 != null) {
      selectAdapter2 = null;
      selectAdapter2 = WSelectAdapter<int>(fetchOptions: () async {
        await Future.delayed(Duration(seconds: 1));
        return [
          _SelectItem2(1, 1),
          _SelectItem2(1, 2),
          _SelectItem2(1, 3),
          _SelectItem2(1, 4),
          _SelectItem2(1, 5),
          _SelectItem2(2, 6),
          _SelectItem2(2, 7),
          _SelectItem2(2, 8),
          _SelectItem2(2, 9),
          _SelectItem2(2, 10),
        ]
            .where((e) => e.idSelect1 == selected1)
            .map((l) => WSelectOption<int>('Item ${l.id}', l.id))
            .toList();
      });
    }
  }
}
