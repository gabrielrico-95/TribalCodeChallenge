//
//  ContactInfoContentView.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 15/2/21.
//

import SwiftUI

struct ContactInfoContentView: View {
    @State private var username: String = ""
    @State private var birthDate = Date()
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var showingAlert = false
    @State private var apiMessage: String = ""
    
    @ObservedObject private var contactInfoObserver = UnsplashApiService()
    
    private var validated: Bool {
        if !username.isEmpty && !email.isEmpty && !message.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack(alignment: .leading) {
                    Text("Nombre completo")
                        .font(.callout)
                        .bold()
                    TextField("Ingrese su nombre...", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("Fecha de nacimiento")
                        .font(.callout)
                        .bold()
                    DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                        Text("Fecha")
                    }
                    Text("Su fecha es el: \(birthDate, formatter: dateFormatter)")
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("Correo electrónico")
                        .font(.callout)
                        .bold()
                    TextField("Ingrese su correo...", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("Mensaje")
                        .font(.callout)
                        .bold()
                    TextField("Ingrese su mensaje...", text: $message)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }.padding()
                
                Button(action: {
                    sendContactInfoToApi()
                }) {
                    HStack {
                        Text("Enviar")
                            .fontWeight(.semibold)
                            .font(.title3)
                        Image(systemName: "paperplane")
                            .font(.title3)
                        
                    }
                    .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width/2)
                    .frame(minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 30)
                    .padding()
                    .foregroundColor(.white)
                    .background(validated ? Color.blue : Color.gray)
                    .cornerRadius(40)
                }.padding()
                .disabled(!validated)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Mensaje de API"),
                          message: Text("\(apiMessage)"),
                          dismissButton: .default(Text("Listo")))}
                
            }
            .navigationTitle("Contacto")
        }
    }
    
}

extension ContactInfoContentView: ContactInfoView {
    
    func createContactModel() -> ContactDetails {
        var contactDetails = ContactDetails()
        contactDetails.fullName = username
        contactDetails.dateOfBirth = dateFormatter.string(from: birthDate)
        contactDetails.email = email
        contactDetails.additionalMessage = message
        return contactDetails
    }
    
    func sendContactInfoToApi() {
        contactInfoObserver.postContactInformationApi(model: createContactModel(), completion: { success, messageString in
            
            showingAlert = true
            
            apiMessage = messageString
        })
    }
    
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContactInfoContentView()
    }
}
