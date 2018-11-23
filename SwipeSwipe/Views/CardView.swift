import UIKit

class CardView: UIView {
    
    private let image = UIImageView(image: #imageLiteral(resourceName: "img1"))
    private let treshold: CGFloat = 100

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 12
        clipsToBounds = true
        image.contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        image.fillSuperview()
        
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
            let shouldDismissCard = gesture.translation(in: self).x > treshold
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                if shouldDismissCard {
                    self.frame = CGRect(x: 1000, y: 0, width: self.frame.width, height: self.frame.height)
                } else {
                    self.transform = .identity
                }
            }) { (_) in
                self.transform = .identity
                self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
            }
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
