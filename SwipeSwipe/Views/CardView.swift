import UIKit

class CardView: UIView {
    
    let image = UIImageView(image: #imageLiteral(resourceName: "img1"))
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private let threshold: CGFloat = 100

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 12
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        addSubview(image)
        addSubview(label)
        image.fillSuperview()
        NSLayoutConstraint.activate([label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16), label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)])
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
     
        switch gesture.state {
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
