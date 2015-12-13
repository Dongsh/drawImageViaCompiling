//
//  main.swift
//  cstring
//
//  Created by Dongsh.
//  Copyright (c) 2015年 Dongsh.dev. All rights reserved.
//

import Foundation




var prog:NSMutableArray = [String()]
var token:NSMutableArray = [String()]
var ch:NSString = String()

var syn = 0
var p = 0
var m = 0
var n = 0
var row = 0
var sum:Double = 0
let PI = 3.141592653589793

var rw = ["ORIGIN","SCALE","ROT","IS","TO","STEP","DRAW","FOR","FROM","PI","SIN","COS","TEN"]     //保留字集合

//var flow2Node:NSMutableDictionary = []
//var nodeFlow:Array<node> = []



// ----- main Func ------


    
    p = 0
    row = 1
    print("Please input string:")
    
   
    
    var tempString = UnsafeMutablePointer<CChar>.alloc(100)
    getString(tempString)
//    let resString = String.fromCString(tempString)

    
//    var inputString:NSString = resString!

    
    
    //let source = multiline(
    ////    "def foo(x, y)",
    ////    "  xa + y * 2 + (4+5) / 3",
    ////    "",
    ////    "foo(3,4)"
    //)
    
    let source = String.fromCString(tempString)
    
    let lexer = LexerRE(input: source!)
    print(lexer)
    let tokens = lexer.tokenize()
    print(tokens)
    
    print("\n")
    let parser = Parser(tokens: tokens)
    do {
        print(try parser.parse())
        
    }
    catch {
        print(error)
    }

    print("---- end ----")











