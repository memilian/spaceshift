package physics;

import edge.Entity;
import components.Position;
import components.Orbit;
import edge.ISystem;

@:access(edge.Entity)
class UpdateOrbit implements ISystem{

    public function update(orbit : Orbit, position : Position) : Void {
        var starPos : Position = cast orbit.orbitingBody.map.get('components.Position');
        orbit.angle += orbit.radialVelocity;
        position.pos.x = starPos.pos.x + orbit.angle.cos() * orbit.radius;
        position.pos.y = starPos.pos.y + orbit.angle.sin() * orbit.radius;
    }
}
