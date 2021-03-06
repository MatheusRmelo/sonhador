import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/modules/discovery/repository/discovery_text_repository.dart';
import 'package:sonhador/app/modules/discovery/widgets/search/discovery_search_page.dart';
import 'package:sonhador/app/modules/home/home_content/repository/points_repository.dart';
import 'package:sonhador/app/modules/home/home_content/widgets/text/discovery_text_page.dart';
import 'package:sonhador/app/modules/home/home_controller.dart';
import 'package:sonhador/app/modules/home/widgets/comment_controller.dart';
import 'package:sonhador/app/modules/login/login_page.dart';
import 'package:sonhador/app/modules/profile/repository/profile_repository.dart';
import 'package:sonhador/app/modules/profile/widgets/edit/edit_page.dart';
import 'package:sonhador/app/modules/profile/widgets/input/input_controller.dart';
import 'package:sonhador/app/modules/writer/repository/writer_repository.dart';
import 'package:sonhador/app/modules/writer/widgets/search/search_controller.dart';
import '../profile/widgets/input/input_page.dart';
import 'home_content/home_content_controller.dart';
import 'home_content/repository/home_text_repository.dart';
import 'home_content/widgets/profile/profile_controller.dart';
import 'home_content/widgets/profile/profile_page.dart';
import 'home_content/widgets/text/discovery_text_controller.dart';
import 'home_page.dart';
import 'widgets/comment_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        Bind((i) => HomeContentController(i.get(), i.get())),
        Bind((i) => HomeTextRepository()),
        Bind((i) => PointsRepository()),
        Bind((i) => CommentController(i.get())),
        Bind((i) => SearchController(i.get(), i.get())),
        Bind((i) => WriterRepository()),
        Bind((i) => InputController()),
        Bind((i) => HomeProfileController(i.get(), i.get())),
        Bind((i) => ProfileRepository()),
        Bind((i) => DiscoveryTextController(i.get(), i.get())),
        Bind((i) => DiscoveryTextRepository()),
        Bind((i) => PointsRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => HomePage()),
        ModularRouter('/login', child: (_, args) => LoginPage()),
        ModularRouter('/profile', child: (_, args) => ProfilePage()),
        ModularRouter('/comment', child: (_, args) => CommentPage()),
        ModularRouter('/edit', child: (_, args) => EditPage()),
        ModularRouter('/input/:title/:value/:action',
            child: (_, args) => Input(
                  title: args.params['title'],
                  value: args.params['value'],
                  action: args.params['action'],
                )),
        ModularRouter('/search', child: (_, args) => DiscoverySearchPage()),
        ModularRouter('/text', child: (_, args) => DiscoveryTextPage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
