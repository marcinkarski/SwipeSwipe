import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
        let redView = UIView()
        redView.backgroundColor = .red
        let blueView = UIView()
        blueView.backgroundColor = .blue
        let stackView = UIStackView(arrangedSubviews: [redView, blueView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor), stackView.topAnchor.constraint(equalTo: view.topAnchor), stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor), stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}
