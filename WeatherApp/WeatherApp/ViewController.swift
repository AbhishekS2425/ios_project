//
//  ViewController.swift
//  WeatherApp
//
//  Created by Manisha Sinha on 27/04/26.
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel = WeatherViewModel()
    
    private let cityTextField = UITextField()
    private let tempLabel = UILabel()
    private let descLabel = UILabel()
    private let weatherTypeLabel = UILabel()
    private let button = UIButton(type: .system)
    private let latitude = UILabel()
    private let longitude = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        cityTextField.placeholder = "Enter city"
        cityTextField.borderStyle = .roundedRect
        cityTextField.delegate = self
        tempLabel.text = "--"
        descLabel.text = "--"
        weatherTypeLabel.text = "--"
        latitude.text = "--"
        longitude.text = "--"
        
        button.setTitle("Get Weather", for: .normal)
        button.addTarget(self, action: #selector(fetchWeather), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [cityTextField, button, tempLabel, weatherTypeLabel, latitude, longitude])
        stack.axis = .vertical
        stack.spacing = 16
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func fetchWeather() {
        guard let city = cityTextField.text, !city.isEmpty else { return }
        
        viewModel.getWeather(city: city) { [weak self] in
            guard let self = self else { return }
            
            if !self.viewModel.errorMessage.isEmpty {
                self.showAlert(message: self.viewModel.errorMessage)
            }
            else {
                self.tempLabel.text = self.viewModel.temperature
                self.weatherTypeLabel.text = self.viewModel.weatherType
                self.latitude.text = self.viewModel.latitude
                self.longitude.text = self.viewModel.longitude
            }
        }
    }
    
    func showAlert(title: String = "Error",message: String,actionTitle: String = "OK") {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Editing started")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Editing ended")
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("Clear button tapped")
        return true
    }
    
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //        print("Text changing")
    //        if let city  = textField.text, city.isEmpty {
    //             self.viewModel.temperature = ""
    //             self.viewModel.description = ""
    //        }
    //        return true
    //    }
}
