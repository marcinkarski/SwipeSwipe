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
        let cardView = CardView(frame: .zero)
//        cardView.contentMode = .scaleAspectFill
//        cardView.clipsToBounds = true
        cardDeckView.addSubview(cardView)
        NSLayoutConstraint.activate([cardView.leadingAnchor.constraint(equalTo: cardDeckView.leadingAnchor), cardView.topAnchor.constraint(equalTo: cardDeckView.topAnchor), cardView.trailingAnchor.constraint(equalTo: cardDeckView.trailingAnchor), cardView.bottomAnchor.constraint(equalTo: cardDeckView.bottomAnchor)])
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [topStackView, cardDeckView, bottomStackView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor), stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor), stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
    }
}
