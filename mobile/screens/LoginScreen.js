import React, { useState } from 'react';
import { View, TextInput, Button, Alert } from 'react-native';
import { signInWithEmailAndPassword } from 'firebase/auth';
import { auth } from '../services/firebase';

export default function LoginScreen() {
  const [email, setEmail] = useState('');
  const [pass, setPass] = useState('');

  const login = () => {
    signInWithEmailAndPassword(auth, email, pass)
      .then(() => Alert.alert("Bienvenido"))
      .catch(err => Alert.alert("Error: " + err.message));
  };

  return (
    <View>
      <TextInput placeholder="Correo" onChangeText={setEmail} />
      <TextInput placeholder="Contraseña" secureTextEntry onChangeText={setPass} />
      <Button title="Iniciar sesión" onPress={login} />
    </View>
  );
}
