package proctextures;

import thx.Floats;
import kha.Color;
import kha.graphics4.TextureFormat;
import components.Radius;
import generators.RNG;
import libnoise.generator.Billow;
import libnoise.generator.Perlin;
import libnoise.ModuleBase;

import components.Orbit;
import components.Planet;

import edge.ISystem;

class PlanetTextureGenerator implements ISystem{

    var module : ModuleBase;

    public function new() {
        module = new Billow(0.03, 1.0, 0.5, 8,RNG.seed+123, HIGH);
    }

    public function update( planet : Planet, radius : Radius, orbit : Orbit, texture : PlanetTexture):Void {
        if(texture.texture == null){
            var dim : Int =cast Math.ceil(2*radius.radius);
            texture.texture = kha.Image.createRenderTarget(dim, dim, TextureFormat.RGBA32, NoDepthAndStencil, 8);
            var g = texture.texture.g2;
            g.begin(true, Color.fromBytes(0,0,0,0));
            var rad : Float = radius.radius;
            var radSq = rad * rad;

            for(a in 0...dim){
                for(b in 0...dim){
                    var as = a - rad;
                    var bs = b - rad;
                    if((as*as + bs*bs) > radSq) continue;
/*
                    var phi = Floats.interpolate(a/dim,0,Math.PI/2);
                    var theta = Floats.interpolate(b/dim,0,Math.PI/2);
*/
                    var x = as;//rad * Math.sin(theta) * Math.cos(phi);
                    var z = bs;//rad * Math.sin(theta) * Math.sin(phi);
                    var y = Math.sqrt(rad*rad-as*as-bs*bs);//rad * Math.cos(theta);
                    var value : Float = Floats.clamp(module.getValue(x,y,z),-1,1)/2 +0.5;
                    g.color = Color.fromFloats(value,value,value,1);
                    g.drawRect(a,b,1,1);
                }
            }
            g.end();
        }

    }

}
