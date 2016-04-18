package;

import kha.System;

class Main {
	public static function main() {
		System.init({ title:"SpaceShift", width: 1360, height: 768, samplesPerPixel: 8}, function () {
			new SpaceShift();
		});
	}
}
