package rendering;

import kha.math.FastVector2;
import kha.Image;
import components.Radius;
import edge.ISystem;
import edge.Engine;

import components.Star;
import components.Position;
import components.Resource; 

import kha.Framebuffer;
import kha.graphics2.GraphicsExtension;
import kha.graphics2.Graphics;

using kha.graphics2.GraphicsExtension;

class RenderStar implements IRender implements ISystem{
	
	var engine : Engine;
	public var frame : Framebuffer;
	public var camera : Camera;
	var p : FastVector2 = new FastVector2(0,0 );

	public function new(camera : Camera):Void {
		this.camera = camera;
	}

	function update( star : Star, position : Position, radius : Radius){
		var g : kha.graphics2.Graphics = frame.g2;
		g.color = kha.Color.Yellow;
		p.x = position.pos.x;
		p.y = position.pos.y;
		var pos = camera.getViewMatrix().multvec(p);
		g.fillCircle(pos.x, pos.y,radius.radius*camera.zoom);
	}
}