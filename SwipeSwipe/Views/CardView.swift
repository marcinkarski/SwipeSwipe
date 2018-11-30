import UIKit

class CardView: UIView {
    
    var cardViewModel: CardViewModel! {
        didSet {
            let imageName = cardViewModel.images.first ?? ""
            imageView.image = UIImage(named: imageName)
            label.attributedText = cardViewModel.text
            label.textAlignment = cardViewModel.alignment
            
            (0..<cardViewModel.images.count).forEach { (_) in
                let barView = UIView()
                barView.backgroundColor = barDeselectedColour
                pageControl.addArrangedSubview(barView)
            }
            pageControl.arrangedSubviews.first?.backgroundColor = .white
        }
    }
    
    private let threshold: CGFloat = 150
    private let gradient = CAGradientLayer()
    private var imageIndex = 0
    private let barDeselectedColour = UIColor(white: 0, alpha: 0.1)
    
    private let pageControl: UIStackView = {
        let pageControl = UIStackView()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let imageView: UIImageView = {
        let image = UIImage(named: "img1")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
 
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 12
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        setupGradient()
        setupPageControl()
        addSubview(label)
        imageView.fillSuperview()
        
        
        NSLayoutConstraint.activate([label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16), label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)])
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleTap(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        let shouldAdvanceNextPhoto = location.x > frame.width / 2 ? true : false
        if shouldAdvanceNextPhoto {
            imageIndex = min(imageIndex + 1, cardViewModel.images.count - 1)
        } else {
            imageIndex = max(0, imageIndex - 1)
        }
        let imageName = cardViewModel.images[imageIndex]
        imageView.image = UIImage(named: imageName)
        pageControl.arrangedSubviews.forEach { (view) in
            view.backgroundColor = barDeselectedColour
        }
        pageControl.arrangedSubviews[imageIndex].backgroundColor = .white
    }
    
    private func setupPageControl() {
        addSubview(pageControl)
        NSLayoutConstraint.activate([pageControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), pageControl.topAnchor.constraint(equalTo: topAnchor, constant: 16), pageControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16), pageControl.heightAnchor.constraint(equalToConstant: 2)])
        pageControl.spacing = 4
        pageControl.distribution = .fillEqually
    }
    
    private func setupGradient() {
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.6, 1.2]
        layer.addSublayer(gradient)
    }
    
    override func layoutSubviews() {
        gradient.frame = self.frame
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            let translation = gesture.translation(in: self)
            let degrees: CGFloat = translation.x / 20
            let angle = degrees * .pi / 180
            let rotation = CGAffineTransform(rotationAngle: angle)
            transform = rotation.translatedBy(x: translation.x, y: translation.y)
        case .ended:
            let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
            let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                if shouldDismissCard {
                    self.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
                } else {
                    self.transform = .identity
                }
            }) { (_) in
                self.transform = .identity
                if shouldDismissCard {
                    self.removeFromSuperview()
                }
            }
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
