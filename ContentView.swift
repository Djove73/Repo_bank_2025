//
//  ContentView.swift
//  Project_Bank
//
//  Created by roger_jove on 23/6/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingLogin = false
    @State private var showingRegister = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Fondo degradado
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.8),
                        Color.blue.opacity(0.6),
                        Color.white
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    // Logo y título del banco
                    VStack(spacing: 20) {
                        // Icono del banco
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: "building.columns.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                        }
                        
                        VStack(spacing: 10) {
                            Text("BANK 2025")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("Tu banco del futuro")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }
                    
                    Spacer()
                    
                    // Botones de acción
                    VStack(spacing: 20) {
                        // Botón de Iniciar Sesión
                        Button(action: {
                            showingLogin = true
                        }) {
                            HStack {
                                Image(systemName: "person.fill")
                                    .font(.title3)
                                Text("Iniciar Sesión")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                        
                        // Botón de Registrarse
                        Button(action: {
                            showingRegister = true
                        }) {
                            HStack {
                                Image(systemName: "person.badge.plus")
                                    .font(.title3)
                                Text("Registrarse")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                    
                    // Texto de seguridad
                    VStack(spacing: 5) {
                        Text("🔒 Tus datos están seguros")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text("Cifrado de 256 bits")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .sheet(isPresented: $showingLogin) {
            LoginView()
        }
        .sheet(isPresented: $showingRegister) {
            RegisterView()
        }
    }
}

// Vista de Login
struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 15) {
                    Image(systemName: "building.columns.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("Iniciar Sesión")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Accede a tu cuenta bancaria")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40)
                
                // Formulario
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        TextField("tu@email.com", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Contraseña")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        SecureField("Tu contraseña", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Button("¿Olvidaste tu contraseña?") {
                        // Acción para recuperar contraseña
                    }
                    .font(.caption)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                // Botón de login
                Button(action: {
                    // Aquí iría la lógica de login
                    showingAlert = true
                }) {
                    Text("Iniciar Sesión")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
                }
                .padding(.horizontal, 30)
                .disabled(email.isEmpty || password.isEmpty)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
        .alert("Login", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text("Funcionalidad de login en desarrollo")
        }
    }
}

// Vista de Registro
struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var fullName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    VStack(spacing: 15) {
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        Text("Crear Cuenta")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Únete a BANK 2025")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                    
                    // Formulario
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Nombre completo")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            TextField("Tu nombre completo", text: $fullName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            TextField("tu@email.com", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Teléfono")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            TextField("+34 600 123 456", text: $phone)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.phonePad)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Contraseña")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            SecureField("Mínimo 8 caracteres", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Confirmar contraseña")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            SecureField("Repite tu contraseña", text: $confirmPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    // Botón de registro
                    Button(action: {
                        // Aquí iría la lógica de registro
                        showingAlert = true
                    }) {
                        Text("Crear Cuenta")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                    .padding(.horizontal, 30)
                    .disabled(fullName.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty || confirmPassword.isEmpty)
                    
                    // Términos y condiciones
                    VStack(spacing: 10) {
                        Text("Al registrarte, aceptas nuestros")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 5) {
                            Button("Términos y Condiciones") {
                                // Mostrar términos
                            }
                            .font(.caption)
                            .foregroundColor(.blue)
                            
                            Text("y")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Button("Política de Privacidad") {
                                // Mostrar política
                            }
                            .font(.caption)
                            .foregroundColor(.blue)
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
        .alert("Registro", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text("Funcionalidad de registro en desarrollo")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
