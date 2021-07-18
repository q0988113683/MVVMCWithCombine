
import UIKit

class TimeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    
    private var isAvailable = true {
        didSet{
            timeLabel.isEnabled = isAvailable
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(item: SpecificTime) {
        timeLabel.text = item.time.specificTime()
        isAvailable = item.isAvailable
    }

}
