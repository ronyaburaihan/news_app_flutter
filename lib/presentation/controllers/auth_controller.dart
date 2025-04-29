import 'package:get/get.dart';

import '../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_auth_state_changes_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';

class AuthController extends GetxController {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final GetAuthStateChangesUseCase getAuthStateChangesUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  final Rx<AppUser?> currentUser = Rx<AppUser?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  AuthController({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.getAuthStateChangesUseCase,
    required this.getCurrentUserUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    currentUser.bindStream(
      getAuthStateChangesUseCase(
        NoParams(),
      ).map((either) => either.fold((l) => null, (r) => r)),
    );
  }

  Future<void> signIn(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await signInUseCase(
      SignInParams(email: email, password: password),
    );
    result.fold(
      (failure) {
        errorMessage.value = failure.toString();
      },
      (user) {
        Get.offAllNamed('/');
      },
    );
    isLoading.value = false;
  }

  Future<void> signUp(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await signUpUseCase(
      SignUpParams(email: email, password: password),
    );
    result.fold(
      (failure) {
        errorMessage.value = failure.toString();
      },
      (user) {
        Get.offAllNamed('/');
      },
    );
    isLoading.value = false;
  }

  Future<void> signOut() async {
    final result = await signOutUseCase(NoParams());
    result.fold(
      (failure) {
        Get.snackbar(
          'Error',
          'Failed to sign out: ${failure.toString()}',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (_) {
        Get.snackbar(
          'Success',
          'Signed out successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        //Get.offAllNamed('/signIn');
      },
    );
  }

  // Check if a user is currently logged in
  bool isAuthenticated() {
    return currentUser.value != null;
  }

  // Get the currently logged-in user
  AppUser? getCurrentUser() {
    return currentUser.value;
  }
}
