import UIKit

class CardView: UIView {
    
    private let image = UIImageView(image: #imageLiteral(resourceName: "img1"))

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
            transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        case .ended:
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                self.transform = .identity
            }) { (_) in
                
            }
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
