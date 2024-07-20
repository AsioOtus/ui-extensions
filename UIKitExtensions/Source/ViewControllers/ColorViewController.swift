import UIKit

public typealias ColorVC = ColorViewController

public extension UIColor {
	func colorVC (name: String = "", foregroundColor: UIColor = .black, action: @escaping (ColorVC) -> Void = { _ in }) -> ColorVC { .init(backgroundColor: self) }
}

public extension ColorVC {
	static var red: ColorVC { .init(backgroundColor: .red) }
	static var green: ColorVC { .init(backgroundColor: .green) }
	static var blue: ColorVC { .init(backgroundColor: .blue) }
}

open class ColorViewController: UIViewController {
	private let translateMask: Bool
	public let backgroundColor: UIColor
	public let foregroundColor: UIColor
	public let name: String
	public let action: (ColorViewController) -> Void
	
	public let actionButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Action", for: .normal)
		button.setTitleColor(.systemBlue, for: .normal)
		return button
	}()
	
	public let nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 24)
		return label
	}()
	
	public init (name: String = "", backgroundColor: UIColor, foregroundColor: UIColor = .black, translateMask: Bool = false, action: @escaping (ColorViewController) -> Void = { _ in }) {
		self.backgroundColor = backgroundColor.set(alpha: 0.5)
		self.foregroundColor = foregroundColor
		self.name = name
		self.action = action
		
		self.translateMask = translateMask
		
		super.init(nibName: nil, bundle: nil)
	}
	
	public required init? (coder: NSCoder) { fatalError() }
	
	public override func viewDidLoad () {
		super.viewDidLoad()
	
		setupView()
		
		addActionButton()
		addNameLabel()
	}
}

private extension ColorVC {
	func setupView () {
		view.translatesAutoresizingMaskIntoConstraints = translateMask
		view.backgroundColor = backgroundColor
	}
	
	func addActionButton () {
		actionButton.addTarget(nil, action: #selector(buttonTapped), for: .touchUpInside)
		
		view.addSubview(actionButton)
		
		NSLayoutConstraint.activate([
			actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}
	
	func addNameLabel () {
		nameLabel.text = name
		nameLabel.textColor = foregroundColor
		nameLabel.sizeToFit()
		
		view.addSubview(nameLabel)
		
		NSLayoutConstraint.activate([
			nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			nameLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -16)
		])
	}
}

private extension ColorVC {
	@objc func buttonTapped () { action(self) }
}
