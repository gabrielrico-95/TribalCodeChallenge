//
//  ContactInfoView.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 15/2/21.
//

import Foundation

protocol ContactInfoView {
    func createContactModel() -> ContactDetails
    func sendContactInfoToApi()
}
