import UIKit

extension GenericTableViewController: UITableViewDelegate {

  public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    guard let configurator = tableViewConfigurator else {
      preconditionFailure(
        "Attempted to interact with the table view without providing a configurator"
      )
    }

    let identifier = configurator.identifierForIndex(indexPath.row)

    if let handler = configurator.rowsConfigurations
      .filter({ $0.identifier == identifier })
      .first?
      .selectionHandler {
      handler(configurator.data[indexPath.row])
    }

    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}
