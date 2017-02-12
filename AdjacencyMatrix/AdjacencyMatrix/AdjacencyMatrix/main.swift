//
//  main.swift
//  AdjacencyMatrix
//
//  Created by Aleksey Rochev on 12/02/2017.
//  Copyright © 2017 AlekseyRochev. All rights reserved.
//

import Foundation


print("Lab 1 \"Adjacency Matrix\"  \n")


print("Getting edges from adjacency matrix: \n")
let matrix = Matrix(withMatrix: "0 1 0 1 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 1 1 0 0 0")

print(matrix)
print(matrix.edges())

let edge1 = Edge(vertex1: 1, vertex2: 1)
let edge2 = Edge(vertex1: 2, vertex2: 1)
let edge3 = Edge(vertex1: 3, vertex2: 2)
let edge4 = Edge(vertex1: 4, vertex2: 3)
let edge5 = Edge(vertex1: 5, vertex2: 2)
let edge6 = Edge(vertex1: 6, vertex2: 5)

let edges = [edge1, edge2, edge3, edge4, edge5, edge6]

let matrix2 = Matrix(withEdges: edges)

print("-------------------------------------------------")
print("\nGetting adjacency matrix from eges: \n")
print(edges)
print(matrix2)

