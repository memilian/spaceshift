package input;

import components.ShipStats;
import kha.math.FastVector2;
import components.Rotation;
import components.KeyBinding;
import components.Velocity;
import components.Player;
import edge.ISystem;
import components.Position;

class PlayerInput implements ISystem{

    public function update(player : Player, position : Position, velocity : Velocity, rotation : Rotation, ship : ShipStats, keybinding : KeyBinding) : Void {
        if(Dispatcher.the.isKeyDown(keybinding.brake)){
            velocity.velocity = velocity.velocity.mult(0.95);
        }
        if(Dispatcher.the.isKeyDown(keybinding.throttle)){
            var direction = new FastVector2(rotation.rotation.cos(), rotation.rotation.sin());
            velocity.velocity = velocity.velocity.add(direction.mult(ship.acceleration));
            if(velocity.velocity.length > ship.maxSpeed){
                velocity.velocity.normalize();
                velocity.velocity = velocity.velocity.mult(ship.maxSpeed);
            }
        }
        if(Dispatcher.the.isKeyDown(keybinding.turnright)){
            rotation.rotation += ship.turnRate;
        }
        if(Dispatcher.the.isKeyDown(keybinding.turnleft)){
            rotation.rotation += -ship.turnRate;
        }
    }
}
