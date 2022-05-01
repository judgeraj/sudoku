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
    
    var touchCount = [[0, 0, 0, 0, 0, 0, 0, 0, 0],
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
    
    @IBOutlet weak var numberText: UITextField!
    
    @IBAction func enterButton(_ sender: Any) {
        
        number = numberText.text!
        let num = Int(number)
        
        if(num != nil) {
            if((num! > 0) && (num! < 10)) {
                if !checkCol(randCol: col, cellNum: num!) && !checkRow(randRow: row, cellNum: num!) && !checkBlck(randRow: row, randCol: col, cellNum: num!){
                    touchCount[row][col] = num!
                    numberText.text = ""
                }
            }
        }
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        //print(checkBlck(randRow: 4, randCol: 1, cellNum: 8))
        if(boardRand == false){
            randomBoard(diff: mediumDiff)
        }
        

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
                numbers[index].draw(at: CGPoint(x: (i + CGFloat(xAdjust) + (mul - (numbers[index].size(withAttributes: attributes).width))/2), y: j + CGFloat(yAdjust) + (mul - (numbers[index].size(withAttributes: attributes).height))/2), withAttributes: attributes)
//                print(col)
                row += 1
            }
            row = 0
            col += 1
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
                    
                }
            }
        }
        setNeedsDisplay()
    }
    func checkRow(randRow: Int,cellNum: Int) -> Bool{
        var rowVisited = Set<Int>()
        for col in 0...8{
            rowVisited.insert(touchCount[randRow][col])
        }
        if(rowVisited.contains(cellNum)){
            return true
        }
        return false
    }
    
    func checkCol(randCol: Int, cellNum: Int) -> Bool{
        var colVisited = Set<Int>()
        for row in 0...8{
            colVisited.insert(touchCount[row][randCol])
        }
        if(colVisited.contains(cellNum)){
            return true
        }
        return false
    }
    func checkBlck(randRow: Int, randCol: Int, cellNum: Int) -> Bool{
        var blckVisited = Set<Int>()
        var tempRow = Set<Int>()
        var tempCol = Set<Int>()

        let blckRow = randRow == 2 || randRow == 5 || randRow == 8 ? randRow - 2 : randRow == 1 || randRow == 4 || randRow == 7 ? randRow - 1 : randRow
        let blckCol = randCol == 2 || randCol == 5 || randCol == 8 ? randCol - 2 : randCol == 1 || randCol == 4 || randCol == 7 ? randCol - 1 : randCol
        print(blckRow, blckCol)
        for xrow in blckRow...(blckRow + 2){
            for xcol in blckCol...(blckCol + 2){
                blckVisited.insert(touchCount[xrow][xcol])
                tempCol.insert(xcol)
            }
            tempRow.insert(xrow)
        }
        print(tempRow, tempCol)
        print(blckVisited)
        if(blckVisited.contains(cellNum)){
            return true
        }
        return false
    }
}
