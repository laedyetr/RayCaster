///CastRay(x,y,xdir,ydir)
///@param x
///@param y
///@param xdir
///@param ydir

_x = argument0/global.TileSize;
_y = argument1/global.TileSize;

_rDx = argument2;
_rDy = argument3;

_Mx = floor(_x);
_My = floor(_y);



if(_rDx = 0){_rDx = 0.0001}

if(_rDy = 0){_rDy = 0.0001}

_SDistX = 0;
_SDistY = 0;

_DDistX = abs(1 / _rDx)//sqrt(1 + (_rDy * _rDy) / (_rDx * _rDx));
_DDistY = abs(1 / _rDy)//sqrt(1 + (_rDx * _rDx) / (_rDy * _rDy));
_perpD = 0;


hit = -2;
side = 0;
_sx = 0;
_sy = 0;

if(_rDx < 0)
{
    _sx = -1;
    _SDistX = (_x - _Mx) * _DDistX;
}

if(_rDx > 0)
{
    _sx = 1;
    _SDistX = (_Mx + 1 -_x) * _DDistX;
}

if(_rDy < 0)
{
    _sy = -1;
    _SDistY = (_y - _My) * _DDistY;
}

if(_rDy > 0)
{
    _sy = 1;
    _SDistY = (_My + 1 -_y) * _DDistY;
}


for(g=0; g<64; g+=1)
{
    if(_SDistX < _SDistY)
    {
        _SDistX += _DDistX;
        _Mx += _sx;
        side = 0;
    }
    else
    {
        _SDistY += _DDistY;
        _My += _sy;
        side = 1;
    }
    
    if(_Mx>0 and _Mx<global.Width and _My>0 and _My<global.Height)
    {
    
        if(global.Grid[# _Mx,_My] > 0)
        { 
            hit = global.Grid[# _Mx,_My];
        }
    }
    else
    {
        hit = -1;
    }

    if(hit!=-2)
    {
    break;
    }
}

if(side = 0)
{
    _perpD  = abs((_Mx - _x + (1 - _sx)/2)/_rDx);
}
else
{
    _perpD  = abs((_My - _y + (1 - _sy)/2)/_rDy);
}


return hit;
