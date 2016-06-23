import UIKit

extension GenericTableViewController: UITableViewDelegate {

  public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    guard let configurator = tableViewConfigurator else {
      preconditionFailure("Attempted to interact with the table view without providing a configurator")
    }

    let identifier = configurator.identifierForIndex(indexPath.row)

    guard let handler = configurator.cellsConfigurations
      .filter({ $0.identifier == identifier })
      .first?
      .selectionHandler else {
        return
    }

    handler(configurator.data[indexPath.row])
  }
}
