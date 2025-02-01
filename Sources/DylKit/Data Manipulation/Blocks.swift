//
//  Blocks.swift
//  MovieCal
//
//  Created by Dylan Elliott on 19/2/2023.
//

import Foundation

public typealias Block = () -> Void
public typealias BlockIn<T> = (T) -> Void
public typealias BlockOut<T> = () -> T
public typealias BlockInOut<S, T> = (S) -> T
