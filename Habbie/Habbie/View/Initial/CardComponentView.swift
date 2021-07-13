//
//  CardComponentView.swift
//  Chantine
//
//  Created by Beatriz Carlos on 24/11/20.
//

import UIKit

enum CardType {
    case descriptive, checkable
}

class CardComponentView: UIView {
    var identifier: String = ""
    var colorCheck: UIColor = .white
    var type: CardType
    private let userDefault = UserDefaults.standard
    
    required init(frame: CGRect = .zero, type: CardType) {
        self.type = type
        super.init(frame: frame)
        setupUI()
        
        switch type {
        case .descriptive:
            descriptiveCard()
        case .checkable:
            checkableCard()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: HabitBindingData) {
        titleLabel.text = (self.type == .descriptive) ? data.description : data.title
        avatarImageView.image = UIImage(named: getImage(imageId: data.imageId))
        avatarImageView.backgroundColor = data.bgcolorDark
        backgroundColor = data.bgcolor
        progressBar.setProgress(data.progress/100, animated: false)
        progressBar.tintColor = data.bgcolorDark
        self.colorCheck = data.bgcolorDark

        if let ids = userDefault.array(forKey: "TodayHabitsDone") as? [String] {
            if ids.contains(data.identifier) {
                checkButton.backgroundColor = colorCheck
                checkButton.setImage(UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), for: .normal)
                checkButton.tintColor = .white
            } else {
                checkButton.backgroundColor = .white
                checkButton.setImage(nil, for: .normal)
                checkButton.tintColor = .none
            }
        }
    }
    
    // UI components
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Beber água"
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textColor = .blackColor
        label.font = .roundedFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blueDarkColor
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "drinking-water-thumbnail")
        return imageView
    }()
    
    lazy var progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.setProgress(0.5, animated: false)
        progress.trackTintColor = .white
        progress.tintColor = .blueDarkColor
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Seu progresso"
        label.textColor = .blackColor
        label.font = .roundedFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonTapped(_ : UIButton) {
        if checkButton.backgroundColor == .white {
            checkButton.backgroundColor = colorCheck
            checkButton.setImage(UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), for: .normal)
            checkButton.tintColor = .white
            
            if var userDefaultsIDs = userDefault.array(forKey: "TodayHabitsDone") as? [String] {
                print(userDefaultsIDs)
                if !userDefaultsIDs.contains(identifier) {
                    userDefaultsIDs.append(identifier)
                    userDefault.set(userDefaultsIDs, forKey: "TodayHabitsDone")
                }
            } else {
                var userDefaultsIDs = [String]()
                userDefaultsIDs.append(identifier)
                userDefault.set(userDefaultsIDs, forKey: "TodayHabitsDone")
                //                print(userDefault.array(forKey: "TodayHabitsDone"))
            }
        } else {
            checkButton.backgroundColor = .white
            checkButton.setImage(nil, for: .normal)
            checkButton.tintColor = .none
            
            if var userDefaultsIDs = userDefault.array(forKey: "TodayHabitsDone") as? [String] {
                if let index = userDefaultsIDs.firstIndex(of: identifier) {
                    userDefaultsIDs.remove(at: index)
                    userDefault.set(userDefaultsIDs, forKey: "TodayHabitsDone")
                }
                
                // remove from user defaults
            }
        }
    }
        
        func descriptiveCard() {
            addSubview(dateLabel)
            NSLayoutConstraint.activate([
                dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
                dateLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
                progressBar.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
                titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5)
            ])
            
            titleLabel.font = .roundedFont(ofSize: 15, weight: .medium)
        }
        
        func checkableCard() {
            addSubview(checkButton)
            NSLayoutConstraint.activate([
                checkButton.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 8),
                checkButton.heightAnchor.constraint(equalToConstant: 40),
                checkButton.widthAnchor.constraint(equalToConstant: 40),
                checkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
                
            ])
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 5),
                titleLabel.trailingAnchor.constraint(equalTo: self.checkButton.leadingAnchor, constant: -16),
                progressBar.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16)
            ])
        }
        
        func setupUI() {
            backgroundColor = .blueLightColor
            self.layer.cornerRadius = 10
            setupContrants()
        }
        
        func setupContrants() {
            addSubview(avatarImageView)
            NSLayoutConstraint.activate([
                avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12.5),
                avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                avatarImageView.heightAnchor.constraint(equalToConstant: 60),
                avatarImageView.widthAnchor.constraint(equalToConstant: 60)
            ])
            
            addSubview(titleLabel)
            NSLayoutConstraint.activate([
                //            titleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12)
            ])
            
            addSubview(progressBar)
            NSLayoutConstraint.activate([
                progressBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                progressBar.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                progressBar.heightAnchor.constraint(equalToConstant: 10),
                progressBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
            ])
        }
        
        public func getImage(imageId image: Int) -> String {
            var imageName = ""
            switch image {
            case 1:
                imageName = "drinking-water-thumbnail"
            case 2:
                imageName = "physical-exercises-thumbnail"
            case 3:
                imageName = "healthy-eating-thumbnail"
            case 4:
                imageName = "reading-thumbnail"
            default:
                imageName = ""
            }
            return imageName
        }
    }
