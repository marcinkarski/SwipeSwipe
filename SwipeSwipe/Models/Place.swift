import UIKit

struct Place: MakeCardViewModel {
    let uid: String
    var imageUrl1: String?
    var name: String?
    var type: String?
    
    init(dictionary: [String: Any]) {
        
        self.uid = dictionary["uid"] as? String ?? ""
        self.imageUrl1 = dictionary["imageUrl1"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.type = dictionary["type"] as? String ?? ""
    }
    
    func toCardViewModel() -> CardViewModel {
        let typeString = type != nil ? type! : ""
        let attibutedString = NSMutableAttributedString(string: name ?? "", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)])
        attibutedString.append(NSAttributedString(string: "\n\(typeString)", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .heavy)]))
        return CardViewModel(images: [imageUrl1 ?? ""], text: attibutedString, textAlignment: .left)
    }
}
