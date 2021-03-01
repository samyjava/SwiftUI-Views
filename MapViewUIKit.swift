//
//  MapViewUIKit.swift
//
//  Created by Sam Javadizadeh on 1/27/21.
//

import SwiftUI
import MapKit

struct MapViewUIKit: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // 1.
    @Binding var region: MKCoordinateRegion
    @Binding var isUserLocationVisible: Bool
    let mapType : MKMapType
    
    // 2.
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(region, animated: false)
        mapView.showsCompass = false
        mapView.showsScale = false
        mapView.userTrackingMode = .none
        mapView.showsBuildings = true
        mapView.showsUserLocation = true
        mapView.mapType = mapType
        mapView.overrideUserInterfaceStyle = .dark
        mapView.delegate = context.coordinator        
        return mapView
    }
    
    // 3.
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.mapType = mapType
        DispatchQueue.main.async {
            mapView.setRegion(region, animated: false)
        }
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewUIKit
        
        init(_ parent: MapViewUIKit) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            self.parent.region = mapView.region
            self.parent.isUserLocationVisible = mapView.isUserLocationVisible
        }
    }
    
}
