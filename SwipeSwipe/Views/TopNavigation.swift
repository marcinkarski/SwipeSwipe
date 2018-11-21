import UIKit

class TopNavigation: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let images = [#imageLiteral(resourceName: "top_left_profile"), #imageLiteral(resourceName: "app_icon"), #imageLiteral(resourceName: "top_right_messages")].map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        
        images.forEach { (view) in
            addArrangedSubview(view)
        }
        
        distribution = .equalCentering
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
