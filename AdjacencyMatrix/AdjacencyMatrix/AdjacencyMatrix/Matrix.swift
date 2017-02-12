//
//  Matrix.swift
//  AdjacencyMatrix
//
//  Created by Aleksey Rochev on 12/02/2017.
//  Copyright © 2017 AlekseyRochev. All rights reserved.
//

import Foundation

struct Edge : CustomStringConvertible{
    var vertex1 : UInt
    var vertex2 : UInt
    
    var description : String {
        return "\(vertex1):\(vertex2)"
    }
}

class Matrix {
    
    // MARK: - Properties
    
    let matrix : [[UInt8]]
    
    var countVertex : Int {
        return matrix.count
    }
    
    // MARK: - Init
    
    init(withMatrix string: String) {
        matrix = Matrix.matrixFrom(string)
    }
    
    init(withEdges edges:Array<Edge>) {
        matrix = Matrix.matrixFrom(edges)
    }
    
    // MARK: - Edges
    
    func edges() -> [Edge] {
        
        var edges : [Edge] = []
        for (index, _) in matrix.enumerated() {
            
            if let edge = self.edgesFor(vertex: index) {
                edges += edge
            }
        }        
        return edges
    }
    
    func edgesFor(vertex : Int) -> [Edge]? {
        
        var edges : [Edge] = []
        for (index, item) in matrix[vertex][0...vertex].enumerated() {
            if item != 0 {
                
                let edge = Edge.init(vertex1: UInt(vertex) + 1, vertex2: UInt(index) + 1)
                edges.append(edge)
            }
        }
        
        return edges.isEmpty ? nil : edges
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
    
    private static func matrixFrom(_ edges: [Edge]) -> [[UInt8]] {
        
        let count = Matrix.countVertex(forEdges: edges)
        var matrix = Matrix.emptyMatrix(count: count)
        
        for edge in edges {
            let (i,j) = (Int(edge.vertex1) - 1, Int(edge.vertex2) - 1)
            matrix[i][j] = 1
            matrix[j][i] = 1
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
    
    private static func countVertex(forEdges edges:[Edge]) -> UInt{
        
        var count : UInt = 0
        
        for edge in edges {
            let vertex = max(edge.vertex1, edge.vertex2)
            count = max(count, vertex)
        }
        
        return count
    }
    
    private static func emptyMatrix(count:UInt) -> [[UInt8]]{
        var matrix : [[UInt8]] = []
        for _ in 0..<count {
            let row : [UInt8] = Array(repeating: 0, count: Int(count))
            matrix.append(row)
        }
        return matrix
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
