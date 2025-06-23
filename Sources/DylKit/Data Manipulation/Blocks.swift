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

public typealias AsyncBlock = () async -> Void
public typealias AsyncBlockIn<T> = (T) async -> Void
public typealias AsyncBlockOut<T> = () async -> T
public typealias AsyncBlockInOut<S, T> = (S) async -> T

public typealias ThrowingBlock = () throws -> Void
public typealias ThrowingBlockIn<T> = (T) throws -> Void
public typealias ThrowingBlockOut<T> = () throws -> T
public typealias ThrowingBlockInOut<S, T> = (S) throws -> T
