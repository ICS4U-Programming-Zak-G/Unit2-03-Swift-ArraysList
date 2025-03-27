//
//  FileIO.swift
//
//  Created by Zak Goneau
//  Created on 2025-03-26
//  Version 1.0
//  Copyright (c) 2025 Zak Goneau. All rights reserved.
//
//  This reads an inputted file and displays the mean, median, and mode.
// This program uses array lists, arrays, and functions to do such.

// Import library
import Foundation

// Define main function
func main() {

    // Assign file names
    let inputFile = ""
    let outputFile = "output.txt"

    // Initialize output string
    var outputStr = ""

    // Get user input
    print("Please enter the file name: ")
    inputFile = nextLine()

    // Try to read the input file
    guard let input = FileHandle(forReadingAtPath: inputFile) else {

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

    // Read lines from file
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

    // Loop through lines
    while position < lines.count {
        // Get current line and trim whitespace
        let line = lines[position].trimmingCharacters(in: .whitespacesAndNewlines)

        // Check for empty line
        if line.isEmpty {

            // Add message to output string
            outputStr += "There are no integers on this line.\n"

            // Increment the position
            position += 1

            // Skip to next iteration
            continue
        }

        // Split line into numbers
        let numbers = line.components(separatedBy: " ")

        // Initialize sum and validity check
        var sum = 0
        var hasInvalidNumber = false

        // Loop through numbers
        for numberString in numbers {

            // Trim whitespace
            let trimmedNumber = numberString.trimmingCharacters(in: .whitespacesAndNewlines)

            // Use guard to check if it's a valid integer
            guard let numberInt = Int(trimmedNumber) else {

                // Add error message to output string
                outputStr += "Error: The line \"\(line)\" contains an invalid value.\n"

                // Set invalid number flag
                hasInvalidNumber = true

                // Break out of loop
                break
            }

            // Add to sum
            sum += numberInt
        }

        // Only add the sum if all numbers were valid
        if !hasInvalidNumber {

            // Add sum to output string
            outputStr += "The sum of the valid integers is \(sum).\n"
        }

        // Increment the position
        position += 1
    }

    // Write to output file
    output.write(outputStr.data(using: .utf8)!)

    // Display a success message
    print("Output successfully written to the output file.")

    // Close files
    output.closeFile()
    input.closeFile()
}

// Call main
main()