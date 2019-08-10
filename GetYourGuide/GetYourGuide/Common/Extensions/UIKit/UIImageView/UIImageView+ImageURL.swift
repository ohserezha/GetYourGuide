//
//  Created by Nickolay Sheika on 2019-08-10.
//  Copyright © 2019 Nickolay Sheika. All rights reserved.
//

import Kingfisher

extension UIImageView {
	func setImage(with url: URL?, placeholder: UIImage? = nil) {
		kf.setImage(with: url, placeholder: placeholder)
	}

	func cancelImageLoading() {
		kf.cancelDownloadTask()
	}
}
