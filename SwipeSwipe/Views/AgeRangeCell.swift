import UIKit

class AgeRangeCell: UITableViewCell {
    
    let minSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 100
        return slider
    }()
    
    let minLabel: UILabel = {
        let label = Label()
        label.text = "Min"
        return label
    }()
    
    let maxSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 100
        return slider
    }()
    
    let maxLabel: UILabel = {
        let label = Label()
        label.text = "Max"
        return label
    }()
    
    class Label: UILabel {
        override var intrinsicContentSize: CGSize {
            return .init(width: 80, height: 0)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let stackView = UIStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [minLabel, minSlider]), UIStackView(arrangedSubviews: [maxLabel, maxSlider])])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        addSubview(stackView)
        NSLayoutConstraint.activate([stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16), stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16), stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
