///SifGetColour(texture,x,y)

var _buf = argument0
buffer_seek(argument0,buffer_seek_start,0);

var _Width = buffer_read(_buf,buffer_u8);
var _Height = buffer_read(_buf,buffer_u8);

buffer_seek(_buf,buffer_seek_start,2+ (clamp(argument2,0,_Height-1)*_Height+clamp(argument1,0,_Width-1)) )
return buffer_read(_buf,buffer_u8);