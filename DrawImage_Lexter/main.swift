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
var nodeFlow:Array<node> = []



// ----- main Func ------

func main(){
    
    p = 0
    row = 1
    print("Please input string:")
    
   
    
    var tempString = UnsafeMutablePointer<CChar>.alloc(100)
    getString(tempString)
    let resString = String.fromCString(tempString)
    
    
    var inputString:NSString = resString!
    
    var  maxI = inputString.length
    for var i in 0..<maxI{
        let a = inputString.substringToIndex(1)
        prog[i] = a
        if !inputString.isEqualTo(""){
            inputString = inputString.substringFromIndex(1)
        }
        
    }
    
    flowIntoNodeflow()

//    print("\n\n\n")

}

main()









