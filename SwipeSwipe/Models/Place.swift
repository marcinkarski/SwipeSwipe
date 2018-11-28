import UIKit

struct Place {
    let imageName: String
    let name: String
    let type: String
    
    func toCardViewModel() -> CardViewModel {
        let attibutedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)])
        attibutedText.append(NSAttributedString(string: "\n\(type)", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .heavy)]))
        return CardViewModel(imageName: imageName, text: attibutedText, textAlignment: .left)
    }
}
