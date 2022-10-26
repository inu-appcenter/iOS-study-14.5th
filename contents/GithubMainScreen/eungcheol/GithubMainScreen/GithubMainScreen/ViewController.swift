import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
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

