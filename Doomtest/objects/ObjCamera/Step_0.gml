if(!surface_exists(global.CamSurf))
{
	global.CamSurf = surface_create(Rays,Rays);
}
	
//Angle += (keyboard_check(vk_right) - keyboard_check(vk_left))*2.2

var rotSpeed = 0.1;
if(keyboard_check(vk_left))
{
	var oldDirX = AngleVec[0];
    AngleVec[0] = AngleVec[0] * cos(rotSpeed) - AngleVec[1] * sin(rotSpeed);
    AngleVec[1] = oldDirX * sin(rotSpeed) + AngleVec[1] * cos(rotSpeed);
    var oldPlaneX = Plane[0];
    Plane[0] = Plane[0] * cos(rotSpeed) - Plane[1] * sin(rotSpeed);
    Plane[1] = oldPlaneX * sin(rotSpeed) + Plane[1] * cos(rotSpeed);
}
if(keyboard_check(vk_right))
{
	var oldDirX = AngleVec[0];
    AngleVec[0] = AngleVec[0] * cos(-rotSpeed) - AngleVec[1] * sin(-rotSpeed);
    AngleVec[1] = oldDirX * sin(-rotSpeed) + AngleVec[1] * cos(-rotSpeed);
    var oldPlaneX = Plane[0];
    Plane[0] = Plane[0] * cos(-rotSpeed) - Plane[1] * sin(-rotSpeed);
    Plane[1] = oldPlaneX * sin(-rotSpeed) + Plane[1] * cos(-rotSpeed);
}
Angle = point_direction(0,0,AngleVec[0],AngleVec[1]);

x += lengthdir_x((keyboard_check(ord("S")) - keyboard_check(ord("W")))*2,Angle+180)
y += lengthdir_y((keyboard_check(ord("S")) - keyboard_check(ord("W")))*2,Angle+180)
x += lengthdir_x((keyboard_check(ord("A")) - keyboard_check(ord("D")))*-2,Angle+90)
y += lengthdir_y((keyboard_check(ord("A")) - keyboard_check(ord("D")))*-2,Angle+90)




Bob += (keyboard_check(ord("A")) | keyboard_check(ord("D")) | 
		keyboard_check(ord("S")) | keyboard_check(ord("W")))*12;
z = cos(degtorad(Bob))*.5+.5;









draw_set_colour(c_white)
surface_set_target(global.CamSurf)
draw_sprite_stretched(sprite0,0,0,0,Rays,Rays);
//draw_clear(c_black);


with(ObjSprite)
{
	ds_priority_add(ObjCamera.SpritePriority,id,point_distance(x,y,ObjCamera.x,ObjCamera.y));
}

for(var ray=0; ray<Rays; ray++)
{
	//var a = Angle + (-Rays/2+ray)*Fov;
	
	CameraX = 2 * ray / Rays - 1;
	var xdir = AngleVec[0] + Plane[0] * CameraX;//lengthdir_x(1,a)
	var ydir = AngleVec[1] + Plane[1] * CameraX;//lengthdir_y(1,a)
	//var xdir = lengthdir_x(1,a)
	//var ydir = lengthdir_y(1,a)
	//show_debug_message(string(xdir) + " " + string(ydir) + " " + string(CameraX));
	var cast = CastRay(x,y,xdir,ydir);
	
	ZBuffer[ray] = _perpD;
	
	//_perpD = 0;
	
	
	var Wx = 0;
    if(side = 0)
    {
        Wx = y/global.TileSize + _perpD * ydir;
    }
    else
    {
        Wx = x/global.TileSize + _perpD * xdir;
    }
    Wx -= floor(Wx);
    
        
    var Tx = floor(Wx * 8);
        
    if(side == 0 and xdir > 0)
    {
        Tx = 8 - Tx - 1;
    }
    if(side == 1 and ydir < 0)
    {
        Tx = 8 - Tx - 1;
    }
	draw_set_colour(c_white)
	
	var NewD = _perpD;
	var Off = -3+z*((-NewD+80)/16)
	var LH = Rays/NewD;

	
	var Fog = min(5,floor(_perpD/2));
	
	var strt = (-LH/2 + Rays/2)/Rays;
	var ennd = (LH/2 + Rays/2)/Rays;
	var h = ennd - strt;
	for(var i=strt*Rays; i<ennd*Rays; i++)
	{
		var col = SifGetColour(global.WallTexture[max(0,cast-1)],Tx,floor( 8*(((i-strt*Rays)/Rays)/h) ))
		col = clamp(col+Fog,0,5);
		draw_point_color(ray,i+Off,global.Pallete[| col])
	}
	
	//draw_line(ray,Rays/2-(convertd*(Rays/2)),ray,Rays/2+(convertd*(Rays/2)))

		var FloorXWall,FloorYWall,distWall,distPlayer,cDist;
		cDist = 0;
		distWall = _perpD;
		distPlayer = 0;
		if(side == 0 and xdir > 0)
		{
			FloorXWall = _Mx;
			FloorYWall = _My + Wx;
		}
		else if(side == 0 and xdir < 0)
		{
			FloorXWall = _Mx + 1;
			FloorYWall = _My + Wx;
		}
		else if(side == 1 and ydir > 0)
		{
			FloorXWall = _Mx + Wx;
			FloorYWall = _My;
		}
		else
		{
			FloorXWall = _Mx + Wx;
			FloorYWall = _My + 1;
		}
		var DE = ennd*Rays
		if(DE < 0){ 
		DE = Rays;
		}
		
		for(var t = DE; t < Rays; t+=1)
		{
			cDist = Rays / (2 * t - Rays);
			var W,Cx,Cy,Tx,Ty;
			W = (cDist - distPlayer) / (distWall - distPlayer);
			
			Cx = W * FloorXWall + (1 - W) * (x/global.TileSize);
			Cy = W * FloorYWall + (1 - W) * (y/global.TileSize);
			
			Tx = floor(floor(Cx * global.TextureSize) % global.TextureSize);
			Ty = floor(floor(Cy * global.TextureSize) % global.TextureSize);
			
			//show_message(Tx)
			//make_color_rgb(Tx*(255/16),Ty*(255/16),255))//  
			
			var col = SifGetColour(global.FloorTexture,min(Tx,global.TextureSize-1), min(Ty,global.TextureSize-1) )
			Fog = min(5,floor(cDist/2));
			col = clamp(col+Fog,0,5);
			
			
			draw_point_color(ray,t+Off,global.Pallete[| col])
			draw_point_color(ray,Rays-t+Off,global.Pallete[| col])
			
		}
	

}
while(!ds_priority_empty(SpritePriority))
{
	var ID = ds_priority_delete_max(SpritePriority);
	var sprx = (ID.x-x)/global.TileSize;
	var spry = (ID.y-y)/global.TileSize;
	
	var invdet = 1/(Plane[0]*AngleVec[1]-AngleVec[0]*Plane[1]);
	var TransX = invdet * (AngleVec[1] * sprx - AngleVec[0] * spry)
	var TransY = invdet * (-Plane[1] * sprx + Plane[0] * spry)
	
	var SpriteX = floor((Rays/2) * (1 + TransX / TransY))
	
	var SpriteH = abs(floor(Rays / TransY));
	var ystrt = clamp(-SpriteH/2 + Rays/2,0,Rays);
	var yennd = clamp(SpriteH/2 + Rays/2,0,Rays);
	
	var SpriteW = SpriteH;
	var xstrt = clamp(-SpriteW/2 + SpriteX,0,Rays);
	var xennd = clamp(SpriteW/2 + SpriteX,0,Rays);
	//show_debug_message(string(TransX) + " | " + string(TransY));
	
	var NewD = TransY;
	var Off = -3+z*((-NewD+80)/16)
	
	for(var spx = floor(xstrt); spx<floor(xennd); spx++)
	{
		var TexX = floor((256 * (spx - (-SpriteW / 2 + SpriteX)) * global.TextureSize / SpriteW) / 256);
		if(TransY > 0 and spx >= 0 and spx < Rays and abs(TransY) < ZBuffer[spx])
		{
			for(var spy = floor(ystrt); spy<floor(yennd); spy++)
			{
				//show_debug_message("pooop");
				var d = spy * 256 - Rays * 128 + SpriteH * 128;
				var TexY = ((d*global.TextureSize) / SpriteH) / 256;
				var col = SifGetColour(global.Sprites[ID.Type],floor(TexX),floor(TexY) )
				//show_debug_message(string(TransX) + " | " + string(TransY));
				
				if(col != 7)
				{
					Fog = min(5,abs(floor(TransY/2)));
					col = clamp(col+Fog,0,5);
	
					
					draw_point_color(spx,spy+Off,global.Pallete[| col])
				}
				//draw_point_color(ray,Rays-t+Off,global.Pallete[| col])
			}
		}
	
	}
	
}

//ds_priority_clear(SpritePriority);


//DrawSif(global.FloorTexture,0,0)

draw_sprite_stretched(sprite1,0,0,0,Rays,Rays);
surface_reset_target();

//Angle++;