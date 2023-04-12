enum AlertType {
}

extension AlertType {
	struct Action {
		let callback: ()->()
	}
}

extension AlertType: Identifiable {
	var id: String {
		switch self {
		}
	}
}
