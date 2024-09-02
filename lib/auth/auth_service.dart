import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserDocument(User user) async {
    final userDoc = _firestore.collection('users').doc(user.uid);

    final docSnapshot = await userDoc.get();
    if (!docSnapshot.exists) {
      await userDoc.set({
        'email': user.email,
        'name': user.displayName,
        'points': 0, // Inicializa com 0 pontos
      });
    }
  }

  Future<User?> loginWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // O usuário cancelou o login
        return null;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        await createUserDocument(user); // Cria o documento do usuário se não existir
      }

      return user;
    } catch (e) {
      print('Erro ao fazer login com Google: ${e.toString()}');
      return null;
    }
  }

  Future<void> updatePoints(int pointsToAdd) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('Usuário não está autenticado.');
      return;
    }

    try {
      final userDoc = _firestore.collection('users').doc(user.uid);

      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(userDoc);
        if (!snapshot.exists) {
          throw Exception("Usuário não encontrado.");
        }

        final currentPoints = snapshot.data()?['points'] ?? 0;
        final newPoints = currentPoints + pointsToAdd;

        transaction.update(userDoc, {'points': newPoints});
      });
    } catch (e) {
      print('Erro ao atualizar os pontos: ${e.toString()}');
    }
  }
}
