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
    var touchCount = [[0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0]]
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    //((Int(bounds.width)/9)*i)/2),((Int(bounds.height)/9)*i)/2)
    
    override func draw(_ rect: CGRect) {

        //GETTING WIDTH/HEIGHT AND MIN SIDE
        let width = bounds.width
        let height = bounds.height
        let minSide = min(width, height)
    
        let sub = (minSide == height) ? width : height
        
        let yAdjust = (minSide == height) ? 0 : ((Int(sub) - Int(minSide))/2) //PADDING FOR Y AXIS
        let xAdjust = (minSide != height) ? 0 : ((Int(sub) - Int(minSide))/2) //PADDING FOR X AXIS
        let line = UIBezierPath()
        var mul = minSide/9 //MULTIPLIER FOR LINE SPACING
        
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

        let zero = "0" as NSString
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
        var row = 0
        var col = 0
        for i in stride(from: 0, through: minSide - mul, by: mul) {
            for j in stride(from: 0, through: minSide - mul, by: mul) {
                var index = touchCount[row][col]
                numbers[index].draw(at: CGPoint(x: (i + CGFloat(xAdjust) + (mul - (numbers[index].size(withAttributes: attributes).width))/2), y: j + CGFloat(yAdjust) + (mul - (numbers[index].size(withAttributes: attributes).height))/2), withAttributes: attributes)
//                print(col)
                col += 1
            }
            col = 0
            row += 1
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
        let col = Int(abs(tapPoint.x - CGFloat(xAdjust))/mul)
        let row = Int(abs((tapPoint.y - CGFloat(yAdjust)))/mul)

        //checking to see if click out of bounds
        if (tapPoint.y > CGFloat(yAdjust) && tapPoint.y < CGFloat(min + CGFloat(yAdjust))) && (tapPoint.x > CGFloat(xAdjust) && tapPoint.x < min + CGFloat(xAdjust)) {
            // check to see if our value in the 2d array is already max
            //reset if that is the case else increment
            touchCount[col][row] = (touchCount[col][row] == 9) ? 0 : (touchCount[col][row] + 1)
        }
        setNeedsDisplay()
    }

}
