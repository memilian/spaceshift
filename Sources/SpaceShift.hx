package;

import proctextures.PlanetTexture;
import proctextures.PlanetTextureGenerator;
import physics.UpdateVelocity;
import input.PlayerInput;
import edge.Entity;
import input.Dispatcher;
import thx.unit.angle.Degree;
import physics.UpdateOrbit;
import kha.math.FastVector2;
import generators.RNG;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.math.FastVector2;

import proctextures.IProcTexture;
import components.*;
import rendering.*;


class SpaceShift {
	
	var world : World;
	var camera : Camera;
	var player : Entity;

	public function new() {
		new Dispatcher();
		camera = new Camera();

		world = new World();
		world.start();

		world.frame.add(new PlanetTextureGenerator());

		world.render.add(new RenderStar(camera));
		world.render.add(new RenderOrbit(camera));
		world.render.add(new RenderPlanet(camera));
		world.render.add(new RenderPlayer(camera));

		world.physics.add(new PlayerInput());
		world.physics.add(new UpdateVelocity());
		world.physics.add(new UpdateOrbit());
		world.physics.add(new UpdateCamera());

		createPlayer();
		createSystem(200,200);
	}

	public function createPlayer():Void {
		player = world.engine.create([
			new Player("Fafnir"),
			new Rotation(0),
			new Position(new FastVector2(0,0)),
			new Velocity(new FastVector2(0,0)),
			new KeyBinding("z","s","q","d"," "),
			new Friction(0.95),
			createShipStats()
		]);
	}

	public function createShipStats(){
		return new ShipStats(1.0, 2, 4);
	}

	public function createSystem(x : Float, y :Float): Void{
		var starRad = RNG.rand.GetIn(155,300);
		var star = world.engine.create(
			[
				new Position(new FastVector2(x,y)),
				new Star("Sun", 2000),
				new Radius(starRad)
			]
		);

		var distance = starRad + 10;
		var planetCount = RNG.rand.GetIn(1,12);
		trace(planetCount);
		for(i in 0...planetCount){
			var rad = RNG.rand.GetIn(15,50);
			distance += RNG.rand.GetIn(30,200);
			var startAngle : Degree = RNG.rand.GetIn(0,360);
			var vel = RNG.rand.GetFloatIn(-0.5,0.5);
			var planet = world.engine.create([
				new Position(new FastVector2(x+distance, y)),
				new Orbit(distance, vel, star, startAngle),
				new Planet("Earth", []),
				new Radius(rad),
				new PlanetTexture()
			]);
			distance += 2*rad;
		}

		//static big planet to test texture
		var rad = RNG.rand.GetIn(150,250);
		distance += RNG.rand.GetIn(300,300);
		var startAngle : Degree = -180;
		var vel = 0;
		var planet = world.engine.create([
			new Position(new FastVector2(x+distance, y)),
			new Orbit(distance, vel, star, startAngle),
			new Planet("Earth", []),
			new Radius(rad),
			new PlanetTexture()
		]);

	}

}
