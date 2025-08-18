import Foundation
import SwiftUI

struct LoginView: View {
    @State var username : String = ""
    @State var password : String = ""
    @State var logins: [Username] = []
    @State var login: [String] = []
    
    var body: some View {
        VStack {
            Label("Usuario", systemImage: "person.circle")
            TextField("Usuario", text: $username)
                .keyboardType(.default)
                .textInputAutocapitalization(.never)
                .padding(16)
                .background(.gray.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal,32)
            
            Label("Contraseña", systemImage: "ellipsis.rectangle")
            SecureField("Contraseña", text: $password)
                .keyboardType(.default)
                .textInputAutocapitalization(.never)
                .textContentType(.password)
                .padding(16)
                .background(.gray.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal,32)
                //.onChange(of: password, { oldValue,newValue in print("oldValuePass = \(oldValue), NEWVALUEPASS= \(newValue)") })
            
            Button(action:handleSend)
                {
                    Label("Iniciar sesion",systemImage:"rectangle.portrait.and.arrow.forward.fill")
                }
                .padding(16)
                .foregroundColor(.white)
                .background(.blue)
                .padding(.horizontal,32)
                .cornerRadius(10)
        }
    }
    
    func handleSend() {
        // Obtener cancha seleccionada
        
        let username = username
        let password = password
        
        WebServiceApi.shared.login(username: username,password: password){result in
            DispatchQueue.main.async {
                switch result{
                    case .success(let response):
                        //print("Respuesta exitosa: \(response)")
                        self.logins = response
                        self.login = self.logins.map { $0.username }
                        print("Usernames: \(response.map { $0.username })")
                    case .failure(let error):
                        print("Error de red al registrar: \(error.localizedDescription)")
                }
            }
        }

        print("username: \(username), pass: \(password)")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
