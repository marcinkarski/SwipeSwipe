import UIKit

class CardView: UIView {
    
    private let image = UIImageView(image: #imageLiteral(resourceName: "lady5c"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        layer.cornerRadius = 12
        layer.masksToBounds = true
        image.contentMode = .bottom
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
//        NSLayoutConstraint.activate([image.leadingAnchor.constraint(equalTo: self.leadingAnchor), image.topAnchor.constraint(equalTo: self.topAnchor), image.trailingAnchor.constraint(equalTo: self.trailingAnchor), image.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
