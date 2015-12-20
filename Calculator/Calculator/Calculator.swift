//
//  Calculator.swift
//  Calculator
//
//  Created by 安正超 on 15/10/21.
//  Copyright © 2015年 overtrue. All rights reserved.
//

import Foundation

public class Calculator {
    var stack = [Op]()
    
    enum Operator: String {
        case Times = "×"
        case Devide = "÷"
        case Add = "+"
        case Minus = "-"
        case Clean = "ac"
    }
    
    enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(Operator, (Double, Double) -> Double)
    }
    
    var operations = [Operator: Op]()
    
    init() {
        operations[Operator.Add] = Op.BinaryOperation(.Add, +)
        operations[Operator.Minus] = Op.BinaryOperation(.Minus, { $0 - $1 })
        operations[Operator.Times] = Op.BinaryOperation(.Times, *)
        operations[Operator.Devide] = Op.BinaryOperation(.Devide, {$0 / $1 })
    }
    
    func pushOperand(operand:Double) -> [Op] {
        stack.append(Op.Operand(operand))
        
        return stack
    }
    
    func performanceOperation(symbol: String) -> [Op] {
        if let operation = operations[(Operator(rawValue: symbol))!] {
            stack.append(operation)
        }
        
        return stack
    }
    
    func calculate() -> Double? {
        return calculate(stack).result
    }
    
    func calculate(st: [Op]) -> (result: Double?, remainOps: [Op]) {
        var result = 0.1
        
        
        return (nil, st)
    }
}