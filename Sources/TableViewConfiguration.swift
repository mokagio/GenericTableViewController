import UIKit

struct TableViewConfiguration<T> {

  let data: [T]

  let cellsConfigurations: [CellConfiguration<T>]

  let identifierForIndex: Int -> String
}