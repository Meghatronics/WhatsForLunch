// import 'package:meta/meta.dart';

// import '../../app_dependencies.dart';
// import '../../models/template_models/user_model.dart';
// import '../../services/local_storage_service.dart';
// import '../../utilities/constants/constants.dart';
// import '../data_base_classes/data_base_classes.dart';

// class SessionManager {
//   final LocalStorageService store;

//   // String _token;
//   bool _sessionIsOpen = false;
//   UserModel get currentUser => _currentUser;
//   UserModel _currentUser;

//   SessionManager({
//     @required this.store,
//   });

//   void initSession({@required String token, UserModel user}) {
//     // _token = token;
//     BaseDatasource.token = token;
//     _currentUser = user;
//     _sessionIsOpen = true;
//     store.setBool(firstLaunchStorageKey, false);
//   }

//   Future<void> closeSession() async {
//     if (_sessionIsOpen) {
//       // _token = '';
//       BaseDatasource.token = '';
//       _currentUser = null;
//       _sessionIsOpen = false;
//       await AppDependencies.reset();
//     }
//   }

//   bool updateUser(UserModel user) {
//     if (_sessionIsOpen) {
//       _currentUser = user;
//       if (_currentUser == null) closeSession();
//       return true;
//     } else
//       return false;
//   }
// }
