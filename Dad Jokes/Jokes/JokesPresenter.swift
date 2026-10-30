//
//  JokesPresenter.swift
//  Dad Jokes
//
//  Created by Chloe Tay on 30/10/26.
//

import UIKit

class JokesPresenter: JokesPresenterProtocol, JokesInteractorOutputProtocol{
    
    weak var view: JokesViewProtocol?
    var interactor: JokesInteractorInputProtocol?
    private var currentJoke: Joke?
    
    
    func viewDidLoad() {
        interactor?.loadFirstJoke()
    }
    
    func didTapShowPunchline() {
        guard let joke = currentJoke else { return }
        view?.showJoke(setup: joke.setup, punchline: joke.punchline, isPunchlineVisible: true)
    }
    
    func didTapNext() {
        interactor?.loadNextJoke()
    }
    
    func didLoadJoke(_ joke: Joke, isLast: Bool){
        currentJoke = joke
        view?.showJoke(setup: joke.setup, punchline: joke.punchline, isPunchlineVisible: false)
        if isLast {
            view?.showMessage(title: "dats all", message: "You've seen all 10 jokes. Starting over.")
        }
    }
}
