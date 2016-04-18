package physics;

import components.Position;
import components.Velocity;
import edge.ISystem;

class UpdateVelocity implements ISystem{

    public function update(pos:Position, vel:Velocity):Void {
        pos.pos = pos.pos.add(vel.velocity);
        vel.velocity.mult(0.95);
    }
}
