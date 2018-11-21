import UIKit

class ViewController: UIViewController {
    
    let topStackView = TopNavigation()
    let cardDeckView = UIView()
    let bottomStackView = BottomControls()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        dummyCard()
    }
    
    private func dummyCard() {
        
        
    }
    
    private func setup() {
        view.backgroundColor = .white

        cardDeckView.backgroundColor = .yellow
        
        let stackView = UIStackView(arrangedSubviews: [topStackView, cardDeckView, bottomStackView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor), stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor), stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
}
