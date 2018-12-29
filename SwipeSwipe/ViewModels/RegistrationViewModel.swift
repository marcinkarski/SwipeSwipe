import UIKit
import Firebase

class RegistrationViewModel {
    
    var binableIsRegistering = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    var bindableFormObsever = Bindable<Bool>()
    
    var name: String? { didSet {checkForm()}}
    var email: String? { didSet {checkForm()}}
    var password: String? { didSet {checkForm()}}
    
    func performRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else { return }
        self.binableIsRegistering.value = true
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(error)
                return
            }
            self.saveImageToFirestore(completion: completion)
        }
    }
    
    private func saveImageToFirestore(completion: @escaping (Error?) -> ()) {
        let filename = UUID().uuidString
        let reference = Storage.storage().reference(withPath: "/images/\(filename)")
        let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.5) ?? Data()
        reference.putData(imageData, metadata: nil, completion: { (_, error) in
            if let error = error {
                completion(error)
                return
            }
            print("Upload complete")
            reference.downloadURL(completion: { (url, error) in
                if let error = error {
                    completion(error)
                    return
                }
                self.binableIsRegistering.value = false
                let imageUrl = url?.absoluteString ?? ""
                self.saveInfoToFirestore(imageUrl: imageUrl, completion: completion)
            })
        })
    }
    
    private func saveInfoToFirestore(imageUrl: String, completion: @escaping (Error?) -> ()) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let docData = ["name": name ?? "", "uid": uid, "imageUrl1": imageUrl]
        Firestore.firestore().collection("users").document(uid).setData(docData) { (error) in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    private func checkForm() {
        let isFormValid = name?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableFormObsever.value = isFormValid
    }
}
