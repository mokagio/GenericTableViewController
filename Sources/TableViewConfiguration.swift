import UIKit

public struct TableViewConfiguration<T> {

  public let data: [T]

  public let cellsConfigurations: [CellConfiguration<T>]

  public let identifierForIndex: Int -> String

  public init(data: [T], cellsConfigurations: [CellConfiguration<T>], identifierForIndex: Int -> String) {
    self.data = data
    self.cellsConfigurations = cellsConfigurations
    self.identifierForIndex = identifierForIndex
  }
}
