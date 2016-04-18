package rendering;

import kha.math.FastVector2;
import kha.math.FastMatrix3;
import components.Rotation;
import kha.math.FastVector4;
import components.Player;
import kha.Image;
import edge.ISystem;
import edge.Engine;

import components.Planet;
import components.Position;
import components.Resource;

import kha.Framebuffer;

class RenderPlayer implements IRender implements ISystem{
	
	var engine : Engine;
	public var frame : Framebuffer;
	public var camera : Camera;
	var p : FastVector2 = new FastVector2(0,0);

	public function new(camera : Camera):Void {
		this.camera = camera;
	}

	function update( player : Player, position : Position, rot : Rotation){
		var g : kha.graphics2.Graphics = frame.g2;
		g.color = kha.Color.Orange;
		p.x = position.pos.x;
		p.y = position.pos.y;
		var pos = camera.getViewMatrix().multvec(p);
		g.pushRotation(rot.rotation.toRadian(), pos.x+25*camera.zoom,pos.y+25*camera.zoom);
		g.drawRect(pos.x, pos.y,50*camera.zoom,50*camera.zoom,5);
		g.popTransformation();
	}
}