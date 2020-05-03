import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

class WTableFormAdapter<T> {
  T data;
  final Future<T> Function(WTableItem) onFetchForm;
  final Future<bool> Function(T, bool) onSubmitForm;

  bool _isNewForm;

  WTableFormAdapter({this.onFetchForm, this.onSubmitForm});

  final _submitted = StreamController<bool>.broadcast();
  Stream<bool> get submitStream => _submitted.stream;
  void submitted(bool success) {
    _submitted.add(success);
    submitting(false);
  }

  final _submitting = StreamController<bool>.broadcast();
  Stream<bool> get submittingStream => _submitting.stream;
  void submitting(bool flag) => _submitting.add(flag);

  void fetchData(WTableItem item) async {
    _isNewForm = item == null;
    data = await onFetchForm(item);
  }

  void submitForm() async {
    submitting(true);
    await onSubmitForm(data, _isNewForm);
    submitted(true);
  }
}

@Component(
  selector: 'w-action-table',
  templateUrl: 'w_action_table.html',
  directives: [
    coreDirectives,
    formDirectives,
    ngAdminDirectives,
    WTableComponent,
    WDialogComponent,
    WSpinnerComponent
  ],
)
class WActionTableComponent extends WTableComponent implements OnInit {
  bool loadForm = false;

  bool _showDialog = false;
  bool get showDialog => _showDialog;
  set showDialog(bool flag) => _showDialog = flag;

  bool _submitting = false;

  @Input('form')
  WTableFormAdapter form;

  void setItem(WTableItem itm) async {
    /// show the dialog with the spinner on
    showDialog = true;
    loadForm = true;
    await form.fetchData(itm);

    /// hide the spinner
    loadForm = false;
  }

  @override
  void ngOnInit() {
    /// listen to table adapter
    adapter
      ..addItemStream.listen((ev) => setItem(null))
      ..clickRowStream.listen((ev) => setItem(ev));

    /// form adapter streams
    form
      ..submitStream.listen((ev) {
        if (ev) {
          adapter.reload();
          showDialog = false;
        }
      })
      ..submittingStream.listen((ev) => _submitting = ev);
  }

  Map<String, String> get formStyles => {
        'pointer-events': _submitting ? 'none' : 'auto',
        'opacity': _submitting ? '0.95' : '1'
      };
}
