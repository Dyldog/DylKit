//
//  File.swift
//  
//
//  Created by Dylan Elliott on 23/6/2025.
//

import SwiftUI

public struct ResultView<Success, Failure: Error, SuccessView: View, FailView: View>: View {
    let result: Result<Success, Failure>?
    let success: (Success) -> SuccessView
    let failure: (Failure) -> FailView
    
    public init(
        result: Result<Success, Failure>?,
        success: @escaping (Success) -> SuccessView,
        failure: @escaping (Failure) -> FailView
    ) {
        self.result = result
        self.success = success
        self.failure = failure
    }
    
    public var body: some View {
        switch result {
        case .none:
            ProgressView().progressViewStyle(.circular)
        case .success(let data):
            success(data)
        case .failure(let error):
            failure(error)
        }
    }
}

public extension ResultView where Success: RandomAccessCollection {
    init<SuccessRow: View>(
        _ result: Result<Success, Failure>?,
        filter: @escaping (Success.Element) -> Bool = { _ in true },
        sort: @escaping (Success.Element, Success.Element) -> Bool = { _,_ in true },
        success: @escaping (Success.Element) -> SuccessRow,
        failure: @escaping (Failure) -> FailView
    ) where SuccessView == List<Never, ForEach<[(offset: Int, element: Success.Element)], Int, SuccessRow>> {
        self.init(
            result: result, 
            success: { data in
                List {
                    ForEach(data.filter { filter($0) }.sorted { sort($0, $1) }) {
                        success($0)
                    }
                }
            },
            failure: failure
        )
    }
}
