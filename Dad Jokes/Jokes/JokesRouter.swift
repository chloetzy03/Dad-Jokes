//
//  JokesRouter.swift
//  Dad Jokes
//
//  Created by Chloe Tay on 30/10/26.
//

import UIKit

class JokesRouter {
    static func createModule() -> UIViewController {
        // 1. make the three pieces
        let view = JokesViewController()
        let presenter = JokesPresenter()
        let interactor = JokesInteractor()
        
        // 2. connect them
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.output = presenter
        
        // 3. hand the finished screen back
        return view
    }
}
