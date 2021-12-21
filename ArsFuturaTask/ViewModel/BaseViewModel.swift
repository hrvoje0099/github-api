//
//  BaseViewModel.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 08.12.2021.
//

import Foundation

protocol BaseViewModelProtocol {
    var isLoading: Bool { get }
    var alertMessage: String? { get }
    
    var reloadTableView: (()->())? { get set }
    var updateLoadingStatus: (()->())? { get set }
    var showAlertClosure: (()->())? { get set }
}

class BaseViewModel {
    
    // MARK: - PROTOCOL PROPERTIES
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    // MARK: - PROTOCOL CLOSURES
    
    var reloadTableView: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var showAlertClosure: (()->())?
    
    // MARK: - PUBLIC METHODS
    
    func processError(error: RequestError) {
        switch error {
        case .noData:
            self.alertMessage = RequestError.noData.description
        case .dataDecodingError:
            self.alertMessage = RequestError.dataDecodingError.description
        case .apiError:
            self.alertMessage = RequestError.apiError.description
        case .invalidResponse:
            self.alertMessage = RequestError.invalidResponse.description
        }
    }
}
