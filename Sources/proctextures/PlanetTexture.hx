package proctextures;
import kha.Image;
import edge.IComponent;

class PlanetTexture implements IComponent implements IProcTexture{
    public var width(default, default) : Int;
    public var height(default, default) : Int;
    public var texture(default, default) : Image;
}
