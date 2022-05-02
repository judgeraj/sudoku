//
//  sudoku.swift
//  sudoku
//
//  Created by Rajpreet Judge on 4/29/22.
//

import UIKit
@IBDesignable

class tapGrid: UIView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    
    //represents our grid for each cell and what value it should display
    @IBOutlet weak var rowLabel: UILabel!
    @IBOutlet weak var colLabel: UILabel!
    @IBOutlet weak var messageBox: UILabel!
    
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
//    var touchCount = [[0, 2, 3, 7, 8, 9, 4, 5, 6],
//                      [4, 5, 6, 1, 2, 3, 7, 8, 9],
//                      [7, 8, 9, 4, 5, 6, 1, 2, 3],
//                      [3, 1, 2, 9, 7, 8, 6, 4, 5],
//                      [6, 4, 5, 3, 1, 2, 9, 7, 8],
//                      [9, 7, 8, 6, 4, 5, 3, 1, 2],
//                      [2, 3, 1, 8, 9, 7, 5, 6, 4],
//                      [5, 6, 4, 2, 3, 1, 8, 9, 7],
//                      [8, 9, 7, 5, 6, 4, 2, 3, 1]]
//
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
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    //((Int(bounds.width)/9)*i)/2),((Int(bounds.height)/9)*i)/2)
    
    let easyDiff = Int.random(in: 80...90)
    let mediumDiff = Int.random(in: 50...60)
    let hardDiff = Int.random(in: 20...30)
    
    var boardRand = false

    var isFull = Set<Int>()
    
    @IBOutlet weak var numberText: UITextField!
    
    /*
     If the user hits the reset button just call the reset function
     */
    
    @IBAction func resetButton(_ sender: Any) {
        resetGame()
    }
    
    @IBAction func enterButton(_ sender: Any) {
        
        number = numberText.text!
        let num = Int(number)
        
        if(num != nil) {
            if((num! > 0) && (num! < 10)) {
                if !checkCol(randCol: col, cellNum: num!) && !checkRow(randRow: row, cellNum: num!) &&
                    !checkBlck(randRow: row, randCol: col, cellNum: num!) && !checkFull(){
                    messageBox.text = "Valid Move"
                    messageBox.textColor = .black
//                    messageBox.backgroundColor = .clear
                    touchCount[row][col] = num!
                    numberText.text = ""
                    
                } else {
                    messageBox.text = "Invalid Move: Similar Number."
                    messageBox.textColor = .red
//                    messageBox.backgroundColor = .cyan
                }
            } else {
                messageBox.text = "Invalid Number"
                messageBox.textColor = .red
            }
        }
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
         print(touchCount)
        print(initialBoardstate)
        //print(checkBlck(randRow: 4, randCol: 1, cellNum: 8))
        if(boardRand == false){
            randomBoard(diff: mediumDiff)
        }
        print("draw",checkWin())

        //GETTING WIDTH/HEIGHT AND MIN SIDE
        let width = bounds.width
        let height = bounds.height
        let minSide = min(width, height)
    
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
        .foregroundColor: UIColor.systemCyan
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
//                print(col)
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
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        /*
         These calculations are needed for
         determining valid click inside the grid
         and finding where exactly we clicked
         
         also used for testing whether click was inside the grid and valid
         */
        
        let w = bounds.width
        let h = bounds.height
        let min = min(w, h)
        let sub = (min == h) ? w : h
        let mul = min/9 //MULTIPLIER FOR LINE SPACING
        let yAdjust = (min == h) ? 0 : ((Int(sub) - Int(min))/2) //PADDING FOR Y AXIS
        let xAdjust = (min != h) ? 0 : ((Int(sub) - Int(min))/2)
        let tapPoint = sender.location(in: self)
        let innercol = Int(abs(tapPoint.x - CGFloat(xAdjust))/mul)
        let innerrow = Int(abs((tapPoint.y - CGFloat(yAdjust)))/mul)

        //checking to see if click out of bounds
        if (tapPoint.y > CGFloat(yAdjust) && tapPoint.y < CGFloat(min + CGFloat(yAdjust))) && (tapPoint.x > CGFloat(xAdjust) && tapPoint.x < min + CGFloat(xAdjust)) {
            col = innercol
            row = innerrow
            colLabel.text = "Col: " + String(col)
            rowLabel.text = "Row: " + String(row)
            
            print(innerrow, innercol)
            print(row, col)
        }
    }
    
    func randomNum(row: Int, col: Int) -> Int{
        return Int.random(in: row...col)
    }

    func randomBoard(diff: Int){
        boardRand = true
        print("diff", diff)
        
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
            print(isFull)
            return true
        }
        isFull = Set<Int>()
        return false
    }
    
    func checkWin () -> Bool{
        return checkFull() && !checkEmpty() ? true : false
    }
    
    func checkRow(randRow: Int,cellNum: Int) -> Bool{
        var rowVisited = Set<Int>()
        for col in 0...8{
            rowVisited.insert(touchCount[randRow][col])
        }
        return rowVisited.contains(cellNum) ? true : false
    }
    
    func checkCol(randCol: Int, cellNum: Int) -> Bool{
        var colVisited = Set<Int>()
        for row in 0...8{
            colVisited.insert(touchCount[row][randCol])
        }
        return colVisited.contains(cellNum) ? true : false
    }
    func checkBlck(randRow: Int, randCol: Int, cellNum: Int) -> Bool{
        var blckVisited = Set<Int>()

        let blckRow = randRow == 2 || randRow == 5 || randRow == 8 ? randRow - 2 : randRow == 1 || randRow == 4 || randRow == 7 ? randRow - 1 : randRow
        let blckCol = randCol == 2 || randCol == 5 || randCol == 8 ? randCol - 2 : randCol == 1 || randCol == 4 || randCol == 7 ? randCol - 1 : randCol
        for xrow in blckRow...(blckRow + 2){
            for xcol in blckCol...(blckCol + 2){
                blckVisited.insert(touchCount[xrow][xcol])
            }
        }
        return blckVisited.contains(cellNum) ? true : false
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
//        messageBox.backgroundColor = .clear
        
    }
    
}
