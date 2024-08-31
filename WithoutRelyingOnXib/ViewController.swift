//
//  ViewController.swift
//  WithoutRelyingOnXib
//
//  Created by user on 2024/08/31.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    
    var selectedImage: UIImage?
    
    let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()
    let nameTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Enter your name"
           textField.borderStyle = .roundedRect
           textField.translatesAutoresizingMaskIntoConstraints = false
           return textField
       }()

       let dobTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Enter your date of birth"
           textField.borderStyle = .roundedRect
           textField.translatesAutoresizingMaskIntoConstraints = false
           return textField
       }()

       let addressTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Enter your address"
           textField.borderStyle = .roundedRect
           textField.translatesAutoresizingMaskIntoConstraints = false
           return textField
       }()

       let phoneTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Enter your phone number"
           textField.borderStyle = .roundedRect
           textField.keyboardType = .phonePad
           textField.translatesAutoresizingMaskIntoConstraints = false
           return textField
       }()

       let selfieButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Take a Selfie", for: .normal)
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()

       let submitButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Submit", for: .normal)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.backgroundColor = .systemBlue
           button.setTitleColor(.white, for: .normal)
           button.layer.cornerRadius = 5
           return button
       }()

       // MARK: - Lifecycle Methods

       override func viewDidLoad() {
           super.viewDidLoad()
           overrideUserInterfaceStyle = .light
           view.backgroundColor = .white
           setupTextFields()
           // Add subviews
           view.addSubview(toolbar)
           view.addSubview(nameTextField)
           view.addSubview(dobTextField)
           view.addSubview(addressTextField)
           view.addSubview(phoneTextField)
           view.addSubview(selfieButton)
           view.addSubview(submitButton)

           // Set up constraints
           setupConstraints()
           
           setupToolbar()
           
           selfieButton.addTarget(self, action: #selector(checkCameraAuthorizationAndTakeSelfie), for: .touchUpInside)
       }
    
    private func setupTextFields() {
           let textFields = [nameTextField, dobTextField, addressTextField, phoneTextField]
           
           for (index, textField) in textFields.enumerated() {
               view.addSubview(textField)
               textField.delegate = self
               
               let toolbar = UIToolbar()
               toolbar.sizeToFit()
               
               let nextButton = UIBarButtonItem(title: index == textFields.count - 1 ? "Done" : "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
               nextButton.tag = index
               let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
               toolbar.setItems([flexSpace, nextButton], animated: false)
               textField.inputAccessoryView = toolbar
           }
       }

       // MARK: - Layout Constraints

       func setupConstraints() {
           NSLayoutConstraint.activate([
               // Name TextField
            // Toolbar
            toolbar.topAnchor.constraint(equalTo: view.topAnchor),
                  toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                  toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                  toolbar.heightAnchor.constraint(equalToConstant: 88),  // Adjust height if necessary

                       // Name TextField
                       nameTextField.topAnchor.constraint(equalTo: toolbar.bottomAnchor, constant: 20),
                       nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                       nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                       nameTextField.heightAnchor.constraint(equalToConstant: 40),

               // Date of Birth TextField
               dobTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
               dobTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
               dobTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
               dobTextField.heightAnchor.constraint(equalToConstant: 40),

               // Address TextField
               addressTextField.topAnchor.constraint(equalTo: dobTextField.bottomAnchor, constant: 20),
               addressTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
               addressTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
               addressTextField.heightAnchor.constraint(equalToConstant: 40),

               // Phone Number TextField
               phoneTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
               phoneTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
               phoneTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
               phoneTextField.heightAnchor.constraint(equalToConstant: 40),

               // Selfie Button
               selfieButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
               selfieButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               selfieButton.heightAnchor.constraint(equalToConstant: 40),
               
               // Submit Button
               submitButton.topAnchor.constraint(equalTo: selfieButton.bottomAnchor, constant: 40),
               submitButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
               submitButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
               submitButton.heightAnchor.constraint(equalToConstant: 50),
           ])
       }

    
    func setupToolbar() {
        // Create and configure the back button
        let backButton = UIButton(type: .system)
           backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
           backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
           backButton.sizeToFit()
           
           // Create a container view for the back button
           let backButtonContainerView = UIView()
           backButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
           
           // Add the back button to the container view
           backButtonContainerView.addSubview(backButton)
           
           // Set constraints for the back button
           backButton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               backButton.centerXAnchor.constraint(equalTo: backButtonContainerView.centerXAnchor),
               backButton.topAnchor.constraint(equalTo: backButtonContainerView.topAnchor, constant: 10),
               backButton.heightAnchor.constraint(equalTo: backButtonContainerView.heightAnchor)
           ])
           
           // Set constraints for the container view
           NSLayoutConstraint.activate([
               backButtonContainerView.heightAnchor.constraint(equalTo: backButton.heightAnchor, constant: 10),
               backButtonContainerView.widthAnchor.constraint(equalTo: backButton.widthAnchor)
           ])
           
           let backBarButtonItem = UIBarButtonItem(customView: backButtonContainerView)


        // Create and configure the title label
        let titleLabel = UILabel()
        titleLabel.text = "No Rely On XIB"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.sizeToFit()
        
        // Create a container view for the title label
        let titleContainerView = UIView()
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the title label to the container view
        titleContainerView.addSubview(titleLabel)
        
        // Set constraints for the title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: titleContainerView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: 10)
        ])
        
        // Set constraints for the container view
        NSLayoutConstraint.activate([
            titleContainerView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: 0),
            titleContainerView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor)
        ])
        
        
        let titleBarButtonItem = UIBarButtonItem(customView: titleContainerView)

        // Flexible space to center the title
        let flexibleSpaceLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let flexibleSpaceRight = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        // Set the items in the toolbar
        toolbar.setItems([backBarButtonItem, flexibleSpaceLeft, titleBarButtonItem, flexibleSpaceRight], animated: false)
    }

    
    @objc private func nextButtonTapped(_ sender: UIBarButtonItem) {
        let textFields = [nameTextField, dobTextField, addressTextField, phoneTextField]
        let currentIndex = sender.tag
        
        if currentIndex < textFields.count - 1 {
            textFields[currentIndex + 1].becomeFirstResponder()
        } else {
            textFields[currentIndex].resignFirstResponder()
        }
    }
    
    

    func takeSelfie() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let image = info[.originalImage] as? UIImage {
               selectedImage = image
               selfieButton.setTitle("Selfie Taken", for: .normal)
           }
           picker.dismiss(animated: true, completion: nil)
       }

       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
    
    func showPermissionDeniedAlert() {
            let alert = UIAlertController(title: "Camera Permission Denied", message: "Please enable camera access in Settings.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

        func showNoCameraAlert() {
            let alert = UIAlertController(title: "No Camera", message: "This device does not have a camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
    @objc func checkCameraAuthorizationAndTakeSelfie() {
        print("hii")
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthorizationStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    if granted {
                        print("granted")
                        self?.takeSelfie()
                    } else {
                        self?.showPermissionDeniedAlert()
                    }
                }
            }
        case .authorized:
            print("authorized to take a selfie")
            takeSelfie()
        case .restricted, .denied:
            showPermissionDeniedAlert()
        @unknown default:
            fatalError("Unknown authorization status")
        }
        
    }
    
    @objc func backButtonTapped() {
           exit(0)
       }

}

