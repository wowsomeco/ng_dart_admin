import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(
    selector: 'tachyon-cards',
    templateUrl: 'tachyon_cards.html',
    changeDetection: ChangeDetectionStrategy.OnPush,
    directives: [coreDirectives, ngAdminDirectives])
class TachyonCardsComponent {}
