package generators;

import kha.math.Random;
import kha.Color;

class RNG{
	
	public static var seed(default, default) : Int = 123;
	public static var rand : Random;

	public static function __init__(){
		rand = new Random(seed);
	}

	public static function color(from : Color, to : Color): Color{
		return Color.Yellow;
	}
	
}