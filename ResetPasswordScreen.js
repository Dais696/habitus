import React, { useState } from "react";
import { View, TextInput, Button, Alert } from "react-native";
import { sendPasswordResetEmail } from "firebase/auth";
import { auth } from "../services/firebase";

export default function ResetPasswordScreen() {
  const [email, setEmail] = useState("");

  const reset = () => {
    SendPasswordResetEmail(auth, email)
      .then(() => Alert.alert("Correo de recuperación enviado"))
      .catch((err) => Alert.alert("Error: " + err.message));
  };

  return (
    <View>
      <TextInput placeholder="Correo" onChangeText={setEmail} />
      <Button title="Recuperar contraseña" onPress={reset} />
    </View>
  );
}
