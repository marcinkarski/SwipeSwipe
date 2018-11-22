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
        let translation = gesture.translation(in: self)
        print(translation.x)
        transform = CGAffineTransform(translationX: translation.x, y: translation.y)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
