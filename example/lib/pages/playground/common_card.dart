import 'package:angular/angular.dart';

@Component(
  selector: 'common-card',
  templateUrl: 'common_card.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
  directives: [coreDirectives],
)
class CommonCardComponent {
  @Input()
  String name;

  @Input()
  String date;

  @Input()
  String description;
}
