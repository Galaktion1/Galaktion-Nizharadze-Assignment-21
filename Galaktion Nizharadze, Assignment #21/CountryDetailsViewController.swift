//
//  CountryDetailsViewController.swift
//  Galaktion Nizharadze, Assignment #21
//
//  Created by Gaga Nizharadze on 11.08.22.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    var data: Country? {
        didSet {
            
            if let url = URL(string: data!.flagURL.png) {
                mainImageView.load(url: url)
            }
            
            regionalBlockLabel.text = "\(data?.regionalBlocs?.first?.acronym ?? "")  -  \(data?.regionalBlocs?.first?.name ?? "")"
            capitalLabel.text = "Capital: \(data?.capital ?? "")"
        }
    }
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        
        return imageView
    }()
    
  
    
    private var regionalBlockLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 2
        
        return label
    }()
    
    private var capitalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    private var descriptionVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 7
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUIElements()
        
    }
    
    private func confStackView () {
        view.addSubview(descriptionVerticalStackView)
        descriptionVerticalStackView.addArrangedSubview(regionalBlockLabel)
        descriptionVerticalStackView.addArrangedSubview(capitalLabel)
    }
  
    private func configureUIElements() {
        confStackView()
        view.addSubview(mainImageView)
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 120),
            mainImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainImageView.heightAnchor.constraint(equalToConstant: 250),
            
            descriptionVerticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionVerticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            descriptionVerticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            descriptionVerticalStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

