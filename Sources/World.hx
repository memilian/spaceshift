import kha.math.FastMatrix3;
import kha.math.FastMatrix3;
import kha.math.FastMatrix4;
import kha.graphics4.TextureFormat;
import kha.Image;
import kha.Color;
import edge.Phase;
import edge.Engine;

import kha.Scheduler;
import kha.System;
import kha.Framebuffer;

import rendering.*;
		

import kha.graphics2.GraphicsExtension;
using kha.graphics2.GraphicsExtension;

class World{
	public var frame(default, null) : Phase;
	public var physics(default, null) : Phase;
	public var render(default, null) : Phase;
	public var engine(default, null) : Engine;
	public var delta(default, null) : Float;
	public var running(default, null) : Bool;

	public var fps(default, null) : Float;
	
	var cancel : Void -> Void;
	var remainder : Float;

	public function new() {
		engine  = new Engine();
		frame   = engine.createPhase();
		physics = engine.createPhase();
		render  = engine.createPhase();
		remainder = 0;
		running = false;
		this.delta = 1 / 60;
		System.notifyOnRender(onrender);
	}

	public function start() {
		if(running) return;
		running = true;
		Scheduler.addFrameTask(run, 0);
	}

	var buff = Image.createRenderTarget(System.windowWidth(), System.windowHeight(),  TextureFormat.RGBA32, null, 16);
	var lastRender = 0.;
	public function onrender(g : Framebuffer): Void{
		var t = Scheduler.time()-lastRender;

		fps = Math.floor(1/t*10)/10;
		if(Math.floor(Scheduler.time()) !=  Math.floor(lastRender))
		trace("fps => "+fps);
		for(sys in render.systems()){
			var renderer : IRender = cast sys;
			renderer.frame = g;
		}

		g.g2.begin(true, Color.Black);
		render.update(t);
		g.g2.end();

		lastRender = Scheduler.time();
	}

	var lastUpdate = 0.;
	function run() {
		var t = Scheduler.time()-lastUpdate;
		
		frame.update(t);
		var dt = t + remainder;
		while(dt > delta) {
			dt -= delta;
			physics.update(delta);
		}
		remainder = dt;
		lastUpdate = Scheduler.time();
	}
	
	function nothing(){
		var frame : kha.Framebuffer;
		
	}

}