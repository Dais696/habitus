const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendPasswordReset = functions.https.onCall(async (data, context) => {
  const email = data.email;
  try {
    await admin.auth().generatePasswordResetLink(email);
    return { message: 'Correo de recuperación enviado' };
  } catch (error) {
    throw new functions.https.HttpsError('internal', error.message);
  }
});
