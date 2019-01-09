import UIKit

class SettingsInputCell: UITableViewCell {
    
    class TextField: UITextField {
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 16, dy: 0)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 16, dy: 0)
        }
        
        override var intrinsicContentSize: CGSize {
            return .init(width: 0, height: 50)
        }
    }
    
    let textField: UITextField = {
        let textField = TextField()
        textField.placeholder = "Enter name"
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(textField)
        textField.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
