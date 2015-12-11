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


var Parameter = 0,
    Origin_x=0,
    Origin_y=0,
    Scale_x=1,
    Scale_y=1,
    Rot_angle=0;

var scanNode:node = node.init(type: 0, inString: "", invalue: 0)
var nodeInReadingNum = 0

var NONTOKEN = 0

func syntaxERROR(caseOfError:Int){
    switch caseOfError{
    case 1:
        print("Error Mark")
    case 2:
        print("Not the predict Mark")
    default: break
    }

}

func fetchToken(){
    scanNode = nodeFlow[nodeInReadingNum]
}

func matchToken(nodeType:Int){
    if nodeType != scanNode.type{
        syntaxERROR(2)
    }
    fetchToken()
}

func parserStart(){
    print("----Now we will start parser----")
    fetchToken()
//    program()
}

//func program(){
//    while(NONTOKEN != scanNode.type){
//        statement()
//        matchToken(<#T##nodeType: Int##Int#>)
//    }
//}












