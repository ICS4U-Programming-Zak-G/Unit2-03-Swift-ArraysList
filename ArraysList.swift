//
//  ArraysList.swift
//
//  Created by Zak Goneau
//  Created on 2025-03-26
//  Version 1.0
//  Copyright (c) 2025 Zak Goneau. All rights reserved.
//
//  This reads an inputted file and displays the mean and median.
//  This program uses arrays and functions to do such.

// Import library
import Foundation

// Define main function
func main() {

    // Initialize output file
    let outputFile = "output.txt"

    // Initialize output string
    var outputStr = ""

    // Initialize size
    var size:Float = 0.0

    // Introduce program to user
    print("This program calculates the mean and median of a file of numbers.")

    // Get user input
    print("Please enter the file name: ")
    let file = readLine()!

    // Try to read the input file
    guard let input = FileHandle(forReadingAtPath: file) else {

        // Tell user input file couldn't be opened
        print("Couldn't open the file")

        // Exit function
        exit(1)
    }

    // Try to read the output file
    guard let output = FileHandle(forWritingAtPath: outputFile) else {

        // Tell user output file couldn't be opened
        print("Couldn't open output file")

        // Exit function
        exit(1)
    }

    // Read lines from input file
    let inputData = input.readDataToEndOfFile()

    // Convert data to string
    guard let inputString = String(data: inputData, encoding: .utf8) else {

        // Tell user couldn't convert data to string
        print("Couldn't convert data to string")

        // Exit function
        exit(1)
    }

    // Split string into lines
    let lines = inputString.components(separatedBy: "\n")

    // Initialize position in file
    var position = 0

    // Create array
    var array = [Float]()

    // Loop through lines
    while position < lines.count {
        // Get current line and trim whitespace
        let line = lines[position].trimmingCharacters(in: .whitespacesAndNewlines)

        // Split line into numbers
        let numbers = line.components(separatedBy: " ")

        // Loop through numbers
        for numberString in numbers {

            // Trim whitespace
            let trimmedNumber = numberString.trimmingCharacters(in: .whitespacesAndNewlines)

            // Add to array
            array.append(Float(trimmedNumber)!)
        }
        // Increment position
        position += 1
    }

    // Get size of array
    size = Float(array.count)

    // Sort array
    array.sort()

    // Print array
    print(array)

    // Write array to output string
    outputStr += "\(array) \n"

    // Call function to calculate mean
    let mean = calculateMean(array:array, size:Float(size))

    // Call function to calculate median
    let median = calculateMedian(array:array, size:Float(size))

    // Add mean and median results to output string
    outputStr += "Mean: \(mean) \n"
    outputStr += "Median: \(median) \n"

    // Print results as well
    print("Mean: \(mean)")
    print("Median: \(median)")

    // Write to output file
    output.write(outputStr.data(using: .utf8)!)

    // Close files
    output.closeFile()
    input.closeFile()
}

// Define function to calculate mean
func calculateMean(array: [Float], size: Float) -> Float {
    // Initialize variables
    var mean:Float = 0.0
    var sum:Float = 0.0

    // Calculate sum
    for number:Float in array {
        sum += number
    }

    // Calculate mean
    mean = sum/size

    // Return mean
    return mean
}

// Define function to calculate median
func calculateMedian(array: [Float], size: Float) -> Float{
    // Initialize variables
    var median:Float = 0.0
    var halfSize:Float = 0.0
    var firstNum:Float = 0.0
    var secondNum:Float = 0.0

    // Cast size to int for array indexing
    let size = Int(size)

    // Check if list is even or not
    if (size % 2 != 0) {
        // Get middle index number
        halfSize = Float(size / 2)

        // Get two numbers at middle
        firstNum = halfSize - 0.5
        secondNum = halfSize + 0.5

        // Calculate median for odd size
        median = (firstNum + secondNum) / 2

        // Get the number at the middle of the array if even
    } else {
        halfSize = Float(size / 2)
        median = array[Int(halfSize)]
    }

    // Return median
    return median
}

// Call main
main()
