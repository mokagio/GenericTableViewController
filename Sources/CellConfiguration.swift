import UIKit

struct CellConfiguration<T> {

  let identifier: String

  // It's called cellClass because class is restricted
  let cellClass: AnyClass

  let configurator: (T, UITableViewCell) -> UITableViewCell

  init(identifier: String,
       cellClass: AnyClass = UITableViewCell.self,
       configurator: (T, UITableViewCell) -> UITableViewCell) {
    self.identifier = identifier
    self.cellClass = cellClass
    self.configurator = configurator
  }
}
