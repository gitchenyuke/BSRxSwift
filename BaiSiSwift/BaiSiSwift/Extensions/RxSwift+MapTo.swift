//
//  RxSwift+MapTo.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/21.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import RxSwift
import RxCocoa

public extension ObservableType {
    
    func map<T>(to transform: @escaping @autoclosure () throws -> T) -> Observable<T> {
        return map { _ in try transform() }
    }
    
    func flatMap<T>(to transform: @escaping @autoclosure () throws -> Observable<T>) -> Observable<T> {
        return flatMap { _ in try transform() }
    }
}

public extension Driver {
    
    func map<T>(to transform: @escaping @autoclosure () -> T) -> SharedSequence<S, T> {
        return map { _ in transform() }
    }
    
    func flatMap<T>(to transform: @escaping @autoclosure () -> SharedSequence<S, T>) -> SharedSequence<S, T> {
        return flatMap { _ in transform() }
    }
}

public extension ObservableType {
    
    func shareOnce() -> Observable<E> {
        return share(replay: 1, scope: .forever)
    }
}
public extension Reactive where Base: UIView {
    var endEditing: Binder<Bool> {
        return Binder(self.base) { view , editing in
            view.endEditing(editing)
        }
    }
}

public extension Reactive where Base: NotificationCenter {
    var postNotification: Binder<Bool>{
        return Binder(self.base) { notificationCenter , post in
            if post {
                notificationCenter.post(name: NSNotification.Name("popLoginVC"), object: nil, userInfo: nil)
            }
        }
    }
}
