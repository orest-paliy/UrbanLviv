//
//  QuestionView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 07.11.2024.
//

import SwiftUI

struct QuestionView: View {
    var title: String
    var description: String
    
    @State private var showDescription: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(title)
                Spacer()
                Button("", systemImage: showDescription ? "chevron.down" : "chevron.right"){
                    withAnimation{
                        showDescription.toggle()
                    }
                }
                .foregroundStyle(.white)
            }
            .fontWeight(.regular)
            if showDescription{
                Text(description)
                    .padding(.top, 4)
                    .font(.system(size: 15))
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
        }
    }
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
        
        if description.isEmpty{
            self.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pellentesque tellus ac tellus iaculis sollicitudin. Proin in venenatis eros, eget vulputate nibh. Quisque eget est non orci varius efficitur. Nullam eleifend quam vel lobortis accumsan. Aenean malesuada nec nibh id sodales. Proin sodales, arcu nec euismod molestie, eros nisi varius tortor, at porta risus felis sit amet nulla. Cras fermentum consequat dui, vel mollis mi iaculis a. Ut id rutrum arcu, hendrerit tempus libero. Mauris ultrices felis ut erat placerat, non elementum libero laoreet. Phasellus id mauris eget nunc euismod varius. Morbi facilisis elementum dui, nec cursus enim pellentesque et."
        }
    }
}

#Preview {
    QuestionView(title: "test", description: "desc")
}
