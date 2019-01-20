import UIKit

protocol MakeCardViewModel {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    let images: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(images: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.images = images
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    private var imageIndex = 0 {
        didSet {
            let imageUrl = images[imageIndex]
//            let image = UIImage(named: imageName)
            imageIndexObserver?(imageIndex, imageUrl)
        }
    }
    
    var imageIndexObserver: ((Int, String?) -> ())?
    
    func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, images.count - 1)
    }
    
    func goToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
}
