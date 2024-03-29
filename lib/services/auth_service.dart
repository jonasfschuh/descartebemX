import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();
  //Rx<User?> _firebaseUser = Rx<User>();
  var userIsAuthenticated = false.obs;
  var userDisplayName = 'NoValue'.obs;

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());

    ever(_firebaseUser, (User? user) {
      if (user != null) {
        userDisplayName.value = user.displayName!;
        userIsAuthenticated.value = true;
      } else {
        userIsAuthenticated.value = false;
        userDisplayName.value = 'noValue';
      }
    });
  }

  bool isUserAutenticated() {
    return userIsAuthenticated.value;
  }

  User? get usuarioValue => _firebaseUser.value;

  String get usuarioEmail {
    return _firebaseUser.value?.email ?? 'email';
  }

  String get usuarioDisplayName {
    return _firebaseUser.value?.displayName ?? 'displayname';
  }

  String get usuarioUID {
    return _firebaseUser.value?.uid ?? 'uid';
  }

  String get userToString {
    return _firebaseUser.value?.toString() ?? '';
  }

  static AuthService get to => Get.find<AuthService>();

  showSnack(String titulo, String erro) {
    print('showsnack');
    Get.snackbar(
      titulo,
      erro,
      //backgroundColor: Colors.grey[900],
      //colorText: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  createUser(String email, String password) async {
    late User? user;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      user = _auth.currentUser;
      await user!.updateDisplayName("Lecter");
      //user.uid
    } catch (e) {
      showSnack('Erro ao registrar!', e.toString());
    }
  }

  login(String email, String password) async {
    try {
      //ver outras opções de login
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('erro no login' + e.toString());
      showSnack('Erro no Login!', e.toString());
    }
  }

  logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      showSnack('Erro ao sair!', e.toString());
    }
  }
}
