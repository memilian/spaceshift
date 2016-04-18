package ;

import kha.math.FastMatrix3;
import kha.math.FastVector3;
import kha.math.FastVector2;
import kha.Scheduler;
import kha.System;
import input.Dispatcher;

class Camera implements edge.IComponent{

    static public var the(default,null) : Camera;

    public var view(default, null) : FastMatrix3;
    public var scale(default, null) : FastMatrix3;
    public var translation(default, null) : FastMatrix3;

    var target : FastVector2;
    var position : FastVector2;

    var zoom = 1.0;
    var minZoom = 0.01;
    var maxZoom = 3.0;
    var rotation = 0.0;
    var origin : FastVector2;
    var centerOffset(get,null) : FastVector2;



    private function get_centerOffset():FastVector2 {
        return origin.mult(1/zoom);
    }

    public function new() {
        the = this;
        this.position = new FastVector2(0,0);
        origin = new FastVector2(halfScreenWidth(), halfScreenHeight());
        Dispatcher.the.mouseNotify(null,null,null,null, onMouseWheel);
        #if js
            untyped js.Browser.window["vector"] = FastVector2;
            untyped js.Browser.window["camera"] = this;
        #end
    }

    inline public function halfScreenWidth() {
        return System.windowWidth() / 2 ;
    }

    inline public function halfScreenHeight() {
        return System.windowHeight() / 2  ;
    }

    var tweening = false;
    public function centerOn(pos : FastVector2):Void {
        if(tweening) return;
        target = new FastVector2(pos.x, pos.y);

        var steps = 20.0;
        var dx = (target.x - position.x)/steps;
        var dy = (target.y - position.y)/steps;

        tweening = true;
        Scheduler.addBreakableFrameTask(function(){
            if(steps-- <= 0 ){
                tweening = false;
                return false;
            }
            position.x += dx;
            position.y += dy;
            return true;
        }, 0);

    }

    public function onMouseWheel(dw : Int){
        var dzoom = dw < 0  ? 0.1 : -0.1;
        var its = 20.;
        var step = dzoom/20;

        Scheduler.addBreakableFrameTask(function(){
            if(its-- <= 0 ) return false;
            zoom += step;
            if(zoom < minZoom) zoom = minZoom;
            if(zoom > maxZoom) zoom = maxZoom;
            return true;
        }, 0);
    }

    public function getViewMatrix(parallax=1.0):FastMatrix3 {
        scale = FastMatrix3.scale(zoom,zoom);
        translation = FastMatrix3.translation(-position.x * parallax+centerOffset.x, -position.y * parallax + centerOffset.y);
        return FastMatrix3.identity()
            .multmat(scale)
            .multmat(translation)
        ;
    }
}
