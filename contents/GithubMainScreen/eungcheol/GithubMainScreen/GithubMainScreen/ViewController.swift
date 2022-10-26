import UIKit

import Then

final class ViewController: UIViewController {
  
  // MARK: - Properties
  
  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupStyles()
    setupNavigationBar()
  }
  
  // MARK: - Setup
  
  private func setupStyles() {
  }
  
  private func setupNavigationBar() {
    let gearButton = UIButton()
    let shareButton = UIButton()
    gearButton.setImage(UIImage(systemName: Symbols.gear.imageName), for: .normal)
    shareButton.setImage(UIImage(systemName: Symbols.share.imageName), for: .normal)
    [gearButton, shareButton]
      .forEach { $0.setPreferredSymbolConfiguration(.init(pointSize: 24), forImageIn: .normal) }
    
    let buttonStack = UIStackView(arrangedSubviews: [gearButton, shareButton])
    buttonStack.axis = .horizontal
    buttonStack.spacing = 16
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonStack)    
  }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ViewControllerPreView: PreviewProvider {
  static var previews: some View {
    ViewController().toPreview()
  }
}
#endif
