//
//  CalendarViewController.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/15.
//

import UIKit
import Combine


protocol CalendarViewControllerDelegate {
    func ViewController(viewController: CalendarViewController,
                        didClickDay time: SpecificTime)
}
class CalendarViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!{
        didSet{
            calendarCollectionView.register(nibSupplementaryView: HeaderCollectionReusableView.self, kind: UICollectionView.elementKindSectionHeader)
            calendarCollectionView.register(nibCell: TimeCollectionViewCell.self)
        }
    }
    @IBOutlet weak var timeRangeLabel: UILabel!
    @IBOutlet weak var timeZoneLabel: UILabel!{
        didSet{
            let calendar = Calendar.current
            timeZoneLabel.text = String(format: NSLocalizedString("timezone", comment: "") , arguments:[calendar.timeZone.identifier , calendar.timeZone.abbreviation() ?? "" ])
        }
    }
    @IBOutlet weak var previousWeekButton: UIButton!
    @IBOutlet weak var nextWeekButton: UIButton!
    
    
    // MARK: - Private
    private var calendarManager = CalendarManager()
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: CalendarViewModel!
    var delegate: CalendarViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBindins()
    }
    
    
    func setupBindins(){
        subscriptions = [
            calendarManager.$timeRangeString.assign(to: \.text!, on: timeRangeLabel)
        ]
        
        viewModel.$schedule.sink { [weak self] _ in
            guard let strongSelf = self else{
                return
            }
            strongSelf.calendarCollectionView.reloadData()
        }.store(in: &subscriptions)
        
        viewModel.$isPreviousActionEnable.sink { [weak self] (isEnable) in
            guard let strongSelf = self else{
                return
            }
            strongSelf.previousWeekButton.setTitleColor(isEnable ? UIColor.darkGray : UIColor.lightGray , for: .normal)
            strongSelf.previousWeekButton.isUserInteractionEnabled = isEnable
        }.store(in: &subscriptions)
        
        viewModel.$isNextActionEnable.sink { [weak self] (isEnable) in
            guard let strongSelf = self else{
                return
            }
            strongSelf.nextWeekButton.setTitleColor(isEnable ? UIColor.darkGray : UIColor.lightGray , for: .normal)
            strongSelf.nextWeekButton.isUserInteractionEnabled = isEnable
        }.store(in: &subscriptions)
    }
    
    @IBAction func onClickVerso(){
        calendarManager.updatePreviousWeeksDay()
        viewModel.getPreviousSchedule()
    }
    
    @IBAction func onClickRecto(){
        calendarManager.updateNextWeeksDay()
        viewModel.getNextSchedule()
    }

}

extension CalendarViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getNumberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfItemsInSection(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = viewModel.getSpecificTime(at: indexPath.row, section: indexPath.section) else {
            fatalError()
        }
        let cell = collectionView.reusableCell(for: indexPath) as TimeCollectionViewCell
        cell.config(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.reusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath) as HeaderCollectionReusableView
            let item = viewModel.getSpecificDay(at: indexPath.section)
            header.config(item: item)
            return header
        default:
            fatalError()
        }
    }
}

extension CalendarViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = viewModel.getSpecificTime(at: indexPath.row, section: indexPath.section) else {
            fatalError()
        }
        self.delegate?.ViewController(viewController: self, didClickDay: item)
    }
}
