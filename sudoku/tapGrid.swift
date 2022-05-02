//
//  sudoku.swift
//  sudoku
//
//  Created by Rajpreet Judge on 4/29/22.
//

import UIKit
import SwiftUI

class tapGrid: UIView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    
    let obj = ViewController()
    
    //represents our grid for each cell and what value it should display
    @IBOutlet weak var rowLabel: UILabel!
    @IBOutlet weak var colLabel: UILabel!
    @IBOutlet weak var messageBox: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
//    @IBOutlet weak var numberText: UITextField!
    
    //playable randomized array
    var touchCount = [[0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0]]
    
    //winnable test array
//    var touchCount = [[0, 0, 3, 7, 8, 9, 4, 5, 6],
//                      [4, 5, 6, 1, 2, 3, 7, 8, 9],
//                      [7, 8, 9, 4, 5, 6, 1, 2, 3],
//                      [3, 1, 2, 9, 7, 8, 6, 4, 5],
//                      [6, 4, 5, 3, 1, 2, 9, 7, 8],
//                      [9, 7, 8, 6, 4, 5, 3, 1, 2],
//                      [2, 3, 1, 8, 9, 7, 5, 6, 4],
//                      [5, 6, 4, 2, 3, 1, 8, 9, 7],
//                      [8, 9, 7, 5, 6, 4, 2, 3, 1]]
////
    //checks if full
//    var touchCount = [[1, 3, 8, 4, 1, 1, 5, 6, 7],
//                      [2, 3, 9, 4, 1, 2, 3, 1, 8],
//                      [3, 4, 7, 4, 3, 3, 6, 2, 9],
//                      [4, 5, 5, 5, 4, 4, 5, 4, 7],
//                      [3, 3, 4, 4, 6, 7, 4, 5, 6],
//                      [5, 4, 5, 6, 8, 9, 4, 2, 5],
//                      [2, 5, 6, 5, 4, 6, 4, 3, 4],
//                      [3, 6, 8, 4, 4, 7, 4, 3, 3],
//                      [6, 7, 4, 3, 5, 8, 4, 3, 2]]

    var initialBoardstate = [[0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0]]
    var number: String = ""
    var row: Int = 0
    var col: Int = 0
    var timeSec = 0
    var timeMin = 0
    var timeHr = 0
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    //((Int(bounds.width)/9)*i)/2),((Int(bounds.height)/9)*i)/2)
    
    let easyDiff = Int.random(in: 80...90)
    let mediumDiff = Int.random(in: 50...60)
    let hardDiff = Int.random(in: 20...30)
    
    var boardRand = false
    var isFull = Set<Int>()
    /*
     If the user hits the reset button just call the reset function
     */
    
    @IBAction func resetButton(_ sender: Any) {
        timeSec = 0
        timeMin = 0
        timeHr = 0
        resetGame()
    }
    
//    @IBAction func enterButton(_ sender: Any) {
//
//        number = numberText.text!
//        let num = Int(number)
//
//        if(num != nil) {
//            if((num! > 0) && (num! < 10)) {
//                if !checkCol(randCol: col, cellNum: num!) && !checkRow(randRow: row, cellNum: num!) &&
//                    !checkBlck(randRow: row, randCol: col, cellNum: num!) && !checkFull() {
//                    messageBox.text = "Valid Move"
//                    messageBox.textColor = .black
////                    messageBox.backgroundColor = .clear
////                    touchCount[row][col] = num!
//                    numberText.text = ""
//
//                } else {
//                    messageBox.text = "Invalid Move: Similar Number."
//                    messageBox.textColor = .red
////                    messageBox.backgroundColor = .cyan
//                }
//            } else {
//                messageBox.text = "Invalid Number/Move"
//                messageBox.textColor = .red
//            }
//        }
//        setNeedsDisplay()
//    }
    
    override func draw(_ rect: CGRect) {
        
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        //creating a done button and setting it to our toolbar
//        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finishDate))
//        toolbar.setItems([doneBtn], animated: true)
//        numberText.inputAccessoryView = toolbar
        
        //making our accesseryview the toolbar and the inputview itself the datepicker
        
        
        if(boardRand == false){
            randomBoard(diff: mediumDiff)
            _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(gameTimer), userInfo: nil, repeats: true)
        }
        
        //GETTING WIDTH/HEIGHT AND MIN SIDE
        let width = bounds.width
        let height = bounds.height
        let minSide = Swift.min(width, height)
    
        let sub = (minSide == height) ? width : height
        
        let yAdjust = (minSide == height) ? 0 : ((Int(sub) - Int(minSide))/2) //PADDING FOR Y AXIS
        let xAdjust = (minSide != height) ? 0 : ((Int(sub) - Int(minSide))/2) //PADDING FOR X AXIS
        let line = UIBezierPath()
        let mul = minSide/9 //MULTIPLIER FOR LINE SPACING
        
        //DRAWING VERTICAL LINES
        for i in stride(from: 0, through: minSide, by: mul) {
            line.lineWidth = 1
            line.move(to: CGPoint(x: i + CGFloat(xAdjust), y: CGFloat(yAdjust)))
            line.addLine(to: CGPoint(x: i + CGFloat(xAdjust), y: minSide + CGFloat(yAdjust)))
            UIColor.black.setStroke()
            line.stroke()
        }
        
        //DRAWING HORIZONTAL LINES
        for i in stride(from: 0, through: minSide, by: mul) {
            line.lineWidth = 1
            line.move(to: CGPoint(x: xAdjust, y: Int(i) + yAdjust))
            line.addLine(to: CGPoint(x: minSide + CGFloat(xAdjust), y: i + CGFloat(yAdjust)))
            UIColor.black.setStroke()
            line.stroke()
        }
        
        //USING YOUR HINT FROM THE WRITE UP
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: minSide/9),
        .foregroundColor: UIColor.blue
        ]
        let initAtt: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: minSide/9),
        .foregroundColor: UIColor.black
        ]

        let zero = " " as NSString
        let one = "1" as NSString
        let two = "2" as NSString
        let three = "3" as NSString
        let four = "4" as NSString
        let five = "5" as NSString
        let six = "6" as NSString
        let seven = "7" as NSString
        let eight = "8" as NSString
        let nine = "9" as NSString

        let numbers = [zero, one, two, three, four, five, six, seven, eight, nine]

        //drawing the zeros centered in the squares
        var col = 0
        var row = 0
        for i in stride(from: 0, through: minSide - mul, by: mul) {
            for j in stride(from: 0, through: minSide - mul, by: mul) {
                let index = touchCount[row][col]
                let initial = initialBoardstate[row][col]
                numbers[index].draw(at: CGPoint(x: (i + CGFloat(xAdjust) + (mul - (numbers[index].size(withAttributes: attributes).width))/2), y: j + CGFloat(yAdjust) + (mul - (numbers[index].size(withAttributes: attributes).height))/2), withAttributes: attributes)
                
                numbers[initial].draw(at: CGPoint(x: (i + CGFloat(xAdjust) + (mul - (numbers[initial].size(withAttributes: initAtt).width))/2), y: j + CGFloat(yAdjust) + (mul - (numbers[initial].size(withAttributes: initAtt).height))/2), withAttributes: initAtt)

                row += 1
            }
            row = 0
            col += 1
        }
        if checkWin() {
            self.messageBox.text = "Winner: Resetting Game"
            self.messageBox.textColor = .green
            self.messageBox.backgroundColor = .clear
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.resetGame()
            }
        }
        
    }
    var w: CGFloat = 0.0
    var h: CGFloat = 0.0
    var min: CGFloat = 0.0
    var sub: CGFloat = 0.0
    var mul: CGFloat = 0.0//MULTIPLIER FOR LINE SPACING
    var yAdjust: Int = 0 //PADDING FOR Y AXIS
    var xAdjust: Int = 0
    var tapPoint = CGPoint(x: 0.0, y: 0.0)
    var innercol: Int = 0
    var innerrow: Int = 0
    
    //double tap deletes the inputted number on the board
    @IBAction func doubleTap(_ sender: UITapGestureRecognizer) {
        if (tapPoint.y > CGFloat(yAdjust) && tapPoint.y < CGFloat(min + CGFloat(yAdjust))) && (tapPoint.x > CGFloat(xAdjust) && tapPoint.x < min + CGFloat(xAdjust)) {
            if(touchCount[row][col] != 0){ //&& initialBoardstate[row][col] == 0
                touchCount[row][col] = 0
            }
        }
        setNeedsDisplay()
    }
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        /*
         These calculations are needed for
         determining valid click inside the grid
         and finding where exactly we clicked
         
         also used for testing whether click was inside the grid and valid
         */
        
        w = bounds.width
        h = bounds.height
        min = Swift.min(w, h)
        sub = (min == h) ? w : h
        mul = min/9 //MULTIPLIER FOR LINE SPACING
        yAdjust = (min == h) ? 0 : ((Int(sub) - Int(min))/2) //PADDING FOR Y AXIS
        xAdjust = (min != h) ? 0 : ((Int(sub) - Int(min))/2)
        tapPoint = sender.location(in: self)
        innercol = Int(abs(tapPoint.x - CGFloat(xAdjust))/mul)
        innerrow = Int(abs((tapPoint.y - CGFloat(yAdjust)))/mul)

        //checking to see if click out of bounds
        if (tapPoint.y > CGFloat(yAdjust) && tapPoint.y < CGFloat(min + CGFloat(yAdjust))) && (tapPoint.x > CGFloat(xAdjust) && tapPoint.x < min + CGFloat(xAdjust)) {
            col = innercol
            row = innerrow
            colLabel.text = "Col: " + String(col)
            rowLabel.text = "Row: " + String(row)
            
            print(initialBoardstate)
            print(touchCount)
            if initialBoardstate[innerrow][innercol] == 0 {
                touchCount[innerrow][innercol] = (touchCount[innerrow][innercol] == 9) ? 0 : (touchCount[innerrow][innercol] + 1)
            }
            
//            print(touchCount[innerrow][innercol])
            let numInput = touchCount[innerrow][innercol]
//            print(numInput)
//            print(checkRow(randRow: innerrow, cellNum: numInput))
//            print(checkBlck(randRow: innerrow, randCol: innercol, cellNum: numInput))
            if !checkRowWithArray(randRow: innerrow, cellNum: numInput) && !checkColWithArray(randCol: innercol, cellNum: numInput) && !checkBlckWithArray(randRow: innerrow, randCol: innercol, cellNum: numInput){
                messageBox.text = "Valid Move"
                messageBox.textColor = .black
//                numberText.text = ""
            } else {
                messageBox.text = "Invalid Move: Similar Number."
                messageBox.textColor = .red
            }
        }
        setNeedsDisplay()
    }
    
    /* randomize either the cell number, row number, or column number; depending on what is being passed */
    func randomNum(row: Int, col: Int) -> Int{
        return Int.random(in: row...col)
    }

    /* generates a board with random number in it */
    func randomBoard(diff: Int){
        boardRand = true
        
        for _ in stride(from: 1, to: diff, by: 1){
            
            let fixedCellNum = randomNum(row: 1, col: 9)
            
            let randRow = randomNum(row: 0, col: 8)
            let randCol = randomNum(row: 0, col: 8)
            
            if(touchCount[randRow][randCol] == 0){
                
                if(!checkRow(randRow: randRow, cellNum: fixedCellNum) &&
                   !checkCol(randCol: randCol, cellNum: fixedCellNum) &&
                    !checkBlck(randRow: randRow, randCol: randCol, cellNum: fixedCellNum)){
                    touchCount[randRow][randCol] = fixedCellNum
                    initialBoardstate[randRow][randCol] = fixedCellNum
                    
                }
            }
        }

        
        setNeedsDisplay()
    }
    
    func checkBlckWithArray(randRow: Int, randCol: Int, cellNum: Int) -> Bool{
//        var blckVisited = Set<Int>()
        var blckVisited: [Int] = []
        if cellNum != 0 {
            let blckRow = randRow == 2 || randRow == 5 || randRow == 8 ? randRow - 2 : randRow == 1 || randRow == 4 || randRow == 7 ? randRow - 1 : randRow
            let blckCol = randCol == 2 || randCol == 5 || randCol == 8 ? randCol - 2 : randCol == 1 || randCol == 4 || randCol == 7 ? randCol - 1 : randCol
            var count = 0
//            print(blckRow, blckCol)
            for xrow in blckRow...(blckRow + 2){
                for xcol in blckCol...(blckCol + 2){
//                    blckVisited.insert(touchCount[xrow][xcol])
                    if cellNum == touchCount[xrow][xcol] {
                        count += 1
                    }
                }
            }
        
            return count > 1 ? true : false
        
//            return blckVisited.contains(cellNum) ? true : false
        }
        return false
    }
    
    func checkRowWithArray(randRow: Int,cellNum: Int) -> Bool{
        var count = 0
        var rowVisited: [Int] = []
        for col in 0...8 {
            rowVisited.append(touchCount[randRow][col])
        }

        for i in 0...8 {
            if rowVisited[i] == cellNum {
                count += 1
            }
        }

        //return true if more than 1 of same number
        return count > 1 ? true : false
    }
    
    func checkColWithArray(randCol: Int, cellNum: Int) -> Bool{
        var count = 0
        var colVisited: [Int] = []
        for row in 0...8 {
            colVisited.append(touchCount[row][randCol])
        }

        for i in 0...8 {
            if colVisited[i] == cellNum {
                count += 1
            }
        }

        //return true if more than 1 of same number
        return count > 1 ? true : false
    }
    //get all the elements inside the 2D array
    
    func getBoardState(){
        for row in 0...8{
            for col in 0...8{
                isFull.insert(touchCount[row][col])
            }
        }
    }
    
    //checks the board if empty
    func checkEmpty() -> Bool{
        getBoardState()
        
        //checks if matrix only contains zeros
        if(isFull.contains(0) && isFull.count == 1){
            return true
        }
        isFull = Set<Int>()
        return false
    }
    
    //checks the board if full
    func checkFull() -> Bool{
        getBoardState()
        
        //checks if there are no empty slot
        if(!isFull.contains(0)){
            return true
        }
        isFull = Set<Int>()
        return false
    }
    
    /* if board is full return true */
    func checkWin () -> Bool{
        
        var sum = 0

        for i in 0...8 {
            for j in 0...8 {
                sum += touchCount[i][j]
            }
        }

        return (sum == 405 && checkFull()) ? true : false

        
//        return checkFull() && !checkEmpty() ? true : false
    }
    
    /* checks if the inputted number is valid within that row */
    func checkRow(randRow: Int,cellNum: Int) -> Bool{
        
        var rowVisited = Set<Int>()
        if cellNum != 0 {
            for col in 0...8{
                rowVisited.insert(touchCount[randRow][col])
            }
            return rowVisited.contains(cellNum) ? true : false
        }
        return false
//        var count = 0
//        var rowVisited: [Int] = []
//        for col in 0...8 {
//            rowVisited.append(touchCount[randRow][col])
//        }
//
//        for i in 0...8 {
//            if rowVisited[i] == cellNum {
//                count += 1
//            }
//        }
//
//        //return true if more than 1 of same number
//        return count > 1 ? true : false
    }
    
    /* checks if the inputted number is valid within that column */
    func checkCol(randCol: Int, cellNum: Int) -> Bool{
        var colVisited = Set<Int>()
        if cellNum != 0 {
            for row in 0...8{
                colVisited.insert(touchCount[row][randCol])
            }
            return colVisited.contains(cellNum) ? true : false
        }
        return false
//        var count = 0
//        var colVisited: [Int] = []
//        for row in 0...8 {
//            colVisited.append(touchCount[row][randCol])
//        }
//
//        for i in 0...8 {
//            if colVisited[i] == cellNum {
//                count += 1
//            }
//        }
//
//        //return true if more than 1 of same number
//        return count > 1 ? true : false
        
    }
    
    /* checks the number if valid on a specific 3x3 block
     */
    func checkBlck(randRow: Int, randCol: Int, cellNum: Int) -> Bool{
        var blckVisited = Set<Int>()
//        var blckVisited: [Int] = []
        if cellNum != 0 {
            let blckRow = randRow == 2 || randRow == 5 || randRow == 8 ? randRow - 2 : randRow == 1 || randRow == 4 || randRow == 7 ? randRow - 1 : randRow
            let blckCol = randCol == 2 || randCol == 5 || randCol == 8 ? randCol - 2 : randCol == 1 || randCol == 4 || randCol == 7 ? randCol - 1 : randCol
            var count = 0
//            print(blckRow, blckCol)
            for xrow in blckRow...(blckRow + 2){
                for xcol in blckCol...(blckCol + 2){
                    blckVisited.insert(touchCount[xrow][xcol])
    //                if cellNum == touchCount[xrow][xcol] {
    //                    count += 1
    //                }
                }
            }
        
//        return count > 1 ? true : false
        
            return blckVisited.contains(cellNum) ? true : false
        }
        return false
    }
    
    /*
     function will reset the 2d game board to all 0's
     the then update boardstate and generate a random board
     by calling randomBoard function
     */
    
    func resetGame() {
        touchCount =      [[0, 0, 0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0, 0, 0]]
        
        initialBoardstate = [[0, 0, 0, 0, 0, 0, 0, 0, 0],
                             [0, 0, 0, 0, 0, 0, 0, 0, 0],
                             [0, 0, 0, 0, 0, 0, 0, 0, 0],
                             [0, 0, 0, 0, 0, 0, 0, 0, 0],
                             [0, 0, 0, 0, 0, 0, 0, 0, 0],
                             [0, 0, 0, 0, 0, 0, 0, 0, 0],
                             [0, 0, 0, 0, 0, 0, 0, 0, 0],
                             [0, 0, 0, 0, 0, 0, 0, 0, 0],
                             [0, 0, 0, 0, 0, 0, 0, 0, 0]]
        
        getBoardState()
        let randomDiff = [easyDiff, mediumDiff, hardDiff]
        randomBoard(diff: randomDiff.randomElement()!)
        messageBox.text = "New Game random diff"
        messageBox.textColor = .black
        setNeedsDisplay()
//        messageBox.backgroundColor = .clear
        
    }
  
    @objc func gameTimer(){
        timeSec += 1
        if(timeSec == 60){
            timeMin += 1
            timeSec = 0
        }
        if(timeMin == 60){
            timeHr += 1
            timeMin = 0
            timeSec = 0
        }
        timerLabel.text = "Timer: " + String(format: "%02d", timeHr) + ":" + String(format: "%02d", timeMin) + ":" + String(format: "%02d", timeSec)
    }
    
}
