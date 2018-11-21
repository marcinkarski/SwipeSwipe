import UIKit

class BottomControls: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let images = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")].map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        
        images.forEach { (view) in
            addArrangedSubview(view)
        }
        
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
