var _w = ds_grid_width(argument0)
var _h = ds_grid_height(argument0)


var _buffer = buffer_create(_w*_h+2,buffer_fixed,1);
buffer_write(_buffer,buffer_u8,_w)
buffer_write(_buffer,buffer_u8,_h)

for(var _y=0; _y<_h; _y++)
for(var _x=0; _x<_w; _x++)
{
	buffer_write(_buffer,buffer_u8,ds_grid_get(argument0,_x,_y));
}

return _buffer;