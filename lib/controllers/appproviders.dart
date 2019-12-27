import 'package:provider/provider.dart';

import './auth.dart';

List<dynamic> appproviders = [
  ChangeNotifierProvider(
    create: (_) => AuthModel(),
  )
];
