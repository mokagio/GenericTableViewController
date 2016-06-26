import UIKit

public struct TableViewConfiguration<T> {

  public let data: [T]

  public let rowsConfigurations: [RowConfiguration<T>]

  public let identifierForIndex: Int -> String

  public init(data: [T], rowsConfigurations: [RowConfiguration<T>], identifierForIndex: Int -> String) {
    self.data = data
    self.rowsConfigurations = rowsConfigurations
    self.identifierForIndex = identifierForIndex
  }

  public init(data: [T], rowsConfiguration: RowConfiguration<T>) {
    self.init(
      data: data,
      rowsConfigurations: [rowsConfiguration],
      identifierForIndex: { _ in return rowsConfiguration.identifier }
    )
  }
}
