package proctextures;

import kha.Image;

interface IProcTexture{
	var width(default, default) : Int;
	var height(default, default) : Int;
	var texture(default, default) : Image;
}