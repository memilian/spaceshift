package components;

import edge.IComponent;

class Resource implements IComponent{
	public var name : String;
	public var quantity : Float;
	public var type : ResourceType;
}

enum ResourceType{
	MINERAL;
	FOOD;
	ENERGY;
}