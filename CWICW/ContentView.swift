//
//  ContentView.swift
//  CWICW
//
//  Created by Jesus Vargas on 08/04/25.
//

import SwiftUI

let icons = ["house","chart.bar","plus","calendar","gear"]

struct ContentView: View {
    @State var viewselected = 0
    var body: some View {
        VStack {
            ZStack{
                switch viewselected{
                  case 0:
                    NavigationView{
                        SelectorViewRepresentable()
                        .navigationTitle("Reservaciones de clases")
                        /*VStack{
                            Text("Pantalla 1")
                        }*/
                        
                    }
                case 1:
                    NavigationView{
                        SelectorViewCourts()
                        .navigationTitle("Reservaciones de canchas")
                        /*VStack{
                            Text("Pantalla 1")
                        }*/
                        
                    }
                  /*NavigationView{
                      VStack{
                          Text("Pantalla 2")
                      }
                      .navigationTitle("2")
                  }*/
                case 2:
                  NavigationView{
                      VStack{
                          Text("Pantalla 3")
                      }
                      .navigationTitle("3")
                  }
                case 3:
                  NavigationView{
                      VStack{
                          Text("Pantalla 4")
                      }
                      .navigationTitle("4")
                  }
                 default:
                    NavigationView{
                        VStack{
                            Text("Pantalla 5")
                        }
                        .navigationTitle("Configuraciones")
                    }
                }
            }
            Spacer()
            HStack{
                ForEach(0..<5, id: \.self){ numeros in
                    Spacer()
                    Button(action: {
                        self.viewselected = numeros
                        
                    }, label:{
                        if numeros == 2{
                            Image(systemName: icons[numeros])
                                .frame(width:60,height: 60)
                                .background(Color.blue)
                                .cornerRadius(30)
                                .font(.title)
                                .foregroundColor(.white)
                        }else{
                            Image(systemName: icons[numeros])
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    })
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
