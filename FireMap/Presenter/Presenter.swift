//
//  Presenter.swift
//  FireMap
//
//  Created by Pavel Koyushev on 21.10.2020.
//

import Foundation

protocol MainViewProtocol: class {
    func succes()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class {
    init (view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getFires()
    var fires: [Fire]? { get set }
    var coordinates: [(lati: Double, long: Double)]? {get set}
}

class MainPresenter: MainViewPresenterProtocol {
    var fires: [Fire]?
    var coordinates: [(lati: Double, long: Double)]? = []
    
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getFires()
    }
    
    func getFires() {
        networkService.getFires{ [weak self] result in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                switch result {
                case .success(let fires):
                    for value in fires! {
                    self.coordinates?.append((lati: value.Latitude, long: value.Longitude))
                    }
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
}
