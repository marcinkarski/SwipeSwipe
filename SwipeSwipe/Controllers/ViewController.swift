import UIKit

class ViewController: UIViewController {
    
    let topStackView = TopNavigation()
    let middleView = UIView()
    let bottomStackView = BottomControls()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white

        middleView.backgroundColor = .yellow
        
        let stackView = UIStackView(arrangedSubviews: [topStackView, middleView, bottomStackView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor), stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor), stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
}
