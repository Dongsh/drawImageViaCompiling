//
//  Lexter.swift
//  cstring
//
//  Created by Dongsh on 15/12/11.
//  Copyright © 2015年 Dongsh All rights reserved.
//

import Foundation


func scaner(){
    ch = prog[p++] as! NSString
    while ch.isEqualToString(" "){
        ch = prog[p] as! NSString
        p++
    }
    
    if (ch.characterAtIndex(0) >= 97 && ch.characterAtIndex(0) <= 122)||(ch.characterAtIndex(0)>=65 && ch.characterAtIndex(0)<=90){
        m = 0
        while(ch.characterAtIndex(0) >= 97 && ch.characterAtIndex(0) <= 122)||(ch.characterAtIndex(0)>=65 && ch.characterAtIndex(0)<=90)||(ch.characterAtIndex(0) >= 48 && ch.characterAtIndex(0) <= 57){
            token[m++] = ch
            if p > prog.count-1  {
                break
            } else {
                ch = prog[p++] as! NSString
            }
        }
        token[m++] = "\0"
        p--
        syn = 10
        
        var temp:NSString = token.componentsJoinedByString("");
        
        temp = temp.substringToIndex(temp.length-1)
        //最后一位为空影响判断 故减去
        
        for i in 0..<rw.count{
            
            let tempRW:NSString = rw[i]
            if (temp.caseInsensitiveCompare(tempRW as String) == NSComparisonResult.OrderedSame ) {
                if i == 9 {
                    syn = 99
                    break
                } else{
                    syn = i+1
                    break
                }
            }
            
        }
    } else if(ch.characterAtIndex(0) >= 48 && ch.characterAtIndex(0) <= 57){
        sum = 0;
        while(ch.characterAtIndex(0) >= 48 && ch.characterAtIndex(0) <= 57){
            
            sum = (Int)(ch.characterAtIndex(0))+(sum * 10-48)
            ch = prog[p++] as! NSString
        }
        p--
        syn = 11
        if sum > 32767{
            syn = -1
        }
    } else {
        switch ch {
        case"<":
            m=0
            token[m++]=ch
            ch=prog[p++] as! NSString
            if(ch==">"){
                syn=21
                token[m++]=ch
            }   else if(ch=="="){
                syn=22
                token[m++]=ch
            }   else    {
                syn=23
                p--
            }
        case">":
            m=0
            token[m++]=ch
            ch=prog[p++] as! NSString
            if(ch=="="){
                syn=24
                token[m++]=ch
            }   else    {
                syn=20
                p--
            }
            
        case":":
            m=0
            token[m++]=ch
            ch=prog[p++] as! NSString
            if(ch=="="){
                syn=18
                token[m++]=ch
            }   else    {
                syn=17
                p--
            }
            
        case"+":syn=13
        token[0]=ch
        case"-":syn=14
        token[0]=ch
        case"*":
            if(prog[p].isEqualTo("*")){
                syn = 16
                p++;
                token = ["*","*"]
            } else {
                syn=15
                token[0] = ch
            }
            
        case"/":
            syn=17
            token[0]=ch
//        case"**":syn=25
//        token[0]=ch
        case";":syn=26
        token[0]=ch
        case"(":syn=27
        token[0]=ch
        case")":syn=28
        token[0]=ch
        case".":syn=29
        token[0]=ch
        case",":syn=30
        token[0] = ch
        token[0]=ch
        case"#":syn=0
        token[0]=ch
        case"\n":
            syn = -2;
        default:
            syn = (-1)
            
        }
    }
}

//func aNodeS(type:Int,str:String){
//    
//}

func flowIntoNodeflow(){
    p = 0
    var flowNodeNum = 0;
    repeat{
        scaner()
        switch syn{
        case -1:
            print("ERROR in row \(row)! \n")
        case -2:
            row++
            
            
        case 99:        // ---- 常数π ----
            print("(Num,π)")
            let newNode = node.init(type:101 , inString:"", invalue: PI)
            nodeFlow.append(newNode);
            
        case 11:        // ---- 数字类 ----
            print("(Num,\(sum))")
            let newNode = node.init(type:101 , inString:"", invalue: Double(sum))
            nodeFlow.append(newNode);
            
            
        default:
            
            //           ---- 其他 ----
            
            var tempStr:String = String()
            for var i in 0..<token.count{
                
                var temp:NSString = token[i] as! NSString//.substringToIndex(1)
                tempStr += temp as String
            }                                   // 字符串还原
            
            if syn > 0 && syn <= 9{
                let symbol = rw[syn-1];
                tempStr = symbol
                let newNode = node.init(type:110+syn , inString:symbol, invalue:0)
                print("(Operator,",terminator:"")
                nodeFlow.append(newNode);
            } else if syn > 12 && syn <= 30 {
                let newNode = node.init(type:110+syn , inString:tempStr, invalue:0)
                nodeFlow.append(newNode);
                print("(MathOp,",terminator:"")
            } else {
                let newNode = node.init(type: 102, inString: tempStr, invalue: 0)
                nodeFlow.append(newNode);
                print("(String,",terminator:"")
            }
            
            print("\(tempStr))")
        }
        token = [String()]
        flowNodeNum++
    }while syn != 0

}

