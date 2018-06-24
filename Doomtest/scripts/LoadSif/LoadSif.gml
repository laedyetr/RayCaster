var _File = file_bin_open(argument0,0);
var ret = ds_list_create();
ds_list_add(ret,file_bin_read_byte(_File));
ds_list_add(ret,file_bin_read_byte(_File));
file_bin_close(_File);
var _buffer = buffer_create(ret[| 0]*ret[| 1]+2,buffer_fixed,1);
buffer_load_ext(_buffer,argument0,0)

return _buffer;


/*
var ret = ds_list_create();
ds_list_add(ret,file_bin_read_byte(_File));
ds_list_add(ret,file_bin_read_byte(_File));
var _buffer = buffer_create(ret[| 0]*ret[| 1],buffer_fixed,1);


buffer_write(_buffer,buffer_u8,ret[| 0]);
buffer_write(_buffer,buffer_u8,ret[| 1]);

var done = false;
var _pos = 2;
repeat(ret[| 0]*ret[| 1])
{
	buffer_write(_buffer,buffer_u8,file_bin_read_byte(_File));
}

return _buffer;