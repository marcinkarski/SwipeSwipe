import UIKit

class SwipePhotosController: UIPageViewController {
    
    var viewModel: CardViewModel! {
        didSet {
            controllers = viewModel.images.map({ (image) -> UIViewController in
                let photoController = PhotoController(imageUrl: image)
                return photoController
            })
            setViewControllers([controllers.first!], direction: .forward, animated: false, completion: nil)
            setupBars()
        }
    }
    
    private let stackViewBars = UIStackView(arrangedSubviews: [])
    
    private func setupBars() {
        viewModel.images.forEach { (_) in
            let barView = UIView()
            barView.backgroundColor = .white
            stackViewBars.addArrangedSubview(barView)
            stackViewBars.translatesAutoresizingMaskIntoConstraints = false
            stackViewBars.spacing = 8
            stackViewBars.distribution = .fillEqually
        }
        view.addSubview(stackViewBars)
        NSLayoutConstraint.activate([stackViewBars.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16), stackViewBars.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16), stackViewBars.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                     stackViewBars.heightAnchor.constraint(equalToConstant: 2)])
    }

    var controllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
    }
}

extension SwipePhotosController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where: {$0 == viewController}) ?? 0
        if index == controllers.count - 1 { return nil }
        return controllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where: {$0 == viewController}) ?? 0
        if index == 0 { return nil }
        return controllers[index - 1]
    }
}

class PhotoController: UIViewController {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "img3"))
    
    init(imageUrl: String) {
        if let url = URL(string: imageUrl) {
            imageView.sd_setImage(with: url)
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
