//
// RegistrationView.swift
// Contlo-iOS-SDK
//
// Created by Aman Toppo on 23/10/23.
//
import SwiftUI

@available(iOS 14.0, *)
struct RegistrationView: View {
  @State private var email: String = ""
  @State private var phone: String = ""
  @State private var name: String = ""
  @State private var isEmailValid: Bool = true
  @State private var isPhoneValid: Bool = true
    
    var body: some View {
    VStack {
      Text("Register User")
        .font(.largeTitle)
        .padding()
      TextField("Email (required)", text: $email)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .textContentType(.emailAddress)
        .autocapitalization(.none)
        .onChange(of: email, perform: validateEmail)
      TextField("Phone (optional)", text: $phone)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .textContentType(.telephoneNumber)
        .autocapitalization(.none)
        .onChange(of: phone, perform: validatePhone)
      TextField("Name (optional)", text: $name)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
      Button(action: {
        if isEmailValid {
          // Email is valid, handle registration here
          print("Email: \(email)")
        } else {
          // Email is invalid, show an error message or take appropriate action
          print("Invalid Email")
        }
        if isPhoneValid {
          // Phone is valid, handle registration here
          print("Phone: \(phone)")
        } else {
          // Phone is invalid, show an error message or take appropriate action
          print("Invalid Phone")
        }
        // Handle Name and registration logic here
        print("Name: \(name)")
      }) {
        Text("Register")
          .font(.title)
          .foregroundColor(.white)
          .padding()
          .background(Color.blue)
          .cornerRadius(10)
      }
    }
    .padding()
  }
  private func validateEmail(_ newEmail: String) {
    isEmailValid = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: newEmail)
  }
  private func validatePhone(_ newPhone: String) {
    // Customize the phone number regex pattern as per your requirements
    isPhoneValid = NSPredicate(format: "SELF MATCHES %@", "^[+]?[0-9]{6,14}$").evaluate(with: newPhone)
  }
}
@available(iOS 14.0, *)
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
    RegistrationView()
  }
}
