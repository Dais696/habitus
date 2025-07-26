import React, { useState } from 'react';
import { View, TextInput, Button, Text, Alert } from 'react-native';
import { createUserWithEmailAndPassword } from 'firebase/auth';
import { auth } from '../services/firebase';

export default function RegisterScreen() {
  const [email, setEmail] = useState('');
  const [pass, setPass] = useState('');

  const register = () => {
    if (email === '' || pass.length < 8) {
      Alert.alert("Datos inválidos");
      return;
    }
    createUserWithEmailAndPassword(auth, email, pass)
      .then(() => Alert.alert("Registrado correctamente"))
      .catch(error => Alert.alert(error.message));
  };

  return (
    <View>
      <TextInput placeholder="Correo" onChangeText={setEmail} />
      <TextInput placeholder="Contraseña" secureTextEntry onChangeText={setPass} />
      <Button title="Registrarse" onPress={register} />
    </View>
  );
}
