import 'package:provider/provider.dart';

import '../controllers/auth.dart';
import '../controllers/task.dart';

class AppProviders {
  final List<ChangeNotifierProvider> appproviders = [
    ChangeNotifierProvider(
      create: (_) => AuthModel(),
    ),
    ChangeNotifierProvider(
      create: (_) => TaskModel(),
    )
  ];
}
