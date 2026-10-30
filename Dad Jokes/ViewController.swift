//
//  ViewController.swift
//  Dad Jokes
//
//  Created by Chloe Tay on 12/10/26.
//

import UIKit

class ViewController: UIViewController {
    
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
    ]
    
    
    var setupLabel = UILabel()
    var whatButton = UIButton(type: .system)
    var punchlineLabel = UILabel()
    var continueLabel = UILabel()
    //starts empty; assign the picture in setupUI().
    var reactionImageView = UIImageView()
    
    // Tracks which joke we're currently showing.
    // `var` not `let` because it changes every time the user taps.
    var index = 0

    // The object that detects taps anywhere on the screen.
    // a property (not a local variable) so we can enable/disable it later
    let tapGesture = UITapGestureRecognizer()
    
    let stack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupUI()
        setupLayout()
        showJoke() // display the first joke (index starts at 0)
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
        

        // .scaleAspectFit shrinks the image to fit WITHOUT stretching or distorting it
        reactionImageView.contentMode = .scaleAspectFit
    
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
        stack.addArrangedSubview(reactionImageView)
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
            //without a fixed height, the image could take up the whole screen
            reactionImageView.heightAnchor.constraint(equalToConstant: 160),
        ])
    }
    
    //MARK: showing jokes
     //Shows the joke at `index` in its starting state: setup visible, punchline and hint hidden, waiting for "What?".
    private func showJoke() { //Having this in one place means we dn repeat these lines (refactoring)
        setupLabel.text = jokesArray[index].setup
        punchlineLabel.text = jokesArray[index].punchline
        // Load this joke's picture by the name stored in the struct.
        reactionImageView.image = UIImage(named: jokesArray[index].imageName)

        punchlineLabel.isHidden = true
        continueLabel.isHidden = true
        reactionImageView.isHidden = true

        // the user should press "What?" not tap the screen
        whatButton.isEnabled = true
        tapGesture.isEnabled = false
    }
    
     //Pop up asking if the user liked the joke
    private func showFeedbackAlert() {
        // .alert style = the centered pop-up box
        let alert = UIAlertController(
            title: "Did you like it?",
            message: nil,
            preferredStyle: .alert
        )

      //Each UIAlertAction becomes a button. Without a handler, tapping just closes the alert, ignore answer for now
        alert.addAction(UIAlertAction(title: "yes", style: .default))
        alert.addAction(UIAlertAction(title: "no", style: .default))

      //`present` shows it on top of the current screen
        present(alert, animated: true)
    }
    
    
    //MARK: actions
    @objc func whatButtonPressed(){
        //to check that the tap works
        //print("What? button was pressed")
        //Make the punchline visible
        punchlineLabel.isHidden = false
        continueLabel.isHidden = false
        reactionImageView.isHidden = false
        
        //Now the user should tap the screen, not the button
        whatButton.isEnabled = false
        tapGesture.isEnabled = true
        
        // Wait 1 second, then run the code inside the { } braces.
        // This gives the user time to read the punchline before the alert appears.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // If the user already tapped ahead to the next joke, the punchline is hidden again,
            // so skip the alert (otherwise it would pop up on the wrong joke).
            if !self.punchlineLabel.isHidden {
                self.showFeedbackAlert()
            }
        }
        
    }
    
    @objc func screenTapped() {
        //With 3 jokes: 0→1, 1→2, and (2 + 1) % 3 = 0, so we loop back to the start.
        index = (index + 1) % jokesArray.count
        
        showJoke()
    }
    
    
}

//MARK: but user can press anywhere for next joke before the pop up even appears


#Preview{
    ViewController()
}
