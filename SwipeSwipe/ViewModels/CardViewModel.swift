import UIKit

protocol MakeCardViewModel {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    let images: [String]
    let text: NSAttributedString
    let alignment: NSTextAlignment
    
    init(images: [String], text: NSAttributedString, textAlignment: NSTextAlignment) {
        self.images = images
        self.text = text
        self.alignment = textAlignment
    }
}
