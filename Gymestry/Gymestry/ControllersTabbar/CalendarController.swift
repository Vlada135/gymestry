//
//  CalendarController.swift
//  Gymestry
//
//  Created by Владислава on 17.09.23.
//

import Foundation
import UIKit
import SnapKit
import CalendarKit

class CalendarController: UIViewController {
    
    lazy var calendarView: UICalendarView = {
        let view = UICalendarView()
        //        view.translatesAutoresizingMaskIntoConstraints = false
        view.calendar = .current
        view.locale = .current
        view.fontDesign = .rounded
        view.delegate = self
        let selection = UICalendarSelectionSingleDate(delegate: self)
        view.selectionBehavior = selection
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
    }
    
    private func makeLayout() {
        view.backgroundColor = .white
        title = "Календарь"
        view.addSubview(calendarView)
    }
    
    private func makeConstraints() {
        calendarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension CalendarController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        print(dateComponents)
    }
}

extension CalendarController: UICalendarViewDelegate{
    
}
