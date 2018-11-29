import UIKit

struct Place: MakeCardViewModel {
    let images: [String]
    let name: String
    let type: String
    
    init(images: [String], name: String, type: String) {
        self.images = images
        self.name = name
        self.type = type
    }
    
    func toCardViewModel() -> CardViewModel {
        let attibutedString = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)])
        attibutedString.append(NSAttributedString(string: "\n\(type)", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .heavy)]))
        return CardViewModel(images: images, text: attibutedString, textAlignment: .left)
    }
}
