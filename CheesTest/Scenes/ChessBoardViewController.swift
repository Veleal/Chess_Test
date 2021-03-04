//
//  ChessBoardVC.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 03.03.2021.
//

import UIKit

public class ChessBoardViewController: UIViewController, ViewController {
  
  @IBOutlet weak var chessBoardView: ChessBoardView!
  @IBOutlet weak var boardSizeTextField: UITextField!
  @IBOutlet weak var resultTextView: UITextView!
  
  public static var storyboardName: UIStoryboard.Name = .chessBoard

  public var presenter: ChessBoardPresenter! {
    didSet {
      presenter?.view = self
    }
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    prepareBoardPicker()

    presenter.onViewLoaded()
  }

  private func prepareBoardPicker() {
    let pickerView = UIPickerView()
    pickerView.delegate = self
    pickerView.dataSource = self
    boardSizeTextField.inputView = pickerView

    let initialBoardSize = BoardSizes.s_6x6
    boardSizeTextField.text = initialBoardSize.title
    chessBoardView.changeGridSize(with: initialBoardSize.size)
  }
}

// MARK: - DataPicker

extension ChessBoardViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  public  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return presenter.boardSizes.count
  }

  public  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    let sizeItem = presenter.boardSizes[row]
    return sizeItem.title
  }

  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    clear()

    let boardSize = presenter.boardSizes[row]
    changeGrid(with: boardSize)

    boardSizeTextField.resignFirstResponder()
  }

  private func changeGrid(with boardSize: BoardSizes) {
    boardSizeTextField.text = boardSize.title
    chessBoardView.changeGridSize(with: boardSize.size)
    chessBoardView.setNeedsDisplay()
  }

  private func clear() {
    chessBoardView.clearPositions()
    resultTextView.text = .empty
  }
}

// MARK: - FeedsPresenting

extension ChessBoardViewController: ChessBoardPresenting {
  public func display(with paths: [[GridPosition]]) {
    //ugly, would rather create some list to show output, but for testing
    var boardCoordinates = paths.map{$0.map{chessBoardView.positionToChessCoordinates($0)}.joined(separator: "->")}
    boardCoordinates.insert("", at: 0) //just to show word Path for first element
    let output = boardCoordinates.joined(separator: "\nPath:\n")
    resultTextView.text = output
  }

  public func error(with text: String) {
    resultTextView.text = text
  }
}

// MARK: - UserActions

extension ChessBoardViewController {

  @IBAction func clearButtonTap() {
    clear()
  }

  @IBAction func calculateButtonTap() {
    guard let (start, destination) = chessBoardView.figuresPositions() else { return }
    let size = chessBoardView.boardSize
 
    presenter.calculate(startPosition: start, destinationPosition: destination, boardSize: size)
  }

}
