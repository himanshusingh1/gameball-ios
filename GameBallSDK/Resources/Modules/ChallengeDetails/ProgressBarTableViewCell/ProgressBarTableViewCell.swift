//
//  ProgressBarTableViewCell.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 7/31/19.
//

import UIKit

class ProgressBarTableViewCell: UITableViewCell {

    
    @IBOutlet weak var progressLabel: UILabel!{
        didSet{
            progressLabel.text = LocalizationsKeys.ChallengeDetails.progress.rawValue.localized
            
            progressLabel.textColor = Colors.appMainColor
            
            if Localizator.sharedInstance.language == Languages.arabic {
                progressLabel.font = Fonts.cairoBoldFont16
                
            } else {
                progressLabel.font = Fonts.montserratSemiBoldFont16
            }
        }
    }
    @IBOutlet weak var proressDedailsLabel: UILabel!{
        didSet{
           // proressDedailsLabel.text = LocalizationsKeys.ChallengeDetails.status.rawValue.localized
            
            proressDedailsLabel.textColor = Colors.appGray128
            
            if Localizator.sharedInstance.language == Languages.arabic {
                proressDedailsLabel.font = Fonts.cairoRegularFont10
                
            } else {
                proressDedailsLabel.font = Fonts.montserratLightFont10
            }
        }
    }
    
    @IBOutlet weak var progressLeftLabel: UILabel!{
        didSet{
            // proressDedailsLabel.text = LocalizationsKeys.ChallengeDetails.status.rawValue.localized
            
            progressLeftLabel.textColor = Colors.appGray128
            
            if Localizator.sharedInstance.language == Languages.arabic {
                progressLeftLabel.font = Fonts.cairoBoldFont10
                
            } else {
                progressLeftLabel.font = Fonts.montserratSemiBoldFont10
            }
        }
    }
    
    @IBOutlet weak var progressView: ProgressView!
    
    
    
    var challenge: Challenge?{
        didSet{
            
            progressLeftLabel.text = "\(challenge?.targetAmount ?? 0)"
            self.progressView.properties = ProgressViewProperties(backgroundColor: Colors.appGray242, filledColor: Colors.appMainColor ?? .black, percentageFilled:Float((challenge?.completionPercentage ?? 0)/100.0))
            
            
            switch challenge?.challengeType ?? .unkown {
            case .FriendReferal:
                progressLeftLabel.text = "\(challenge?.targetActionsCount ?? 0)"
                let targetActionsCount = (challenge?.targetActionsCount ?? 0)
                let completionPercentage =  (challenge?.completionPercentage ?? 0)
                
                let leftNumber = (targetActionsCount * Int(completionPercentage)) / 100
                
                
                 proressDedailsLabel.text = "\(Int(leftNumber)) \(LocalizationsKeys.ChallengeDetails.friendsRemaining.rawValue.localized)"
                
            case .EventBased:
                proressDedailsLabel.text = LocalizationsKeys.ChallengeDetails.trackProgress.rawValue.localized
                progressLeftLabel.text = ""
            default:
                 proressDedailsLabel.text = ""
                progressLeftLabel.text = ""
            }
            
            
            
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}