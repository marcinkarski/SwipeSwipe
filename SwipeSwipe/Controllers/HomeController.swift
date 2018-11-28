import UIKit

class HomeController: UIViewController {
    
    private let topStackView = TopNavigation()
    private let cardDeckView = UIView()
    private let bottomStackView = BottomControls()
    
//    private let places = [Place(image: "img1", name: "Puerto del Carmen", type: "Beach"), Place(image: "img2", name: "Roque Nubio", type: "Viewpoint"), Place(image: "img3", name: "Caleta de Famara", type: "Restaurant"), Place(image: "img4", name: "Playa de La Teresitas", type: "Beach"), Place(image: "img5", name: "Montana Roja", type: "Viewpoint")]
    
    let viewModel = [Place(imageName: "img1", name: "Puerto del Carmen", type: "Beach").toCardViewModel()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        dummyCard()
    }
    
    private func dummyCard() {

        viewModel.forEach { (card) in
            let cardView = CardView(frame: .zero)
            cardView.imageView.image = UIImage(named: card.imageName)
            cardView.label.attributedText = card.text
            cardView.label.textAlignment = card.textAlignment
            cardDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
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
        
        stackView.bringSubviewToFront(cardDeckView)
    }
}
