//
//  JokesInteractor.swift
//  Dad Jokes
//
//  Created by Chloe Tay on 30/10/26.
//

import UIKit

class JokesInteractor: JokesInteractorInputProtocol{
    
    private let jokesArray = [
        Joke(
            setup: "Why don't scientists trust atoms?",
            punchline: "Because they make up everything!",
            imageName: "tiktok"
        ),
        Joke(
            setup: "Why did the scarecrow win an award?",
            punchline: "He was outstanding in his field!",
            imageName: "tiktok2"
        ),
        Joke(
            setup: "What do you call a fake noodle?",
            punchline: "An impasta!",
            imageName: "tiktok3"
        ),
        Joke(
            setup: "Why did the bicycle fall over?",
            punchline: "Because it was two-tired!",
            imageName: "tiktok"
        ),
        Joke(
            setup: "What do you call cheese that isn't yours?",
            punchline: "Nacho cheese!",
            imageName: "tiktok2"
        ),
        Joke(
            setup: "Why can't you give Elsa a balloon?",
            punchline: "Because she will let it go!",
            imageName: "tiktok3"
        ),
        Joke(
            setup: "What do you call a bear with no teeth?",
            punchline: "A gummy bear!",
            imageName: "tiktok"
        ),
        Joke(
            setup: "Why did the math book look sad?",
            punchline: "Because it had too many problems!",
            imageName: "tiktok2"
        ),
        Joke(
            setup: "What did the ocean say to the beach?",
            punchline: "Nothing, it just waved!",
            imageName: "tiktok3"
        ),
        Joke(
            setup: "Why do cows wear bells?",
            punchline: "Because their horns don't work!",
            imageName: "tiktok"
        ),
    ]
    
    private var index = 0
    
    weak var output: JokesInteractorOutputProtocol?
    
    func loadFirstJoke() {
        index = 0
        sendCurrentJoke()
    }
    
    func loadNextJoke() {
        //move the bookmark forward by 1. If that runs past the end, wrap back to 0.
        index = (index + 1) % jokesArray.count
        sendCurrentJoke()
    }
    
    //A helper function
    //Work out whether we're on the last joke: is the bookmark equal to the number of jokes minus 1?
    //Then tell the listener: 'Here is the joke at the bookmark, and here's whether it's the last one.'
    private func sendCurrentJoke() {
        let isLast = index == jokesArray.count - 1
        output?.didLoadJoke(jokesArray[index], isLast: isLast)
    }
    
}
