//
//  MockData.swift
//  Example
//
//  Created by minjuniMac on 12/10/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

protocol MockType {
    var image: UIImage { get set }
    var name: String { get set }
    var explanation: String { get set }
}

protocol MockDataType {
    var information: [MockType] { get set }
}

struct Mock: MockType {
    var image: UIImage
    var name: String
    var explanation: String
}

struct MockInformation: MockDataType {
    var information: [MockType]
    init() {
        self.information = [
            Mock(image: UIImage(named: "PerseusCluster_DSSChandra_960.jpg")!,
                 name: "Unexpected X-Rays from Perseus Galaxy Cluster",
                 explanation: "Why does the Perseus galaxy cluster shine so strangely in one specific color of X-rays? No one is sure, but a much-debated hypothesis holds that these X-rays are a clue to the long-sought identity of dark matter. At the center of this mystery is a 3.5 Kilo-electronvolt (KeV) X-ray color that appears to glow excessively only when regions well outside the cluster center are observed, whereas the area directly surrounding a likely central supermassive black hole is actually deficient in 3.5 keV X-rays."),
            Mock(image: UIImage(named: "Helix_CFHT_960.jpg")!,
                 name: "The Helix Nebula from CFHT",
                 explanation: "Will our Sun look like this one day?  The Helix Nebula is one of brightest and closest examples of a planetary nebula, a gas cloud created at the end of the life of a Sun-like star. The outer gasses of the star expelled into space appear from our vantage point as if we are looking down a helix. The remnant central stellar core, destined to become a white dwarf star, glows in light so energetic it causes the previously expelled gas to fluoresce."),
            Mock(image: UIImage(named: "CarinaLakeBallard_vrbasso_WebCrop1024.jpg")!,
                 name: "Carina over Lake Ballard",
                 explanation: "A jewel of the southern sky, the Great Carina Nebula, also known as NGC 3372, is one of our galaxy's largest star forming regions. Easily visible to the unaided eye it stands high above the signature hill of Lake Ballard, ephemeral salt lake of Western Australia, in this serene night skyscape from December 25, 2017. The Milky Way itself stretches beyond the southern horizon."),
            Mock(image: UIImage(named: "DSC07952JupMars_DHan1024.jpg")!,
                 name: "Planets on the Wing",
                 explanation: "Lately, bright Jupiter and fainter Mars have been easy to spot for early morning skygazers. Before dawn on January 7 the two naked-eye planets will reach a close conjunction near the horizon, only 1/4 degree apart in predawn eastern skies. That apparent separation corresponds to about half the angular diameter of a Full Moon."),
            Mock(image: UIImage(named: "tether_tss1_960.jpg")!,
                 name: "A Tether in Space",
                 explanation: "One of the greatest unrequited legends of outer space is the tether.  Tethers, long strands of material, hold the promise of stabilizing satellites, generating electricity, and allowing easy transportation.  Possibly the most ambitious vision of the space tether is the space elevator popularized by Arthur C. Clarke, where a tether is constructed that connects the ground to geosynchronous orbit."),
            Mock(image: UIImage(named: "M31Clouds_DLopez_960.jpg")!,
                 name: "Clouds of Andromeda",
                 explanation: "What are those red clouds surrounding the Andromeda galaxy? This galaxy, M31, is often imaged by planet Earth-based astronomers. As the nearest large spiral galaxy, it is a familiar sight with dark dust lanes, bright yellowish core, and spiral arms traced by clouds of bright blue stars.  A mosaic of well-exposed broad and narrow-band image data, this colorful portrait of our neighboring island universe offers strikingly unfamiliar features though, faint reddish clouds of glowing ionized hydrogen gas in the same wide field of view.")
        ]
    }
}

