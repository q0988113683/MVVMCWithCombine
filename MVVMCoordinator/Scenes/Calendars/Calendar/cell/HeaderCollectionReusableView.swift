

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    private var isAvailable = true {
        didSet{
            if isAvailable{
                colorLabel.backgroundColor =  UIColor().greenColor()
            }else{
                colorLabel.backgroundColor = UIColor().grayColor()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(item: SpecificDay) {
        if let date = item.date, let day = date.day(){
            dayLabel.text = String(describing: day)
            weekLabel.text = date.week()
        }
        isAvailable = item.times != nil && item.times!.count > 0
    }
    
}
