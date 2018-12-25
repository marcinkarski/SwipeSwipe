import UIKit

class RegistrationViewModel {
    var name: String? { didSet {checkForm()}}
    var email: String? { didSet {checkForm()}}
    var password: String? { didSet {checkForm()}}
    
    private func checkForm() {
        let isFormValid = name?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        formObserver?(isFormValid)
    }
    
    var formObserver: ((Bool) -> ())?
}
