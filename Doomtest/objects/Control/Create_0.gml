global.TileSize = 32;
global.TextureSize = 8
global.Width = 16;
global.Height = 16;


global.Grid = ds_grid_create(global.Width,global.Height);





global.Pallete = ds_list_create();
ds_list_add(global.Pallete,make_colour_rgb(255,255,255))
ds_list_add(global.Pallete,make_colour_rgb(239,238,203))
ds_list_add(global.Pallete,make_colour_rgb(165,164,140))
ds_list_add(global.Pallete,make_colour_rgb(81,81,69))
ds_list_add(global.Pallete,make_colour_rgb(33,32,28))
ds_list_add(global.Pallete,make_colour_rgb(0,0,0))
ds_list_add(global.Pallete,c_white)
ds_list_add(global.Pallete,c_white)



global.WallTexture[0] = LoadSif("Wall.sif");
global.WallTexture[1] = LoadSif("Wall2.sif");
global.FloorTexture = LoadSif("Floor.sif");

global.Sprites[0] = LoadSif("Pillar.sif");
//global.Textures[1] = LoadSif("Wall2.sif");



global.MapSurf = surface_create(1,1);
alarm[0] = 2;
