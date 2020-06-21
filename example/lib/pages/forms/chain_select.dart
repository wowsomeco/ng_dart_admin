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
class ChainSelectComponent {
  @Input('selected1')
  int selected1;

  final _select1Change = StreamController<int>();
  @Output()
  Stream<int> get selected1Change => _select1Change.stream;
  void changeSelect1(int id) async {
    _select1Change.add(id);
    options2 = [];

    // fake loading
    loadingSelect2 = true;
    await Future.delayed(Duration(seconds: 1));
    loadingSelect2 = false;

    changeSelect2(null);
    options2 = [
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
        .where((e) => e.idSelect1 == id)
        .map((l) => WSelectOption<int>('Item ${l.id}', l.id))
        .toList();
  }

  @Input('selected2')
  int selected2;

  final _select2Change = StreamController<int>();
  @Output()
  Stream<int> get selected2Change => _select2Change.stream;
  void changeSelect2(int id) => _select2Change.add(id);

  bool loadingSelect2;

  List<WSelectOption<int>> options1 = List.generate(2, (idx) => idx + 1)
      .map((l) => WSelectOption<int>('Item $l', l))
      .toList();

  List<WSelectOption<int>> options2 = [];
}
