//
//  ViewController.swift
//  Calculator
//
//  Created by Демьян on 12.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var scrollView: UIScrollView = UIScrollView()
    var mainStackView: UIStackView = UIStackView()
    var titleLabel: UILabel = UILabel()
    var firstLineStackView: UIStackView = UIStackView()
    var secondLineStackView: UIStackView = UIStackView()
    
    var oneButton: UIButton = UIButton()
    var twoButton: UIButton = UIButton()
    var threeButton: UIButton = UIButton()
    var plusButton: UIButton = UIButton()
    var fourButton: UIButton = UIButton()
    var fiveButton: UIButton = UIButton()
    var sixButton: UIButton = UIButton()
    var equalsButton: UIButton = UIButton()
    
    var cleanButton: UIButton = UIButton()
    var isNewValue: Bool = true
    var operation: String? = nil
    var previousOperation: String? = nil
    var result: Int = 0
    var newValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        scrollView.backgroundColor = .yellow
        
        setupMainStack()
        setupButtons()
        setupConstraints()
    }
    func setupMainStack() {
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .equalSpacing
        mainStackView.spacing = 20
        
        titleLabel.text = "Calculator"
        
        view.addSubview(scrollView)
        mainStackView.addArrangedSubview(titleLabel)
        scrollView.addSubview(mainStackView)
    }
    func setupButtons() {
        firstLineStackView.axis = .horizontal
        secondLineStackView.axis = .horizontal
        firstLineStackView.spacing = 16
        secondLineStackView.spacing = 16
        
        configureButton(button: oneButton, title: "1")
        configureButton(button: twoButton, title: "2")
        configureButton(button: threeButton, title: "3")
        configureButton(button: plusButton, title: "+")
        configureButton(button: fourButton, title: "4")
        configureButton(button: fiveButton, title: "5")
        configureButton(button: sixButton, title: "6")
        configureButton(button: equalsButton, title: "=")
        configureButton(button: cleanButton, title: "C")
        
        firstLineStackView.addArrangedSubview(oneButton)
        firstLineStackView.addArrangedSubview(twoButton)
        firstLineStackView.addArrangedSubview(threeButton)
        firstLineStackView.addArrangedSubview(plusButton)
        
        secondLineStackView.addArrangedSubview(fourButton)
        secondLineStackView.addArrangedSubview(fiveButton)
        secondLineStackView.addArrangedSubview(sixButton)
        secondLineStackView.addArrangedSubview(equalsButton)
        
        mainStackView.addArrangedSubview(firstLineStackView)
        mainStackView.addArrangedSubview(secondLineStackView)
        mainStackView.addArrangedSubview(cleanButton)
    }
    
    func configureButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
    }
    
    func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            mainStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if let text = sender.titleLabel?.text {
            if text == "=" {
                calculate()
            } else if text == "+" {
                operation = "+"
                previousOperation = nil
                isNewValue = true
                result = getInteger()
            } else if text == "C" {
                isNewValue = true
                result = 0
                newValue = 0
                operation = nil
                previousOperation = nil
                titleLabel.text = "0"
            } else {
                addDigit(text)
            }
        }
    }
    
    func addDigit(_ digit: String) {
        if isNewValue {
            titleLabel.text = ""
            isNewValue = false
        }
        var digits = titleLabel.text
        digits?.append(digit)
        titleLabel.text = digits
    }
    
    func getInteger() -> Int {
        return Int(titleLabel.text ?? "0") ?? 0
    }
    
    func calculate() {
        guard let operation = operation else {
            return
        }
        
        if previousOperation != operation {
            newValue = getInteger()
        }
        
        if operation == "+" {
            result += newValue
        } else {
            return
        }
        previousOperation = operation
        
        titleLabel.text = "\(result)"
        isNewValue = true
    }
    
}
