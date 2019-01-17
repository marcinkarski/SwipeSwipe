import UIKit
import Firebase
import SDWebImage
import JGProgressHUD

class ImagePickerController: UIImagePickerController {
    var imageButton: UIButton?
}

class SettingsController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var image1Button = createButton(selector: #selector(handleSelectPhoto))
    lazy var image2Button = createButton(selector: #selector(handleSelectPhoto))
    
    @objc private func handleSelectPhoto(button: UIButton) {
        let imagePicker = ImagePickerController()
        imagePicker.delegate = self
        imagePicker.imageButton = button
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        let imageButton = (picker as? ImagePickerController)?.imageButton
        imageButton?.setImage(selectedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true)
        let filename = UUID().uuidString
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Uploading image"
        hud.show(in: view)
        guard let uploadData = selectedImage?.jpegData(compressionQuality: 0.75) else { return }
        let reference = Storage.storage().reference(withPath: "/images/\(filename)")
        reference.putData(uploadData, metadata: nil) { (nil, error) in
            if let error = error {
                hud.dismiss()
                print("Failed to upload image", error)
                return
            }
            print("Uploaded image")
            reference.downloadURL(completion: { (url, error) in
                hud.dismiss()
                if let error = error {
                    print("Can't retreive url", error)
                    return
                }
                print("Finished getting url", url?.absoluteString ?? "")
                if imageButton == self.image1Button {
                    self.place?.imageUrl1 = url?.absoluteString
                } else {
                    self.place?.imageUrl2 = url?.absoluteString
                }
//                self.place?.imageUrl1 = url?.absoluteString
//                self.place?.imageUrl2 = url?.absoluteString
            })
        }
    }
    
    private func createButton(selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Select photo", for: .normal)
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(white: 0.8, alpha: 1).cgColor
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    lazy var header: UIView = {
        let header = UIView()
        let stackView = UIStackView(arrangedSubviews: [image1Button, image2Button])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 16
        stackView.spacing = padding
        header.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: padding).isActive = true
        stackView.topAnchor.constraint(equalTo: header.topAnchor, constant: padding).isActive = true
        stackView.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -padding).isActive = true
        stackView.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -padding).isActive = true
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .interactive
        fetchCurrentUser()
    }
    
    var place: Place?
    
    private func fetchCurrentUser() {
        guard let currentUser = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(currentUser).getDocument { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            guard let dictionary = snapshot?.data() else { return }
            self.place = Place(dictionary: dictionary)
            self.loadPlacePhotos()
            self.tableView.reloadData()
        }
    }
    
    private func loadPlacePhotos() {
        if let imageUrl = place?.imageUrl1, let url = URL(string: imageUrl) {
            SDWebImageManager.shared().loadImage(with: url, options: .continueInBackground, progress: nil) { (image, _, _, _, _, _) in
                self.image1Button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
        if let imageUrl = place?.imageUrl2, let url = URL(string: imageUrl) {
            SDWebImageManager.shared().loadImage(with: url, options: .continueInBackground, progress: nil) { (image, _, _, _, _, _) in
                self.image2Button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
    }
    
    private func setupNavigationBar() {
        self.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave)), UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleCancel))]
    }
    
    @objc private func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc private func handleSave() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let docData = ["uid": uid, "name": place?.name ?? "", "imageUrl1": place?.imageUrl1 ?? "", "imageUrl2": place?.imageUrl2 ?? "", "type": place?.type ?? ""]
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Saving data"
        hud.show(in: view)
        Firestore.firestore().collection("users").document(uid).setData(docData) { (error) in
            hud.dismiss(animated: true)
            if let error = error {
                print("Failed to save", error)
                return
            }
            print("Saved")
            self.dismiss(animated: true)
        }
    }
}

class HeaderLabel: UILabel {
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 16, dy: 0))
    }
}

extension SettingsController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return header
        }
        let label = HeaderLabel()
        switch section {
        case 1:
            label.text = "Name"
        case 2:
            label.text = "Type"
        case 3:
            label.text = "Age"
        default:
            break
        }
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 300
        }
        return 40
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : 1
    }
    
    @objc private func handleMinAge(slider: UISlider) {
        print(slider.value)
    }
    
    @objc private func handleMaxAge(slider: UISlider) {
        print(slider.value)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 3 {
            let ageRangeCell = AgeRangeCell(style: .default, reuseIdentifier: nil)
            ageRangeCell.minSlider.addTarget(self, action: #selector(handleMinAge), for: .valueChanged)
            ageRangeCell.maxSlider.addTarget(self, action: #selector(handleMaxAge), for: .valueChanged)
            return ageRangeCell
        }
        
        let cell = SettingsInputCell(style: .default, reuseIdentifier: nil)
        switch indexPath.section {
        case 1:
            cell.textField.placeholder = "Enter name"
            cell.textField.text = place?.name
            cell.textField.addTarget(self, action: #selector(handleNameChange), for: .editingChanged)
        case 2:
            cell.textField.placeholder = "Enter type"
            cell.textField.text = place?.type
            cell.textField.addTarget(self, action: #selector(handleTypeChange), for: .editingChanged)
        default:
            break
        }
        return cell
    }
    
    @objc private func handleNameChange(textField: UITextField) {
        self.place?.name = textField.text
    }
    
    @objc private func handleTypeChange(textField: UITextField) {
        self.place?.type = textField.text
    }
}
