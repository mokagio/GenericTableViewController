import UIKit

public struct RowConfiguration<T> {

  public let identifier: String

  // It's called cellClass because class is restricted
  public let cellClass: AnyClass

  public let configurator: (T, UITableViewCell) -> UITableViewCell

  public let selectionHandler: ((T) -> ())?

  public init(identifier: String,
       cellClass: AnyClass = UITableViewCell.self,
       configurator: @escaping (T, UITableViewCell) -> UITableViewCell,
       handler: ((T) -> ())? = .none
    ) {
    self.identifier = identifier
    self.cellClass = cellClass
    self.configurator = configurator
    self.selectionHandler = handler
  }
}
