//
//  ChessBoardView.swift
//  ChessTest
//
//  Created by Illya Kuznietsov on 03.03.2021.
//

import UIKit

@IBDesignable class ChessBoardView: UIView {
  
  @IBInspectable var startImage: UIImage?
  @IBInspectable var destinationImage: UIImage?
  @IBInspectable var size: Int = BoardSizes.s_6x6.size
  
  private let asixPadding: CGFloat = 20
  private var cellSize: CGFloat = 20
  private let lettersArray: [NSString] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P"]
  private var startPosition: CGPoint = CGPoint.undefined {
    didSet {
      self.setNeedsDisplay()
    }
  }
  private var destinationPosition: CGPoint = CGPoint.undefined {
    didSet {
      self.setNeedsDisplay()
    }
  }
  
  public var boardSize: BoardSize {
    return BoardSize(size: size)
  }
  
  public override func draw(_ rect: CGRect) {
    cellSize = min((self.frame.size.width - asixPadding * 2) / CGFloat(size),(self.frame.size.height - asixPadding * 2) / CGFloat(size))
    
    drawGrid()
    setAxisValues()
    drawFigures()
  }
  
  private func drawGrid() {
    let gridPath = UIBezierPath()
    
    for i in 0...size {
      gridPath.move(to: CGPoint(x: asixPadding, y: asixPadding + CGFloat(i) * cellSize))
      gridPath.addLine(to: CGPoint(x: asixPadding + CGFloat(size) * cellSize, y: asixPadding + CGFloat(i) * cellSize))
    }
    
    for i in 0...size {
      gridPath.move(to: CGPoint(x: asixPadding + CGFloat(i) * cellSize, y: asixPadding ))
      gridPath.addLine(to: CGPoint(x: asixPadding + CGFloat(i) * cellSize, y: asixPadding + CGFloat(size) * cellSize))
    }
    
    //Close the path.
    gridPath.close()
    
    // Specify a borders color.
    UIColor.lightGray.setStroke()
    gridPath.stroke()
  }
  
  private func setAxisValues() {
    self.subviews.forEach { (view) in
      view.removeFromSuperview()
    }
    for i in 0..<size {
      let text = lettersArray[(size-1) - i]
      let point = CGPoint(x: asixPadding/2, y:  (CGFloat(i) * cellSize) + asixPadding + cellSize / 2 )
      drawAsiz(with: text, at: point)
    }
    
    for i in 0..<size {
      let text: NSString = "\(i + 1)" as NSString
      let point = CGPoint(x:  (asixPadding + CGFloat(i) * cellSize) + cellSize / 2, y: (CGFloat(size) * cellSize)+asixPadding)
      drawAsiz(with: text, at: point)
    }
  }
  
  private func drawAsiz(with value: NSString, at position: CGPoint) {
    let textFontAttributes = [
      NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 9) as Any
    ]
    
    value.draw(at: position, withAttributes: textFontAttributes)
  }
  
  private func drawFigures() {
    if startPosition != .undefined {
      let adjustedPosition = adjustPosition(startPosition)
      let rect =  CGRect(x: adjustedPosition.x, y: adjustedPosition.y, width: cellSize, height: cellSize)
      startImage?.draw(in: rect)
    }
    if destinationPosition != .undefined {
      let adjustedPosition = adjustPosition(destinationPosition)
      let rect =  CGRect(x: adjustedPosition.x, y: adjustedPosition.y, width: cellSize, height: cellSize)
      destinationImage?.draw(in: rect)
    }
  }
}

// MARK: - Private Helpers

extension ChessBoardView {
  private func getCellBy(_ point: CGPoint) -> CGPoint? {
    let xPos: Int = Int((point.x - asixPadding) / cellSize)
    let yPos: Int = Int((point.y - asixPadding) / cellSize)
    if xPos < size && yPos < size && point.x >= asixPadding && point.y >= asixPadding {
      return CGPoint(x: xPos, y: yPos)
    }
    return nil
  }
  
  private func adjustPosition(_ cell: CGPoint) -> CGPoint {
    let xPos: CGFloat = CGFloat((cell.x * cellSize) + asixPadding)
    let yPos: CGFloat = CGFloat((cell.y * cellSize) + asixPadding)
    
    return CGPoint(x: xPos, y: yPos)
  }
}

// MARK: - Public 

extension ChessBoardView {
  public func clearPositions() {
    startPosition = CGPoint.undefined
    destinationPosition = CGPoint.undefined
  }
  
  public func changeGridSize(with size: Int) {
    self.size = size
  }
  
  public func figuresPositions() -> (GridPosition, GridPosition)? {
    guard  startPosition != CGPoint.undefined, destinationPosition != CGPoint.undefined else {
      return nil
    }
    return(GridPosition(point: startPosition), GridPosition(point: destinationPosition))
  }
  
  public func positionToChessCoordinates(_ position: GridPosition) -> String {
    let xChessPos = Int(position.x + 1)
    let yChessPos = self.lettersArray[(size - Int(position.y + 1))]
    return "\(xChessPos)\(yChessPos)"
  }
  
  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touchLoc = touches.first?.location(in: self)
    
    if let curentCell = self.getCellBy(touchLoc!) {
      if startPosition == .undefined {
        startPosition = curentCell
      } else if destinationPosition == .undefined {
        destinationPosition = curentCell
      }
    }
  }
}
