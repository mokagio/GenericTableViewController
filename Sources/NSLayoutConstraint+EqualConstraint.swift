import Foundation

extension NSLayoutConstraint {

  /// Instantiates an `NSLayoutConstraint` that configures the given `attribute`
  /// as equal for the two given items.
  internal convenience init(
    equalingAttribute attribute: NSLayoutAttribute,
                      ofItem item: UIView,
                             toItem otherItem: UIView) {
    // ^____ That's Xcode 7.3.1 silly alignement...
    // I think it's worth keeping here for a laugh, lol.
    self.init(
      item: item,
      attribute: attribute,
      relatedBy: .Equal,
      toItem: otherItem,
      attribute: attribute,
      multiplier: 1,
      constant: 0
    )
  }
}
