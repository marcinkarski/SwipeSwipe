import UIKit

class HomeController: UIViewController {
    
    private let topStackView = TopNavigation()
    private let cardDeckView = UIView()
    private let bottomStackView = BottomControls()
    
    let viewModel: [CardViewModel] = {
        let makers = [Place(images: ["img1", "img2"], name: "Puerto del Carmen", type: "Beach"), Place(images: ["img2"], name: "Roque Nubio", type: "Viewpoint"), Place(images: ["img3"], name: "Caleta de Famara", type: "Restaurant"), Place(images: ["img4"], name: "Playa de La Teresitas", type: "Beach"), Place(images: ["img1", "img2", "img3"], name: "Montana Roja", type: "Viewpoint"), Advert(title: "Must See", brandName: "Gran Canaria", posterName: "img1")] as [MakeCardViewModel]
        let viewModel = makers.map({return $0.toCardViewModel()})
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        setup()
        dummyCard()
    }
    
    @objc private func handleSettings() {
        let registrationController = RegistrationController()
        present(registrationController, animated: true, completion: nil)
    }
    
    private func dummyCard() {
        viewModel.forEach { (card) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = card
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
