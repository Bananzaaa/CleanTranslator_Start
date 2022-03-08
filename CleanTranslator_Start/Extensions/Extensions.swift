//
//  Extensions.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 27.02.2022.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        if Bundle.main.path(forResource: cellClass.identifier, ofType: "nib") != nil {
            register(UINib(nibName: cellClass.identifier, bundle: nil), forCellReuseIdentifier: cellClass.identifier)
        } else {
            register(cellClass, forCellReuseIdentifier: cellClass.identifier)
        }
    }
    
    func dequeueReusableCellWithRegistration<T: UITableViewCell>(_ cellClass: T.Type) -> T {
        register(cellClass)
        let cell = dequeueReusableCell(cellClass)
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellClass.identifier) as? T else {
            fatalError("Error: cannot dequeue cell with identifier: \(cellClass.identifier)")
        }
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        self.register(T.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: cellClass.identifier, for: indexPath) as? T else {
            fatalError("Error: cannot dequeue cell with identifier: \(cellClass.identifier) " +
                "for index path: \(indexPath)")
        }
        return cell
    }
    // Remove TableFooterView.
    func removeTableFooterView() {
        tableFooterView = nil
    }
    
    // Clear TableFooterView.
    func clearTableFooterView() {
        tableFooterView = UIView()
    }
}

extension UITableViewCell {
    class var identifier: String {
        let result = String(describing: self)
        return result
    }
}
