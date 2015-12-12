//
//  parser.swift
//  DrawImage_Lexter
//
//  Created by Dongsh on 15/12/11.
//  Copyright © 2015年 Dongsh. All rights reserved.
//

import Foundation

struct exprNode{
    var include:node
    enum content{
        struct caseOp{
            var left:exprNode
            var right:exprNode
        }
        struct caseFunc{
            var child:exprNode
            var funNum:Int
        }
    }
}

enum Errors: ErrorType {
    case UnexpectedToken
//    case UndefinedOperator(String)
    case ExpectedCharacter(Character)
    case ExpectedExpression
    case ExpectedArgumentList
    case ExpectedFunctionName
}

var Parameter = 0,
    Origin_x=0,
    Origin_y=0,
    Scale_x=1,
    Scale_y=1,
    Rot_angle=0;

var currentNode:node = nodeFlow[0]//node.init(type: 0, inString: "", invalue: 0)
var index = 0
var predictType = 0

func peekCurrentNode() ->node{
    return nodeFlow[index]
}

func popCurrentNode()->node{
    return nodeFlow[index++]
}



func parserNum() throws ->ExprNode{
    var tempNode = popCurrentNode();
    if tempNode.type != predictType {
        throw Errors.UnexpectedToken
    }
    //    return NumberNode(value,value)
    var numNode:NumberNode
    numNode.value = tempNode.inValue as Float
    return numNode
}



