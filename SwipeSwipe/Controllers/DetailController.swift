import UIKit

class DetailController: UIViewController {
    
    var viewModel: CardViewModel! {
        didSet {
            label.attributedText = viewModel.attributedString
            swipePhotosController.viewModel = viewModel
        }
    }
    
    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        scrollView.backgroundColor = .white
        return scrollView
    }()

    let swipePhotosController = SwipePhotosController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    lazy private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Roque Nublo\nGran Canaria"
        label.numberOfLines = 0
        return label
    }()
    
    lazy private var dismissButton: UIButton = {
        let image = UIImage(named: "dismiss")
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    lazy var dislikeButton = self.createButton(image: UIImage(named: "dislike")!, selector: #selector(handleDislike))
    lazy var superlikeButton = self.createButton(image: UIImage(named: "super_like_circle")!, selector: #selector(handleSuperlike))
    lazy var likeButton = self.createButton(image: UIImage(named: "like_circle")!, selector: #selector(handleLike))
    
    @objc private func handleDislike() {
        
    }
    
    @objc private func handleSuperlike() {
        
    }
    
    @objc private func handleLike() {
        
    }
    
    private func createButton(image: UIImage, selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.contentMode = .scaleAspectFit
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        let imageView = swipePhotosController.view!
        scrollView.addSubview(imageView)
//        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        scrollView.addSubview(label)
        scrollView.addSubview(dismissButton)
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16), label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16), label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor), dismissButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -25), dismissButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -16)])
        setupBottomControlls()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let imageView = swipePhotosController.view!
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
    }
    
    private func setupBottomControlls() {
        let stackView = UIStackView(arrangedSubviews: [dislikeButton, superlikeButton, likeButton])
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .horizontal
        stackView.spacing = 8
        view.addSubview(stackView)
        NSLayoutConstraint.activate([stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0), stackView.heightAnchor.constraint(equalToConstant: 80), stackView.widthAnchor.constraint(equalToConstant: view.frame.width)])
    }
    
    @objc private func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let changeY = -scrollView.contentOffset.y
        var width = view.frame.width + changeY * 2
        width = max(view.frame.width, width)
        let origin = min(0, -changeY)
        let imageView = swipePhotosController.view!
        imageView.frame = CGRect(x: origin, y: origin, width: width, height: width)
    }
}
