//
//  node.swift
//  cstring
//
//  Created by Dongsh on 15/12/11.
//  Copyright © 2015年 jamszhy. All rights reserved.
//

import Foundation

public protocol ExprNode: CustomStringConvertible {
}

public struct NumberNode: ExprNode {
    public let value: Double
    public var description: String {
        return "NumberNode(\(value))"
    }
}

public struct VariableNode: ExprNode {
    public let name: String
    public var description: String {
        return "VariableNode(\(name))"
    }
}

public struct BinaryOpNode: ExprNode {
    public let op: String
    public let lhs: ExprNode
    public let rhs: ExprNode
    public var description: String {
        return "BinaryOpNode(\(op), lhs: \(lhs), rhs: \(rhs))"
    }
}

public struct CallNode: ExprNode {
    public let callee: String
    public let arguments: [ExprNode]
    public var description: String {
        return "CallNode(name: \(callee), argument: \(arguments))"
    }
}

public struct PrototypeNode: CustomStringConvertible {
    public let name: String
    public let argumentNames: [String]
    public var description: String {
        return "PrototypeNode(name: \(name), argumentNames: \(argumentNames))"
    }
}

public struct FunctionNode: CustomStringConvertible {
    public let prototype: PrototypeNode
    public let body: ExprNode
    public var description: String {
        return "FunctionNode(prototype: \(prototype), body: \(body))"
    }
}