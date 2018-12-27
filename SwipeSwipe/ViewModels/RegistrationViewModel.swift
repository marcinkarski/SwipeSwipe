import UIKit

class RegistrationViewModel {
    
    var bindableImage = Bindable<UIImage>()
    
//    var image: UIImage? {
//        didSet {
//            imageObserver?(image)
//        }
//    }
//    var imageObserver: ((UIImage?) -> ())?
    
    var name: String? { didSet {checkForm()}}
    var email: String? { didSet {checkForm()}}
    var password: String? { didSet {checkForm()}}
    
    private func checkForm() {
        let isFormValid = name?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableFormObsever.value = isFormValid
//        formObserver?(isFormValid)
    }
    var bindableFormObsever = Bindable<Bool>()
//    var formObserver: ((Bool) -> ())?
}
