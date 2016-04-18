package ;

import edge.Entity;

@:access(edge.Entity)
class EntityHelper {
    static function get(entity : edge.Entity, classname : String) : edge.IComponent{
        return cast entity.map.get(classname);
    }
}
