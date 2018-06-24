///SifCreateSurface(sif)
///@param sif



var _buf = argument0
buffer_seek(argument0,buffer_seek_start,0);

var _Width = buffer_read(_buf,buffer_u8);
var _Height = buffer_read(_buf,buffer_u8);

var _surf = surface_create(_Width,_Height);

surface_set_target(_surf)
for(var _y=0; _y<_Height; _y++)
for(var _x=0; _x<_Width; _x++)
{
	var col = buffer_read(_buf,buffer_u8)
	
	
	draw_set_colour(global.Pallete[| col])
	draw_point(_x,_y)
	
}
surface_reset_target()

return _surf;