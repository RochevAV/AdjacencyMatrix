//
//  Matrix.swift
//  AdjacencyMatrix
//
//  Created by Aleksey Rochev on 12/02/2017.
//  Copyright © 2017 AlekseyRochev. All rights reserved.
//

import Foundation

class Matrix {
    
    let matrix : [[UInt8]]
    
    var countNodes : Int {
        return matrix.count
    }
    
    // MARK: - Init
    
    init(fromString string: String) {
        matrix = Matrix.matrixFrom(string)
    }
    
    // MARK: - Nodes
    
    func nodes() -> [[String]] {
        
        var nodes : [[String]] = []
        for (index, _) in matrix.enumerated() {
            nodes.append(self.nodesFor(node: index))
        }
        
        return nodes
    }
    
    func nodesFor(node : Int) -> [String] {
        
        var nodes : [String] = []
        for (index, item) in matrix[node].enumerated() {
            if item > 0 {
                nodes.append("\(node):\(index)")
            }
        }
        
        return nodes
    }
    
    // MARK: - Static Methods
    
    private static func matrixFrom(_ string : String) -> [[UInt8]]{
        
        let items = uint8Array(from: string)
        let (i, j) = sizeSquareMatrixFor(array: items)
        
        var matrix : [[UInt8]] = []
        
        for (index, _) in items[0..<Int(i)].enumerated() {
            
            var row : [UInt8] = []
            let (start, end) = confinesFor(chunk: index, chunkSize: Int(j))
            
            for item in items[start...end] {
                row.append(item)
            }
            
            matrix.append(row)
        }
        
        return matrix
    }
    
    private static func uint8Array(from string:String) -> [UInt8] {
        let array = string.components(separatedBy: " ")
        return array.flatMap{UInt8($0)}
    }
    
    private static func sizeSquareMatrixFor(array : Array<Any>) -> (UInt, UInt) {
        
        let count  = Double(array.count)
        let (i,j) = (sqrt(count), sqrt(count))
        
        return (UInt(i), UInt(j))
    }
    
    private static func confinesFor(chunk: Int, chunkSize: Int) -> (start : Int, end : Int) {
        
        let start = chunk * Int(chunkSize)
        let end = start + chunkSize - 1
        
        return (start, end)
    }
}

// MARK: - Extension for description

extension Matrix : CustomStringConvertible {
    
    public var description: String {
        var string = ""
        for item in matrix {
            for value in item {
                string += "\(value) "
            }
            string += "\n"
        }
        
        return string
    }
}
