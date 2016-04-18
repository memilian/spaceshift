package components;

import thx.unit.angle.Degree;
import thx.unit.angle.Radian;
import edge.IComponent;
import edge.Entity;

class Orbit implements IComponent{
	public var radius : Float;
	public var radialVelocity : Degree;
	public var orbitingBody : Entity;
	public var angle : Degree = cast 0. ;
}