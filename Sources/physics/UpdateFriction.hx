package physics;
import components.Velocity;
import components.Friction;
import edge.ISystem;

class UpdateFriction implements ISystem{

    public function update(friction:Friction, vel:Velocity):Void {
        vel.velocity = vel.velocity.mult(friction.friction);
    }
}
