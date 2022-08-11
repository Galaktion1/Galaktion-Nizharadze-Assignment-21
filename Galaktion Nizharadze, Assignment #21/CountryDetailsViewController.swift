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
            
//            mainImageView.image = UIImage(named: "screen`")
            mainImageView.loadImageUsingCache(withUrl: data!.flagURL)
            
            
            
            regionalBlockLabel.text = "\(data?.regionalBlocs?.first?.acronym ?? "")   \(data?.regionalBlocs?.first?.name ?? "")"
            capitalLabel.text = "Capital: \(data?.capital ?? "")"
        }
    }
    
    var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFill
        
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
        view.backgroundColor = .systemYellow
        view.addSubview(mainImageView)
        configureUIElements()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    private func confStackView () {
        view.addSubview(descriptionVerticalStackView)
        descriptionVerticalStackView.addArrangedSubview(regionalBlockLabel)
        descriptionVerticalStackView.addArrangedSubview(capitalLabel)
    }
  
    private func configureUIElements() {
        confStackView()
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 0),
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
