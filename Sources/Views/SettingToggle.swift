//
//  SettingToggle.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A simple toggle.
 */
public struct SettingToggle: View, Setting {
	public var id: AnyHashable?
	public var title: String
	@Binding public var isOn: Bool
	public var horizontalSpacing = CGFloat(12)
	public var verticalPadding = CGFloat(14)
	public var horizontalPadding = CGFloat(16)
	public var disabled: Bool = false
	public var icon: SettingIcon?
	
	public init(
		id: AnyHashable? = nil,
		icon: SettingIcon? = nil,
		title: String,
		isOn: Binding<Bool>,
		horizontalSpacing: CGFloat = CGFloat(12),
		verticalPadding: CGFloat = CGFloat(14),
		horizontalPadding: CGFloat = CGFloat(16)
	) {
		self.id = id
		self.icon = icon
		self.title = title
		self._isOn = isOn
		self.horizontalSpacing = horizontalSpacing
		self.verticalPadding = verticalPadding
		self.horizontalPadding = horizontalPadding
	}
	
	public var body: some View {
		SettingToggleView(
			title: title,
			isOn: $isOn,
			icon: icon,
			disabled: disabled,
			horizontalSpacing: horizontalSpacing,
			verticalPadding: verticalPadding,
			horizontalPadding: horizontalPadding
		)
	}
}

struct SettingToggleView: View {
    @Environment(\.edgePadding) var edgePadding
    
	let title: String
	@Binding var isOn: Bool
	
	var icon: SettingIcon?
	var disabled: Bool = false
	var horizontalSpacing = CGFloat(12)
	var verticalPadding = CGFloat(14)
	var horizontalPadding = CGFloat(16)
	
	var body: some View {
		HStack(spacing: horizontalSpacing) {
			if let icon {
				SettingIconView(icon: icon)
			}
			
			Text(title)
				.fixedSize(horizontal: false, vertical: true)
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.vertical, verticalPadding)
				.foregroundStyle(disabled ? .secondary : .primary)
			
			Toggle("", isOn: $isOn)
				.labelsHidden()
				.disabled(disabled)
		}
		.padding(.horizontal, horizontalPadding)
		.accessibilityElement(children: .combine)
	}
}

public extension SettingToggle {
	func icon(_ icon: String, color: Color = .blue) -> SettingToggle {
		var button = self
		button.icon = .system(icon: icon, backgroundColor: color)
		return button
	}
	
	func icon(_ icon: String, foregroundColor: Color = .white, backgroundColor: Color = .blue) -> SettingToggle {
		var button = self
		button.icon = .system(icon: icon, foregroundColor: foregroundColor, backgroundColor: backgroundColor)
		return button
	}
	
	func icon(icon: SettingIcon) -> SettingToggle {
		var button = self
		button.icon = icon
		return button
	}
	
	func disabled(_ disabled: Bool) -> SettingToggle {
		var button = self
		button.disabled = disabled
		return button
	}
}
