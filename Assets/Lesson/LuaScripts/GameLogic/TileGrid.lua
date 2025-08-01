local TileGrid = BaseClass("TileGrid")


local function __init(self)
   self.GameObject = GameObject.Find("Grid");
   self.transform = self.GameObject.transform;
   self.cells = {};
   self.width = 4;
   self.height = 4;
   self.size = self.width * self.height;

   for i = 1, self.size do
        local go= Tool:GetGameObject("Cell"..i)
        local tmp = TileCell.New(go, (i-1) % self.width+1, math.ceil((i)/self.width));
        table.insert(self.cells,tmp)
   end

end

local function Start(self)
     
end

local function Update(self)
    print("TileGrid   Update")
end

----找空格子
local function GetRandomEmptyCell(self)
         local index = math.random(1,self.size)
        local startingIndex =index;
        while self.cells[index]:IsOccupied() do
            index = index+1;
            if  index > #self.cells then
                index = 1;
            end
            if  index==startingIndex  then
                return nil;
            end
        end
        return self.cells[index];
end

function TileGrid:GetCell(x,y)
        for i = 1, #self.cells do
            local cell = self.cells[i];
            if cell.coordinates.x == x and cell.coordinates.y == y then
                return cell;
            end
        end
        return nil;
end

local function GetAdjacentCell(self,cell,direction)
        
	local tmpX = cell.coordinates.x+direction.x;
	local tmpY = cell.coordinates.y+direction.y;
 
    return self:GetCell(tmpX,tmpY);

end

TileGrid.Start = Start;
TileGrid.GetRandomEmptyCell = GetRandomEmptyCell;
TileGrid.__init = __init;
 TileGrid.GetAdjacentCell = GetAdjacentCell;
 
return TileGrid