//
//  JokesViewController.swift
//  Dad Jokes
//
//  Created by Chloe Tay on 30/10/26.
//

import UIKit

class JokesViewController: UIViewController, JokesViewProtocol {
    
    var presenter: JokesPresenterProtocol?
    
    var setupLabel = UILabel()
    var whatButton = UIButton(type: .system)
    var punchlineLabel = UILabel()
    var continueLabel = UILabel()

    // The object that detects taps anywhere on the screen.
    // a property (not a local variable) so we can enable/disable it later
    let tapGesture = UITapGestureRecognizer()
    
    let stack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupUI()
        setupLayout()
        presenter?.viewDidLoad()
    }
    
    private func setupUI(){
        //set up label
        //.setup reads the setup property from that Joke struct.
        //setupLabel.text = jokesArray[index].setup
        setupLabel.font = .preferredFont(forTextStyle: .title1)
        setupLabel.textAlignment = .center
        setupLabel.numberOfLines = 0
        
        //what button
        var config = UIButton.Configuration.filled()
        config.title = "What?"
        config.buttonSize = .large
        whatButton.configuration = config
        //button functionality
        whatButton.addTarget(self, action: #selector(whatButtonPressed), for: .touchUpInside)
        
        //punchline label
        //punchlineLabel.text = jokesArray[index].punchline
        //Hide the punchline until the user taps "What?"
        //punchlineLabel.isHidden = true
        punchlineLabel.font = .preferredFont(forTextStyle: .title3)
        punchlineLabel.textAlignment = .center
        punchlineLabel.numberOfLines = 0
        
        //continue label
        continueLabel.text = "tap anywhere for more"
        continueLabel.font = .preferredFont(forTextStyle: .body)
        continueLabel.textColor = .secondaryLabel
        continueLabel.textAlignment = .center
        continueLabel.numberOfLines = 0
        //only show this once the punchline is visible
        //continueLabel.isHidden = true
        
    
        //stack alignment
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        //add views
        stack.addArrangedSubview(setupLabel)
        stack.addArrangedSubview(whatButton)
        stack.addArrangedSubview(punchlineLabel)
        stack.addArrangedSubview(continueLabel)
        view.addSubview(stack)
        
        //Target-action again: "when a tap is recognized, tell `self` to run screenTapped"
        tapGesture.addTarget(self, action: #selector(screenTapped))
        //Attach the recognizer to the main view so a tap anywhere triggers it
        view.addGestureRecognizer(tapGesture)

    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    //MARK: showing jokes
    //Shows the joke the Presenter gives us, hiding or showing the punchline as told.
    func showJoke(setup: String, punchline: String, isPunchlineVisible: Bool){
        setupLabel.text = setup
        punchlineLabel.text = punchline

        // "!" means "the opposite": hidden when the punchline is NOT visible
        punchlineLabel.isHidden = !isPunchlineVisible
        continueLabel.isHidden = !isPunchlineVisible

        // before the punchline: press "What?"; after it: tap the screen
        whatButton.isEnabled = !isPunchlineVisible
        tapGesture.isEnabled = isPunchlineVisible
    }
    
    //Pop up with a title and message chosen by the Presenter
    func showMessage(title: String, message: String) {
        // .alert style = the centered pop-up box
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

      //Each UIAlertAction becomes a button. Without a handler, tapping just closes the alert, ignore answer for now
        alert.addAction(UIAlertAction(title: "OK", style: .default))

      //`present` shows it on top of the current screen
        present(alert, animated: true)
    }
    
    
    //MARK: actions
    @objc func whatButtonPressed(){
        presenter?.didTapShowPunchline()
    }
    
    @objc func screenTapped() {
        presenter?.didTapNext()
    }
    
    
    
    
}

//MARK: but user can press anywhere for next joke before the pop up even appears


#Preview{
    JokesViewController()
}
