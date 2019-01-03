import UIKit

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
        (picker as? ImagePickerController)?.imageButton?.setImage(selectedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.tableFooterView = UIView()
    }
    
    private func setupNavigationBar() {
        self.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleCancel)), UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleCancel))]
    }
    
    @objc private func handleCancel() {
        dismiss(animated: true)
    }
}

extension SettingsController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
}
