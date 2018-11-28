import UIKit

struct Place: MakeCardViewModel {
    let imageName: String
    let name: String
    let type: String
    
    init(imageName: String, name: String, type: String) {
        self.imageName = imageName
        self.name = name
        self.type = type
    }
    
    func toCardViewModel() -> CardViewModel {
        let attibutedString = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)])
        attibutedString.append(NSAttributedString(string: "\n\(type)", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .heavy)]))
        return CardViewModel(imageName: imageName, text: attibutedString, textAlignment: .left)
    }
}
