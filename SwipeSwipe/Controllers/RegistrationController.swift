import UIKit
import Firebase
import JGProgressHUD

//class RegistrationTextView: UIView {
//
//    private let registrationViewModel = RegistrationViewModel()
////    private lazy var stackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField])
//
//    let nameTextField: TextField = {
//        let textField = TextField(padding: 16)
//        textField.placeholder = "Enter full name"
//        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
//        return textField
//    }()
//
//    let emailTextField: TextField = {
//        let textField = TextField(padding: 16)
//        textField.placeholder = "Enter email"
//        textField.keyboardType = .emailAddress
//        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
//        return textField
//    }()
//
//    let passwordTextField: TextField = {
//        let textField = TextField(padding: 16)
//        textField.placeholder = "Enter password"
//        textField.isSecureTextEntry = true
//        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
//        return textField
//    }()
//
//    @objc private func handleTextChange(textField: UITextField) {
//        switch textField {
//        case nameTextField:
//            registrationViewModel.name = textField.text
//        case emailTextField:
//            registrationViewModel.email = textField.text
//        case passwordTextField:
//            registrationViewModel.password = textField.text
//        default:
//            break
//        }
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        stackView.axis = .vertical
//        stackView.spacing = 8
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(stackView)
//        stackView.fillSuperview()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

class RegistrationController: UIViewController {
    
    let registrationViewModel = RegistrationViewModel()
//    private lazy var registrationTextView = RegistrationTextView()
    
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 300).isActive = true
        button.layer.cornerRadius = 16
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleSelectPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    let nameTextField: TextField = {
        let textField = TextField(padding: 16)
        textField.placeholder = "Enter full name"
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()

    let emailTextField: TextField = {
        let textField = TextField(padding: 16)
        textField.placeholder = "Enter email"
        textField.keyboardType = .emailAddress
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()

    let passwordTextField: TextField = {
        let textField = TextField(padding: 16)
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()

    @objc private func handleTextChange(textField: UITextField) {
        switch textField {
        case nameTextField:
            registrationViewModel.name = textField.text
        case emailTextField:
            registrationViewModel.email = textField.text
        case passwordTextField:
            registrationViewModel.password = textField.text
        default:
            break
        }
    }
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .lightGray
        button.setTitleColor(.gray, for: .normal)
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    let goToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(handleGoToLogin), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleGoToLogin() {
        let loginController = LoginController()
        navigationController?.pushViewController(loginController, animated: true)
    }
    
    let registerHUD = JGProgressHUD(style: .light)
    @objc private func handleRegister() {
        self.handleTapDismiss()

        registrationViewModel.performRegistration { [weak self] (error) in
            if let error = error {
                self?.showHUD(error: error)
                return
            }
            print("Finished registering a user")
        }
    }
    
    private func showHUD(error: Error) {
        registerHUD.dismiss(animated: true)
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Failed to register a user"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotification()
        setupGradient()
        setupTap()
        setupRegistrationObserver()
        layout()
    }
    
    private func setupRegistrationObserver() {
        registrationViewModel.bindableFormObsever.bind { [unowned self] (isFormValid) in
            self.registerButton.isEnabled = true
            guard let isFormValid = isFormValid else { return }
            if isFormValid {
                self.registerButton.backgroundColor = .purple
                self.registerButton.setTitleColor(.white, for: .normal)
            } else {
                self.registerButton.backgroundColor = .lightGray
                self.registerButton.setTitleColor(.gray, for: .disabled)
            }
        }
//        registrationViewModel.formObserver = { [unowned self] (isFormValid) in
//            self.registerButton.isEnabled = true
//            if isFormValid {
//                self.registerButton.backgroundColor = .purple
//                self.registerButton.setTitleColor(.white, for: .normal)
//            } else {
//                self.registerButton.backgroundColor = .lightGray
//                self.registerButton.setTitleColor(.gray, for: .disabled)
//            }
//        }
        registrationViewModel.bindableImage.bind { [unowned self] (image) in
            self.selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        registrationViewModel.binableIsRegistering.bind { [unowned self] (isRegistering) in
            if isRegistering == true {
                self.registerHUD.textLabel.text = "Register"
                self.registerHUD.show(in: self.view)
            } else {
                self.registerHUD.dismiss()
            }
        }
        
//        registrationViewModel.imageObserver = { [unowned self] image in
//        }
    }
    
    private func setupTap() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc func handleTapDismiss() {
        self.view.endEditing(true)
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    @objc private func handleKeyboard(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
//        print(keyboardFrame)
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [selectPhotoButton, nameTextField, emailTextField, passwordTextField, registerButton])
    
    fileprivate func layout() {
        navigationController?.isNavigationBarHidden = true
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        goToLoginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        view.addSubview(goToLoginButton)
        NSLayoutConstraint.activate([stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32), stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32), stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor), goToLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor), goToLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor), goToLoginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    let gradient = CAGradientLayer()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradient.frame = view.bounds
    }
    
    private func setupGradient() {
        let topColour = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        let bottomColour = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        gradient.colors = [topColour.cgColor, bottomColour.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.bounds
    }
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        registrationViewModel.bindableImage.value = image
//        registrationViewModel.image = image
        dismiss(animated: true)
    }
}
