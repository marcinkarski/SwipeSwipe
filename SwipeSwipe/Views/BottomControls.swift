import UIKit

class BottomControls: UIStackView {
    
    static func createButton(image: UIImage) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        return button
    }
    
    let dislikeButton = createButton(image: #imageLiteral(resourceName: "dismiss_circle"))
    let refreshButton = createButton(image: #imageLiteral(resourceName: "refresh_circle"))
    let likeButton = createButton(image: #imageLiteral(resourceName: "like_circle"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        [dislikeButton, refreshButton, likeButton].forEach { (button) in
            self.addArrangedSubview(button)
        }
        
//        let images = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "like_circle")].map { (image) -> UIView in
//            let button = UIButton(type: .system)
//            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
//            return button
//        }
//
//        images.forEach { (view) in
//            addArrangedSubview(view)
//        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
