extension RowConfiguration {

  public func boxedToAny() -> RowConfiguration<Any> {
    return RowConfiguration<Any>(
      identifier: identifier,
      cellClass: cellClass,
      configurator: { anyValue, cell in
        guard let value = anyValue as? T else {
          fatalError()
        }
        return self.configurator(value, cell)
      },
      handler: { anyValue in
        guard let handler = self.selectionHandler else {
          return
        }
        guard let value = anyValue as? T else {
          fatalError()
        }
        return handler(value)
      }
    )
  }
}
