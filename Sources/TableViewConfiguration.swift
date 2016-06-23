import UIKit

public struct TableViewConfiguration<T> {

  public let data: [T]

  public let cellsConfigurations: [CellConfiguration<T>]

  public let identifierForIndex: Int -> String
}