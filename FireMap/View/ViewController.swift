//
//  ViewController.swift
//  FireMap
//
//  Created by Pavel Koyushev on 21.10.2020.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    @IBOutlet var mapView: GMSMapView!
    
    private var presenter:  MainPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(view: self, networkService: NetworkService())
        
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: 35.036849,  longitude:  -119.778662))
        mapView.animate(toZoom: 6)
        mapView.delegate = self
    }
}

extension ViewController: MainViewProtocol, GMSMapViewDelegate {
    func succes() {
        //fill map with markers
        for value in presenter.coordinates!{
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: value.lati, longitude: value.long)
            marker.icon = UIImage(named: "fire")
            marker.map = mapView
        }
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

