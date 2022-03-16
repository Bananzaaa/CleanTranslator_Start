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

public extension UIViewController {
    
    /// Добавить дочерний контроллер и разместить его в определенной `view` к краям
    ///
    /// - Note: Все дочерние контроллеры которые были добавлены в эту `view` перед добавлением удаляются
    /// - Note: После добавления контроллера вызывается метод `setNeedsStatusBarAppearanceUpdate`
    ///
    /// - Parameters:
    ///   - childViewController: Дочерний контроллер
    ///   - containerView: `UIView` в которую нужно разместить дочерний контроллер
    func addChildViewController(_ childViewController: UIViewController, to containerView: UIView) {
        children.filter({ $0.view.superview == containerView }).forEach { $0.removeChildFromParent() }

        addChild(childViewController)
        containerView.addSubview(childViewController.view, with: containerView)
        childViewController.didMove(toParent: self)

        setNeedsStatusBarAppearanceUpdate()
    }
    
    /// Добавить дочерний контроллер и разместить его `view` к краям.
    ///
    /// - Parameters:
    ///   - child: Дочерний контроллер.
    ///   - guide: Края `view` дочернего контроллера.
    func addChildViewController(_ child: UIViewController, with guide: LayoutGuide) {

        addChild(child)
        view.addSubview(child.view, with: guide)
        child.didMove(toParent: self)
    }
    
    /// Добавить дочерний контроллер вместе с его `view` и активировать констрейнты.
    ///
    /// - Parameters:
    ///   - child: Дочерний контроллер.
    ///   - constraints: Констрейнты `view` дочернего контроллера.
    func addChildViewController(
        _ child: UIViewController,
        activate constraints: @autoclosure () -> [NSLayoutConstraint]) {
        
        addChild(child)
        view.addSubview(child.view, activate: constraints())
        child.didMove(toParent: self)
    }
    
    /// Удалить из родительского контроллера.
    func removeChildFromParent() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

/// Обобщенный тип лайаут гайда.
///
/// - Note: Обобщение `UIView` и `UILayoutGuide`.
public protocol LayoutGuide {
    /// Верхний край.
    var topAnchor: NSLayoutYAxisAnchor { get }
    /// Нижний край.
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    /// Правый край.
    var rightAnchor: NSLayoutXAxisAnchor { get }
    /// Левый край.
    var leftAnchor: NSLayoutXAxisAnchor { get }
}

extension UIView: LayoutGuide {}
extension UILayoutGuide: LayoutGuide {}

public extension UIView {
    
    /// Добавить сабвью вместе с лайаут гайдом.
    /// ```
    /// final class TextCell: UICollectionViewCell {
    ///     let textLabel = UILabel()
    ///
    ///     override init(frame: CGRect) {
    ///         super.init(frame: frame)
    ///         addSubview(textLabel, with: layoutMarginsGuide)
    ///         // addSubview(textLabel, with: self)
    ///     }
    /// }
    /// ```
    /// - Parameters:
    ///   - subview: Сабвью.
    ///   - guide: Гайд, к краям которого будет крепиться вью.
    func addSubview(_ subview: UIView, with guide: LayoutGuide) {
        assert((guide as? UIView) != subview, "Края сабвью не могут быть привазаны к ней же")
        addSubview(subview, activate: [
            subview.topAnchor.constraint(equalTo: guide.topAnchor),
            subview.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            subview.rightAnchor.constraint(equalTo: guide.rightAnchor),
            subview.leftAnchor.constraint(equalTo: guide.leftAnchor)
        ])
    }
    
    /// - Parameters:
    ///   - subview: Сабвью.
    ///   - guide: Гайд, к краям которого будет крепиться вью.
    ///   - insets: Отступы от краев гайда
    func addSubview(_ subview: UIView, with guide: LayoutGuide, _ insets: UIEdgeInsets) {
        assert((guide as? UIView) != subview, "Края сабвью не могут быть привазаны к ней же")
        addSubview(subview, activate: [
            subview.topAnchor.constraint(equalTo: guide.topAnchor, constant: insets.top),
            subview.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -insets.bottom),
            subview.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -insets.right),
            subview.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: insets.left)
        ])
    }
    
    /// Добавить сабвью и активировать констрейнты.
    ///
    /// - Parameters:
    ///   - subview: Сабвью.
    ///   - constraints: Констрейнты создаются из замыкания после, того как `subview` будет добавлена.
    func addSubview(_ subview: UIView, activate constraints: @autoclosure () -> [NSLayoutConstraint]) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate(constraints())
    }
    
    /// Добавить сабвью по определенному индексу вместе с лайаут гайдом.
    ///
    /// - Parameters:
    ///   - subview: Сабвью.
    ///   - index: Индекс, по которому стоит вставить сабвью.
    ///   - guide: Гайд, к краям которого будет крепиться вью.
    func insertSubview(_ subview: UIView, at index: Int, with guide: LayoutGuide) {
        assert((guide as? UIView) != subview, "Края сабвью не могут быть привазаны к ней же")
        insertSubview(subview, at: index, activate: [
            subview.topAnchor.constraint(equalTo: guide.topAnchor),
            subview.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            subview.rightAnchor.constraint(equalTo: guide.rightAnchor),
            subview.leftAnchor.constraint(equalTo: guide.leftAnchor)
        ])
    }
    
    /// - Parameters:
    ///   - subview: Сабвью.
    ///   - guide: Гайд, к краям которого будет крепиться вью.
    ///   - insets: Отступы от краев гайда
    func insertSubview(_ subview: UIView,
                       at index: Int,
                       with guide: LayoutGuide,
                       _ insets: UIEdgeInsets) {
        assert((guide as? UIView) != subview, "Края сабвью не могут быть привазаны к ней же")
        insertSubview(subview, at: index, activate: [
            subview.topAnchor.constraint(equalTo: guide.topAnchor, constant: insets.top),
            subview.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -insets.bottom),
            subview.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -insets.right),
            subview.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: insets.left)
        ])
    }
    
    /// Добавить сабвью по определенному индексу и активировать констрейнты.
    ///
    /// - Parameters:
    ///   - subview: Сабвью.
    ///   - index: Индекс, по которому стоит вставить сабвью.
    ///   - constraints: Констрейнты создаются из замыкания после, того как `subview` будет добавлена.
    func insertSubview(_ subview: UIView,
                       at index: Int,
                       activate constraints: @autoclosure () -> [NSLayoutConstraint]) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(subview, at: index)
        NSLayoutConstraint.activate(constraints())
    }
}
