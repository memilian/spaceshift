package components;

import kha.math.FastVector2;
import edge.IComponent; 

class Position implements IComponent{
	
	public var pos : FastVector2;
	
	public function new(pos : FastVector2): Void{
		this.pos = pos;
	}
}