//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import UIKit

class ArrayTableViewDataSource<Model: Equatable, CellType: UITableViewCell>: NSObject, UITableViewDataSource
        where CellType: ModelTransfer, CellType.ModelType == Model {

    // MARK: - Public Variables

    private(set) var items = [ Model ]()

    // MARK: - Public

    func updateWith(items: [Model]) {
        self.items = items
    }

    func append(items: [Model]) {
        self.items.append(contentsOf: items)
    }

    func replace(item: Model, at index: Int) {
        guard items.count > index else {
            return
        }

        items[index] = item
    }

    func objectAtIndexPath(_ indexPath: IndexPath) -> Model {
        return items[indexPath.row]
    }

    func indexPathForObject(_ object: Model) -> IndexPath? {
        guard let index = items.firstIndex(of: object) else {
            return nil
        }
        return IndexPath(row: index, section: 0)
    }

    func indexPathForObject(_ searchBlock: (Model) -> Bool) -> IndexPath? {
        for (index, item) in items.enumerated() {
            if searchBlock(item) {
                return IndexPath(row: index, section: 0)
            }
        }
        return nil
    }

    func removeObjectAtIndexPath(_ indexPath: IndexPath) -> Model? {
        if items.count > indexPath.row {
            return items.remove(at: indexPath.row)
        }
        return nil
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count > 0 ? 1 : 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = CellType.reuseIdentifier()
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CellType

        let model = items[indexPath.row]
        cell.update(with: model)

        return cell
    }
}
