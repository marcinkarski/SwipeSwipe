import UIKit

struct Advert: MakeCardViewModel {
    let title: String
    let brandName: String
    let posterName: String
    
    init(title: String, brandName: String, posterName: String) {
        self.title = title
        self.brandName = brandName
        self.posterName = posterName
    }
    
    func toCardViewModel() -> CardViewModel {
        let attibutedString = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 28, weight: .bold)])
        attibutedString.append(NSAttributedString(string: "\n" + brandName, attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .heavy)]))
        
        return CardViewModel(images: [posterName], attributedString: attibutedString, textAlignment: .center)
    }
}
