package rendering;

import kha.math.FastVector2;
import kha.math.FastVector4;
import kha.Image;
import edge.Entity;
import edge.ISystem;
import edge.Engine;

import components.Position;
import components.Orbit;

import kha.Framebuffer;
import kha.graphics2.GraphicsExtension;
import kha.graphics2.Graphics;

using kha.graphics2.GraphicsExtension;
using EntityHelper;

@:access(edge.Entity)
class RenderOrbit implements IRender implements ISystem{
	
	var engine : Engine;

	public var frame : Framebuffer;
	public var camera : Camera;

	var p : FastVector2 = new FastVector2(0,0 );

	public function new(camera : Camera):Void {
		this.camera = camera;
	}

	function update( orbit : Orbit){
		var g : Graphics = frame.g2;
		g.color = kha.Color.White;
		var star : Entity = orbit.orbitingBody;
		var position : components.Position = cast star.map.get('components.Position');
		p.x = position.pos.x;
		p.y = position.pos.y;
		var pos = camera.getViewMatrix().multvec(p);
		g.drawCircle(pos.x, pos.y, orbit.radius*camera.zoom,2);
	}
}