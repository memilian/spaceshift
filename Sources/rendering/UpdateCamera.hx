package rendering;
import components.Player;
import components.Position;
import edge.ISystem;

class UpdateCamera implements ISystem{

    public function update(player:Player, position:Position):Void {
        Camera.the.centerOn(position.pos);
    }
}
