Rays = 96;
global.CamSurf = surface_create(Rays,Rays);


Fov = 0.6;

Angle = 0;


AngleVec[0] = -1;
AngleVec[1] = 0;
Plane[0] = 0;
Plane[1] = 0.55;

ZBuffer[Rays] = 0;

Sprites = 0;
SpritePriority = ds_priority_create()


CameraX = 0;

MaxDist = 512;
z = 0;
Bob = 0;


//window_set_fullscreen(true);