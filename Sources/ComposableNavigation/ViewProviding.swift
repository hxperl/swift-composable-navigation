import UIKit
import SwiftUI

public protocol ViewProviding {
	associatedtype Item: Hashable
	func makePresentable(for navigationItem: Item) -> Presentable
}

public extension ViewProviding {
	func makeViewController(for navigationItem: Item) -> UIViewController {
    makePresentable(for: navigationItem).viewController
	}
}

public protocol Presentable {
	var viewController: UIViewController { get }
}

extension UIViewController: Presentable {
	public var viewController: UIViewController {
		self
	}
}

extension View where Self: Presentable {
	public var viewController: UIViewController {
    BaseHostingViewController(rootView: self)
	}
}

class BaseHostingViewController<Content: View>: UIHostingController<Content> {
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    self.navigationController?.isNavigationBarHidden = true
    self.navigationController?.navigationBar.isHidden = true
  }
}
