import UIKit
import Firebase
import JGProgressHUD

class HomeController: UIViewController {
    
    private let topStackView = TopNavigation()
    private let cardDeckView = UIView()
    private let bottomStackView = BottomControls()
    
//    let viewModel: [CardViewModel] = {
//        let makers = [Place(images: ["img1", "img2"], name: "Puerto del Carmen", type: "Beach"), Place(images: ["img2"], name: "Roque Nubio", type: "Viewpoint"), Place(images: ["img3"], name: "Caleta de Famara", type: "Restaurant"), Place(images: ["img4"], name: "Playa de La Teresitas", type: "Beach"), Place(images: ["img1", "img2", "img3"], name: "Montana Roja", type: "Viewpoint"), Advert(title: "Must See", brandName: "Gran Canaria", posterName: "img1")] as [MakeCardViewModel]
//        let viewModel = makers.map({return $0.toCardViewModel()})
//        return viewModel
//    }()
    
    var viewModel = [CardViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        bottomStackView.refreshButton.addTarget(self, action: #selector(handleRefreshButton), for: .touchUpInside)
        setup()
        setupCards()
        fetchUsersFromFirestore()
    }
    
    @objc private func handleRefreshButton() {
        fetchUsersFromFirestore()
    }
    
    var lastFetchedPlace: Place?
    
    private func fetchUsersFromFirestore() {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Fetching places"
        hud.show(in: view)
        let query = Firestore.firestore().collection("users").order(by: "uid").start(after: [lastFetchedPlace?.uid ?? ""]).limit(to: 2)
        query.getDocuments { (snapshot, error) in
            hud.dismiss()
            if let error = error {
                print("Failed to fetch users: \(error)")
                return
            }
            snapshot?.documents.forEach({ (documentSnapshot) in
                let userDictionary = documentSnapshot.data()
                let place = Place(dictionary: userDictionary)
                self.viewModel.append(place.toCardViewModel())
                self.lastFetchedPlace = place
                self.setupCardFromPlace(place: place)
            })
//            self.setupCards()
        }
    }
    
    private func setupCardFromPlace(place: Place) {
        let cardView = CardView(frame: .zero)
        cardView.cardViewModel = place.toCardViewModel()
        cardDeckView.addSubview(cardView)
        cardDeckView.sendSubviewToBack(cardView)
        cardView.fillSuperview()
    }
    
    @objc private func handleSettings() {
        let registrationController = RegistrationController()
        present(registrationController, animated: true, completion: nil)
    }
    
    private func setupCards() {
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
