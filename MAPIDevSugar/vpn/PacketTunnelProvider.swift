//
//  PacketTunnelProvider.swift
//  VPN
//
//  Created by 安正超 on 15/11/19.
//  Copyright © 2015年 overtrue. All rights reserved.
//

import NetworkExtension

class PacketTunnelProvider: NEPacketTunnelProvider {

	override func startTunnelWithOptions(options: [String : NSObject]?, completionHandler: (NSError?) -> Void) {
		// Add code here to start the process of connecting the tunnel.
	}

	override func stopTunnelWithReason(reason: NEProviderStopReason, completionHandler: () -> Void) {
		// Add code here to start the process of stopping the tunnel.
		completionHandler()
	}

	override func handleAppMessage(messageData: NSData, completionHandler: ((NSData?) -> Void)?) {
		// Add code here to handle the message.
		if let handler = completionHandler {
			handler(messageData)
		}
	}

	override func sleepWithCompletionHandler(completionHandler: () -> Void) {
		// Add code here to get ready to sleep.
		completionHandler()
	}

	override func wake() {
		// Add code here to wake up.
	}
}
