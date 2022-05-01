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
    
    var touchCount = [[0, 2, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [3, 0, 0, 0, 0, 0, 0, 0, 0]]
    var number: String = ""
    var row: Int = 0
    var col: Int = 0
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    //((Int(bounds.width)/9)*i)/2),((Int(bounds.height)/9)*i)/2)
    
    let easyDiff = Int.random(in: 40...50)
    let mediumDiff = Int.random(in: 30...40)
    let hardDiff = Int.random(in: 20...30)
    
    
    //              [[row],[col]]
    let blockOne = [[0,1,2],[0,1,2]]
    let blockTwo = [[3,4,5],[0,1,2]]
    let blockThree = [[6,7,8],[0,1,2]]
    
    let blockFour = [[0,1,2],[3,4,5]]
    let blockFive = [[3,4,5],[3,4,5]]
    let blockSix = [[6,7,8],[3,4,5]]
    
    let blockSeven = [[0,1,2],[6,7,8]]
    let blockEight = [[3,4,5],[6,7,8]]
    let blockNine = [[6,7,8],[6,7,8]]
    
    var boardRand = false
    
    @IBOutlet weak var numberText: UITextField!
    
    @IBAction func enterButton(_ sender: Any) {
        
        number = numberText.text!
        let num = Int(number)
        
        if(num != nil) {
            if((num! > 0) && (num! < 10)) {
                touchCount[row][col] = num!
                numberText.text = ""
            }
        }
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        //print(checkRow(randRow: 0, cellNum: 2))
//        if(boardRand == false){
//            randomBoard(diff: easyDiff)
//        }
        

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
            print(innerrow, innercol)
            print(row, col)
        }
    }
    var rowVisited = Set<Int>()
    func randomNum(row: Int, col: Int, cell: Int) -> Int{
        if( cell != 0 ){
            var newInt = 0
            repeat {
                newInt = Int.random(in: row...col);
                
            }while(rowVisited.contains(newInt))
            return newInt
        }
        return Int.random(in: row...col)
    }
    
    
    
    func randomBoard(diff: Int){
        
        // 9x9 = 81
        //
        boardRand = true
        for _ in stride(from: 0, to: diff, by: 1){
            let fixedCellNum = randomNum(row: 1, col: 9, cell: 0)
            let randRow = randomNum(row: 0, col: 8, cell: 0)
            let randCol = randomNum(row: 0, col: 8, cell: 0)
            
            if(touchCount[randRow][randCol] == 0){
                if(checkRow(randCol: randCol, cellNum: fixedCellNum) == false){
                    rowVisited.insert(fixedCellNum)
                    
                    touchCount[randRow][randCol] = fixedCellNum
                    //print(fixedCellNum)
                    print(randRow, randCol)
                }
                else{
                    touchCount[randCol][randRow] = randomNum(row: 1, col: 9, cell: fixedCellNum)
                    print("trye", fixedCellNum)
                    print(randRow, randCol)
                }
                
            }
        }
    }
    func checkRow(randCol: Int,cellNum: Int) -> Bool{
        for row in 0...8{
            if(touchCount[row][randCol] == cellNum){
                return true
            }
        }
        return false
    }
    
}
