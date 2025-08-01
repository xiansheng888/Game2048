local TileCell = BaseClass("TileCell")

local function __init(self,go,col,row)
   self.gameobject = go;
   self.transform = go.transform;
   self.coordinates = {x=col,y=row}
 
end

local function Start(self)
     
end

local function SetTile(self,tile)
   
    self.tile = tile;
end


local function Update(self)
    print("TileCell   Update")
end

local function IsOccupied(self)
    return self.tile~=nil;
end


TileCell.Start = Start;
TileCell.__init = __init;
TileCell.SetTile = SetTile;
TileCell.IsOccupied = IsOccupied;


 
return TileCell