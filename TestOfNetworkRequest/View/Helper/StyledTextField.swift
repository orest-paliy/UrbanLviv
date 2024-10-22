//
//  StyledTextField.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 18.10.2024.
//

import SwiftUI

struct StyledTextField: View {
    @State var viewModel: StyledTextFieldViewModel
    var title: String
    
    @State var needToBeSecured = false
    @State var isSecureModeOn = true
    @Binding var needToBeValidated: Bool
    @Binding var value: String
    

    var body: some View {
        VStack{
            HStack{
                if needToBeSecured && isSecureModeOn{
                   SecureField(title, text: $value)
                       .padding()
                       .onChange(of: value) {
                           viewModel.validationError = ""
                           needToBeValidated = false
                       }
                }else{
                    TextField(title, text: $value)
                        .padding()
                        .onChange(of: value) {
                            viewModel.validationError = ""
                            needToBeValidated = false
                        }
                }
                if needToBeSecured{
                    Button(action: {
                        isSecureModeOn.toggle()
                    }, label: {
                        Image(systemName: isSecureModeOn ? "eye.slash" : "eye")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 25,maxHeight: 60)
                            .padding(.trailing)
                            .foregroundStyle(.gray)
                    })
                }
            }
            .background(.gray.opacity(0.2))
            .cornerRadius(20)
            
             if !viewModel.validationError.isEmpty {
                Text(viewModel.validationError)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
             }
            
        }.onChange(of: needToBeValidated){
            if needToBeValidated == true{
                viewModel.checkIfTextFieldIsValid()
            }
        }
    }
}

extension StyledTextField{
    init(title: String, value: Binding<String>, needToBeSecured: Bool, textFieldType: TypesOfTextField, needToBeValidated: Binding<Bool>){
        self.title = title
        self._value = value
        self._needToBeValidated = needToBeValidated
        self.needToBeSecured = needToBeSecured
        self.viewModel = StyledTextFieldViewModel(value: value, validationError: "", typeOfTextField: textFieldType)
    }
}

#Preview {
    StyledTextField(title: "asd", value: .constant(""), needToBeSecured: false, textFieldType: .email, needToBeValidated: .constant(false))
}
