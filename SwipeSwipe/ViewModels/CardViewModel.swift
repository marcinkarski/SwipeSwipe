import UIKit

protocol MakeCardViewModel {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    let imageName: String
    let text: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageName: String, text: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageName = imageName
        self.text = text
        self.textAlignment = textAlignment
    }
}
