//
//  CoordinatorProtocol.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

import UIKit

protocol CoordinatorProcotol: AnyObject {
    var navigationView: UINavigationController { get }
    
    func start()
}
