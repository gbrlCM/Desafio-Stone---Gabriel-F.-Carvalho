//
//  MainCoordinator.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

import UIKit

protocol MainCoordinatorProtocol: AnyObject {
    
    func navigateToCharacter(_ character: RMCharacter)
    func displayFilter()
}

final class MainCoordinator: MainCoordinatorProtocol, CoordinatorProcotol {
    
    let navigationView: UINavigationController
    
    init(navigationView: UINavigationController) {
        self.navigationView = navigationView
    }
    
    func start() {
        let homeInteractor = HomeInteractor(initialState: HomeState())
        let homePresenter = HomePresenter(interactor: homeInteractor)
        homePresenter.mainCoordinator = self
        let homeView = HomeViewController(presenter: homePresenter)
        
        navigationView.pushViewController(homeView, animated: false)
    }
    func navigateToCharacter(_ character: RMCharacter) {
        
    }
    
    func displayFilter() {
        let filterView = FilterViewController()
        navigationView.present(filterView, animated: true)
    }
    
}
