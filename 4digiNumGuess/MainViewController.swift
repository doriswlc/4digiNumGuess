//
//  ViewController.swift
//  4digiNumGuess
//
//  Created by doriswlc on 2022/10/3.
//

import UIKit

class MainViewController: UIViewController {
    var number1 = 0
    var number2 = 0
    var number3 = 0
    var number4 = 0
    var index = 0
    var count = 0

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet var inputNumLabel: [UILabel]!
    @IBOutlet var inputNumButton: [UIButton]!
    @IBOutlet weak var ansLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var recordTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        startButton.setTitle("設定數字", for: .normal)
        ansLabel.text = "(不重複的四位數字)"
        recordTextView.text = ""
        checkButton.isHidden = true
        index = 0
        for inputNumBtn in inputNumButton {
            inputNumBtn.isEnabled = false
        }
    }
    
    @IBAction func Start(_ sender: Any) {
        number1 = Int.random(in: 0...9)
        while number2 == number1 {
            number2 = Int.random(in: 0...9)
        }
        while number3 == number1 || number3 == number2 {
            number3 = Int.random(in: 0...9)
        }
        while number4 == number1 || number4 == number2 || number4 == number3 {
            number4 = Int.random(in: 0...9)
        }
        ansLabel.text = "四位數已設定"
        for inputNumBtn in inputNumButton {
            inputNumBtn.isEnabled = true
        }
        startButton.setTitle("偷看答案", for: .normal)
    }
    
    @IBAction func inputButton(_ sender: UIButton) {
        if index >= 0 && index <= 3 {
            let num = inputNumButton.firstIndex(of: sender)!
            inputNumLabel[index].text = "\(num)"
            sender.isEnabled = false
            index += 1
        }
        if index == 4 {
            checkButton.isHidden = false
            for inputNumBtn in inputNumButton {
                inputNumBtn.isEnabled = false
            }
            index = 0
        }
    }
    
    @IBAction func showAnsButton(_ sender: UIButton) {
        ansLabel.text = String(number1) + String(number2) + String(number3) + String(number4)
    }
    @IBAction func unshowAnsButton(_ sender: UIButton) {
        ansLabel.text = "四位數已設定"
    }
    
    @IBAction func checkButton(_ sender: Any) {
        count += 1
        var a = 0
        var b = 0
        switch inputNumLabel[0].text {
        case String(number1):
            a += 1
        case String(number2):
            b += 1
        case String(number3):
            b += 1
        case String(number4):
            b += 1
        default:
            break
        }
        switch inputNumLabel[1].text {
        case String(number1):
            b += 1
        case String(number2):
            a += 1
        case String(number3):
            b += 1
        case String(number4):
            b += 1
        default:
            break
        }
        switch inputNumLabel[2].text {
        case String(number1):
            b += 1
        case String(number2):
            b += 1
        case String(number3):
            a += 1
        case String(number4):
            b += 1
        default:
            break
        }
        switch inputNumLabel[3].text {
        case String(number1):
            b += 1
        case String(number2):
            b += 1
        case String(number3):
            b += 1
        case String(number4):
            a += 1
        default:
            break
        }
        recordTextView.text += "第\(count)次您猜的是\(inputNumLabel[0].text!)\(inputNumLabel[1].text!)\(inputNumLabel[2].text!)\(inputNumLabel[3].text!)，\n結果是\(a)A\(b)B\n"
        for i in 0..<inputNumLabel.count {
            inputNumLabel[i].text = ""
        }
        for inputNumBtn in inputNumButton {
            inputNumBtn.isEnabled = true
        }
        if a == 4 {
            let controller = UIAlertController(title: "BINGO!", message: "You'd got the correct answer!", preferredStyle: .alert)
            let finish = UIAlertAction(title: "Play Again!", style: .default) { _ in
                self.initUI()
            }
            controller.addAction(finish)
            present(controller, animated: true)
        }
    }
}

