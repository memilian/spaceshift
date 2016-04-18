package rendering;

import proctextures.PlanetTexture;
import kha.math.FastVector2;
import components.Radius;
import edge.ISystem;
import edge.Engine;

import components.Planet;
import components.Position;

import kha.Framebuffer;
import kha.graphics2.GraphicsExtension;
import kha.graphics2.Graphics;

using kha.graphics2.GraphicsExtension;

class RenderPlanet implements IRender implements ISystem{
	
	var engine : Engine;
	public var frame : Framebuffer;
	public var camera : Camera;
	var p : FastVector2 = new FastVector2(0,0 );

	public function new(camera : Camera): Void {
		this.camera = camera;
	}

	function update( planet : Planet, position : Position, radius : Radius, texture : PlanetTexture){
		var g : Graphics = frame.g2;
		g.color = kha.Color.Red;
		p.x = position.pos.x;
		p.y = position.pos.y;
		var pos = camera.getViewMatrix().multvec(p);
		//g.fillCircle(pos.x, pos.y,radius.radius * camera.zoom);
		var scaledRadius = radius.radius * camera.zoom;
		g.drawScaledImage(texture.texture, pos.x-scaledRadius/2, pos.y-scaledRadius/2, scaledRadius, scaledRadius);
	}
}