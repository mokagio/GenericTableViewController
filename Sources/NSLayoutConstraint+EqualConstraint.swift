import Foundation

extension NSLayoutConstraint {

  /// Instantiates an `NSLayoutConstraint` that configures the given `attribute`
  /// as equal for the two given items.
  internal convenience init(
    equalingAttribute attribute: NSLayoutAttribute,
    ofItem item: UIView,
    toItem otherItem: UIView
  ) {
    self.init(
      item: item,
      attribute: attribute,
      relatedBy: .equal,
      toItem: otherItem,
      attribute: attribute,
      multiplier: 1,
      constant: 0
    )
  }
}
