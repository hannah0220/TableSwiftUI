//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Fay, Hannah M on 4/12/23.
//

import SwiftUI
      import MapKit
      
let data = [
    Item(name: "Pecan Street Market", neighborhood: "Pflugerville", desc: "Fresh custom florals, same day and pre-orders orders. Gift shop and clothing boutique.", lat: 30.4400401, long: -97.620699, imageName: "rest1"),
    Item(name: "Ruffles and Rust", neighborhood: "Pflugerville", desc: "The perfect place to find gifts, ladies fashions, and Southern staples for every occasion. Women owned small business.", lat:30.43986, long: -97.6212, imageName: "rest2"),
    Item(name: "Pflour Shop", neighborhood: "Pflugerville", desc: "Pflour Shop Bakery are your favorite local carb dealers. Decorated cookies, custom cakes and carbs.", lat: 30.484350, long:  -97.583740, imageName: "rest3"),
    Item(name: "West Pecan Coffee + Beer", neighborhood: "Pflugerville", desc: "Locally owned coffee shop in downtown Pflugerville on tap. Perfectly cozy, clean and modern. ", lat: 30.440330, long: -97.621000, imageName: "rest4"),
    Item(name: "Mays Street Boutique ", neighborhood: "Round Rock", desc: "Best boutique in Round Rock, Texas 4th time winner. Women's, men's, baby and home decor.", lat: 30.529170, long: -97.687780, imageName: "rest5")
   
]

      struct Item: Identifiable {
            let id = UUID()
            let name: String
            let neighborhood: String
            let desc: String
            let lat: Double
            let long: Double
            let imageName: String
        }
      
      struct ContentView: View {
          @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.726220), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
          
          var body: some View {
              NavigationView {
                  VStack {
                      List(data, id: \.name) { item in
                          NavigationLink(destination: DetailView(item: item)) {
                              HStack {
                                  Image(item.imageName)
                                      .resizable()
                                      .frame(width: 50, height: 50)
                                      .cornerRadius(10)
                                  VStack(alignment: .leading) {
                                      Text(item.name)
                                          .font(.headline)
                                      Text(item.neighborhood)
                                          .font(.subheadline)
                                  }
                              }
                          }
                      }
                      Map(coordinateRegion: $region, annotationItems: data) { item in
                                      MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                          Image(systemName: "mappin.circle.fill")
                                              .foregroundColor(.red)
                                              .font(.title)
                                              .overlay(
                                                  Text(item.name)
                                                      .font(.subheadline)
                                                      .foregroundColor(.black)
                                                      .fixedSize(horizontal: true, vertical: false)
                                                      .offset(y: 25)
                                              )
                                      }
                                  }
                                  .frame(height: 300)
                                  .padding(.bottom, -30)
                  }
                  .listStyle(PlainListStyle())
                          .navigationTitle("Shop Local")
              }
          }
      }
      
      struct DetailView: View {
          @State private var region: MKCoordinateRegion
                
                init(item: Item) {
                    self.item = item
                    _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
                }
          
              let item: Item
          
                      
              var body: some View {
                  VStack {
                      Image(item.imageName)
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(maxWidth: 200)
                      Text("Neighborhood: \(item.neighborhood)")
                          .font(.subheadline)
                      Text("Description: \(item.desc)")
                          .font(.subheadline)
                          .padding(10)
                          }
                           .navigationTitle(item.name)
                  Map(coordinateRegion: $region, annotationItems: [item]) { item in
                          MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                              Image(systemName: "mappin.circle.fill")
                                  .foregroundColor(.red)
                                  .font(.title)
                                  .overlay(
                                      Text(item.name)
                                          .font(.subheadline)
                                          .foregroundColor(.black)
                                          .fixedSize(horizontal: true, vertical: false)
                                          .offset(y: 25)
                                  )
                          }
                      }
                      .frame(height: 300)
                      .padding(.bottom, -30)
               }
            }
          
      
      struct ContentView_Previews: PreviewProvider {
          static var previews: some View {
              ContentView()
          }
      }
                  
  
