//
//  TopBar.swift
//  ourRecipes
//
//  Created by Claire Lodermeier on 4/11/25.
//

import SwiftUI

struct TopBar: View {

    var title: String = "ourRecipes"
    var header: String = "All Recipes"
    var body: some View {
        VStack() {
            HStack() {
                
                Spacer()
                
                Text(title)
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.white)
                
                Image(systemName: "book.fill")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.white)
                
                Spacer()
                
            } // Close HStack
            .padding(.bottom, 2)
            
            Text(header)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white.opacity(0.7))
                //.padding(.bottom, 5)

            
            Spacer()
            
        } // Close VStack
        .padding()
        .padding(.bottom, 0)
        .frame(height: 65)
        .background(Color.brown)


    }

}

#Preview {
    TopBar()
}
