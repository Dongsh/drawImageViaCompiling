//
//  Lexter.swift
//  cstring
//
//  Created by Dongsh on 15/12/11.
//  Copyright © 2015年 Dongsh All rights reserved.
//

import Foundation

public enum Token {
    case Define
    case Identifier(String)
    case Number(Double)
    case ParensOpen
    case ParensClose
    case Comma
    case Other(String)
}

typealias TokenGenerator = (String) -> Token?

//let tokenList: [(String, TokenGenerator)] = [
//    ("[ \t\n]", { _ in nil }),
//    ("[a-zA-Z][a-zA-Z0-9]*", { $0 == "def" ? .Define : .Identifier($0) }),
//    ("[0-9.]+", { (r: String) in .Number((r as NSString).floatValue) }),
//    ("\\(", { _ in .ParensOpen }),
//    ("\\)", { _ in .ParensClose }),
//    (",", { _ in .Comma }),
//]

public class LexerRE {
    let input: String
    init(input: String) {
        self.input = input
    }
    
    public func tokenize() -> [Token] {
        var tokens = [Token]()
        var content:NSString = input
        
        var syn = 0
        var p = 0
        var m = 0
        var n = 0
        var row = 0
        var sum:Double = 0
        let PI = 3.141592653589793
        
        let rw = ["ORIGIN","SCALE","ROT","IS","TO","STEP","DRAW","FOR","FROM","PI","SIN","COS","TEN"]     //保留字集合
        
        var prog:NSMutableArray = [String()]
//        var nToken:NSMutableArray = [String()]
        var ch:NSString = String()
        
        //        while (content.characters.count > 0) {
        //
        //
        //        }
        
        let maxI = content.length
        for var i in 0..<maxI{
            let a = content.substringToIndex(1)
            prog[i] = a
            if !content.isEqualTo(""){
                content = content.substringFromIndex(1)
            }
            i++
        }
        
        
        repeat{
            var nToken:NSMutableArray = [String()]
            
            ch = prog[p++] as! NSString
            while ch.isEqualToString(" "){
                ch = prog[p] as! NSString
                p++
            }
            
            if (ch.characterAtIndex(0) >= 97 && ch.characterAtIndex(0) <= 122)||(ch.characterAtIndex(0)>=65 && ch.characterAtIndex(0)<=90){
                m = 0
                while(ch.characterAtIndex(0) >= 97 && ch.characterAtIndex(0) <= 122)||(ch.characterAtIndex(0)>=65 && ch.characterAtIndex(0)<=90)||(ch.characterAtIndex(0) >= 48 && ch.characterAtIndex(0) <= 57){
                    nToken[m++] = ch
                    if p > prog.count-1  {
                        break
                    } else {
                        ch = prog[p++] as! NSString
                    }
                }
                nToken[m++] = "\0"
                p--
                syn = 10
                
                var temp:NSString = nToken.componentsJoinedByString("");
                
                temp = temp.substringToIndex(temp.length-1)
                //最后一位为空影响判断 故减去
                
                for i in 0..<rw.count{
                    
                    let tempRW:NSString = rw[i]
                    if (temp.caseInsensitiveCompare(tempRW as String) == NSComparisonResult.OrderedSame ) {
                        //                    ---- 保留字 ----
                        if i == 9 {
                            let t = Token.Number(PI)
                            tokens.append(t)
                            break
                        } else {
                            syn = i+70
                            let t = Token.Identifier(tempRW as String)
                            tokens.append(t)
                            break
                        }
                    }
                    
                }
            } else if(ch.characterAtIndex(0) >= 48 && ch.characterAtIndex(0) <= 57){
                
                //                    ---- 数字 ----
                sum = 0;
                while(ch.characterAtIndex(0) >= 48 && ch.characterAtIndex(0) <= 57){
                    
                    sum = (Double)(ch.characterAtIndex(0)) + (Double)(sum * 10-48)
                    ch = prog[p++] as! NSString
                }
                
                if ch.isEqualTo("."){
                    ch = prog[p++] as! NSString
                    var temi = 0;
                    var sum2:Double = 0
                    while(ch.characterAtIndex(0) >= 48 && ch.characterAtIndex(0) <= 57){
                        sum2 = (Double)(ch.characterAtIndex(0)) + (Double)(sum2 * 10-48)
                        temi++
                        ch = prog[p++] as! NSString
                    }
                    while temi > 0 {
                        sum2 = sum2/10
                        temi--
                    }
                    sum = sum + sum2
                }
                p--
                syn = 11
                let t = Token.Number(sum)
                tokens.append(t)
                
            } else {
                switch ch {
                case"<":
                    m=0
                    nToken[m++]=ch
                    ch=prog[p++] as! NSString
                    if(ch==">"){
                        syn=21
                        nToken[m++]=ch
                        let t = Token.Other("<>")
                        tokens.append(t)
                    }   else if(ch=="="){
                        syn=22
                        nToken[m++]=ch
                        let t = Token.Other("<=")
                        tokens.append(t)
                    }   else    {
                        syn=23
                        let t = Token.Other("<")
                        tokens.append(t)
                        p--
                    }
                    
                case">":
                    m=0
                    nToken[m++]=ch
                    ch=prog[p++] as! NSString
                    if(ch=="="){
                        syn=24
                        let t = Token.Other(">=")
                        tokens.append(t)
                        nToken[m++]=ch
                    }   else    {
                        syn=20
                        let t = Token.Other(">")
                        tokens.append(t)
                        p--
                    }
                    
                case":":
                    m=0
                    nToken[m++]=ch
                    ch=prog[p++] as! NSString
                    if(ch=="="){
                        syn=18
                        nToken[m++]=ch
                        let t = Token.Other(":=")
                        tokens.append(t)
                    }   else    {
                        syn=17
                        let t = Token.Other(":")
                        tokens.append(t)
                        p--
                    }
                    
                case"+":
                    syn=13
                    let t = Token.Other(ch as String)
                    tokens.append(t)
                    nToken[0]=ch
                case"-":syn=14
                let t = Token.Other(ch as String)
                tokens.append(t)
                nToken[0]=ch
                case"*":
                    if(prog[p].isEqualTo("*")){
                        syn = 16
                        p++;
                        nToken = ["*","*"]
                        let t = Token.Other("**")
                        tokens.append(t)
                        
                    } else {
                        let t = Token.Other(ch as String)
                        tokens.append(t)
                        syn=15
                        nToken[0] = ch
                    }
                    
                case"/":
                    let t = Token.Other(ch as String)
                    tokens.append(t)
                    syn=17
                    nToken[0]=ch
                case";":    syn=26
                let t = Token.Other(ch as String)
                tokens.append(t)
                nToken[0]=ch
                case"(":    syn=27
                let t = Token.ParensOpen
                tokens.append(t)
                nToken[0]=ch
                case")":    syn=28
                let t = Token.ParensClose
                tokens.append(t)
                nToken[0]=ch
                case".":
                    let t = Token.Other(ch as String)
                    tokens.append(t)
                    //                syn = -1    //若语句中单独出现.则直接判错
                    nToken[0]=ch
                case",":    syn=30
                let t = Token.Comma
                tokens.append(t)
                nToken[0] = ch
                    
                case"#":syn=0
                nToken[0]=ch
                case"\n":
                    syn = -2;
                default:
                    syn = (-1)
                    
                }
            }
            
        }while syn != 0
        
        return tokens
    }
}