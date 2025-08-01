local TileBoard = BaseClass("TileBoard")

local stateNameArr = {2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072};
local function __init(self)
 
   self.tilePrefab = Resources.Load("Prefabs/Tile");
   self.grid = TileGrid.New();

----配置表读取
   self.tileStates = {};
  for _,value in ipairs(stateNameArr) do
    local tmp = Resources.Load("Tiles/"..value);
    table.insert(self.tileStates,tmp);
  end
  --启用和未启用
   self.enable = false;

   ---装带数字的可以移动的tile
   self.tiles = {};

   Tool:ADDFUNC(CS.FUNC.Update,Bind(self.Update,self));

   self.waiting =false;
end

local function Start(self)
     print("TileBoard---------------------")
end

 
function TileBoard:ClearBoard()
      print("ClearBoard....")
      for _, cell in ipairs(self.grid.cells) do
         cell.tile = nil;
      end

      for _, tile in ipairs(self.tiles) do
         tile.cell = nil;
         Destroy(tile.gameobject);
      end
      self.tiles = {};
end

---创建数字
function TileBoard:CreateTile()
      local tileGo =GameObject.Instantiate(self.tilePrefab,self.grid.transform);
      local tile = Tile.New(tileGo);
      tile:SetState(self.tileStates[1])
      tile:Spawn(self.grid:GetRandomEmptyCell());
      table.insert(self.tiles,tile)
end

 function TileBoard:SetEnable(boo)
   self.enable = boo;
 end

----
 local function WaitForChanges(self)
   self.waiting = true;
   coroutine.yield(WaitForSeconds(0.1));
   self.waiting = false;

   for _, tile in ipairs(self.tiles) do
      tile.locked = false;
   end
   if #self.tiles < self.grid.size then
	     self:CreateTile();
   end
	
   if  self:CheckForGameOver() then
	     GameManager():GameOver();
   end
 end

local function Move(self,direction,startX,incrementX,startY,incrementY)
        local changed = false;
        local x = startX;
        local y = startY;

        while x >= 0 and x <= self.grid.width do
            x = x + incrementX;
		    y = startY;
            while y>=0 and y<=self.grid.height do
               y = y + incrementY;
               local cell = self.grid:GetCell(x,y);
               if cell~=nil and cell:IsOccupied() then
                  if self:moveTile(cell.tile,direction) then
                     changed = true;
                  end
               end
            end
        end
 
        if changed then
               cs_coroutine.start(function()
                  WaitForChanges(self);
               end)
        end
end

local function moveTile(self,tile,direction)
        
      local newCell =nil;
      local adjacent = self.grid:GetAdjacentCell(tile.cell, direction);
      while adjacent~=nil do
          if adjacent:IsOccupied() then 
                if self:CanMerge(tile, adjacent.tile) then
                    self:MergeTiles(tile, adjacent.tile);
                    return true;
                end  
                break;
          end
          newCell = adjacent;
          adjacent = self.grid:GetAdjacentCell(adjacent,direction)
      end

      if newCell~=nil then
         tile:MoveTo(newCell);
         return true;
      end
      return false;
end

local function Update(self)

      if self.waiting then  
          return  
      end

      if Input.GetKeyDown(KeyCode.W) or Input.GetKeyDown(KeyCode.UpArrow) then
         Move(self,Vector2Int.up,0,1,1,1);
      elseif Input.GetKeyDown(KeyCode.A) or Input.GetKeyDown(KeyCode.LeftArrow) then
         Move(self,Vector2Int.left,1,1,0,1);
      elseif(Input.GetKeyDown(KeyCode.S) or Input.GetKeyDown(KeyCode.DownArrow)) then
          Move(self,Vector2Int.down,0,1,self.grid.height,-1);
      elseif(Input.GetKeyDown(KeyCode.D) or Input.GetKeyDown(KeyCode.RightArrow)) then
        Move(self,Vector2Int.right,self.grid.width,-1,0,1);
      end
       
end

local function CanMerge(self ,a,b)
   return a.state == b.state and not b.locked;
end

local function MergeTiles(self ,a,b)
 
        table.RemoveItem(self.tiles,a);
        a:Merge(b.cell);

        local index = Mathf.Clamp(self:IndexOf(b.state)+1,1,#self.tileStates)
        local newState = self.tileStates[index]
        b:SetState(newState)
        GameManager():IncreaseScore(newState.number)
end

local function IndexOf(self,state)
   for index, value in ipairs(self.tileStates) do
      if value==state then
         return index;
      end
   end
   return -1;
end
 
local function CheckForGameOver(self)
    --   foreach (var tile in tiles)
   --   {
   --       TileCell up = grid.GetAdjacentCell(tile.cell, Vector2Int.up);
   --       TileCell down = grid.GetAdjacentCell(tile.cell, Vector2Int.down);
   --       TileCell left = grid.GetAdjacentCell(tile.cell, Vector2Int.left);
   --       TileCell right = grid.GetAdjacentCell(tile.cell, Vector2Int.right);

   --       if (up != null && CanMerge(tile, up.tile)) {
   --           return false;
   --       }

   --       if (down != null && CanMerge(tile, down.tile)) {
   --           return false;
   --       }

   --       if (left != null && CanMerge(tile, left.tile)) {
   --           return false;
   --       }

   --       if (right != null && CanMerge(tile, right.tile)) {
   --           return false;
   --       }
   --   }

   --   return true;
      if #self.tiles~=self.grid.size then
         return false;
      end

      for _, tile in ipairs(self.tiles) do
          local up = self.grid:GetAdjacentCell(tile.cell, Vector2Int.up);
          local down = self.grid:GetAdjacentCell(tile.cell, Vector2Int.down);
          local left = self.grid:GetAdjacentCell(tile.cell, Vector2Int.left);
          local right = self.grid:GetAdjacentCell(tile.cell, Vector2Int.right);

          if  up~=nil and self:CanMerge(tile,up.tile) then
            return false;
          end

          if  down~=nil and self:CanMerge(tile,down.tile) then
            return false;
          end

          if  left~=nil and self:CanMerge(tile,left.tile) then
            return false;
          end

          if  right~=nil and self:CanMerge(tile,right.tile) then
            return false;
          end
      end
      
      return true;
end

TileBoard.IndexOf = IndexOf;
TileBoard.Start = Start;
TileBoard.__init = __init;
TileBoard.Update = Update;
TileBoard.moveTile = moveTile;
TileBoard.CanMerge = CanMerge;
TileBoard.MergeTiles =MergeTiles;
TileBoard.CheckForGameOver = CheckForGameOver;
return TileBoard