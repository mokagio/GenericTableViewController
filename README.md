# GenericTableViewController

A `UIViewController` subclass displaying a table view that can be configured
in a _generic_ way. Ideal to be used as a child view controller to quickly
display simple lists.

⚠️ This is very early stages ⚠️

```swift
let configuration = TableViewConfiguration<Int>(
	// the array of data to show
	data: [1,2,3,4,5],
	// the configuration information for the rows
	rowsConfiguration: RowConfiguration<Int>(
		identifier: "cell",
		cellClass: UITableViewCell.self,
		// the function to use to configure the dequeued cell with the value for
		// its index path
		configurator: { value, cell in
			cell.textLabel?.text = "\(value)"
			return cell
		}
	)
)

let genericTableViewController = GenericTableViewController()
// Being an Objective-C class UIViewController doesn't support generics the
// way Swift does, so we need to "box" our configuration in <T> into <Any>.
genericTableViewController.tableViewConfigurator = configuration.boxedToAny()
```

## Upcoming features

- Multiple row types support (_WIP_)
- Init the view controller via a generic function
- _Have you got a suggestion? Open an issue please!_ 😃

---

(c) 2016 - Giovanni Lodi [@mokagio](https://twitter.com/mokagio)
