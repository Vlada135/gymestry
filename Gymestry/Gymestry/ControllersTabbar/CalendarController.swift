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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.calendar = .current
        view.locale = .current
        view.fontDesign = .default
        view.delegate = self
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
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
//            make.height.equalTo(500)
            make.top.equalToSuperview().offset(16)
        }
        }
    }

extension CalendarController: UICalendarViewDelegate{
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
}
