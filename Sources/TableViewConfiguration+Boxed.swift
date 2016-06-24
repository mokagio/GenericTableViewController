extension TableViewConfiguration {

  public func boxedToAny() -> TableViewConfiguration<Any> {
    let boxedConfigurations: [CellConfiguration<Any>] = cellsConfigurations.map { $0.boxedToAny() }
    return TableViewConfiguration<Any>(
      data: data.map { $0 },
      cellsConfigurations: boxedConfigurations,
      identifierForIndex: identifierForIndex
    )
  }
}
