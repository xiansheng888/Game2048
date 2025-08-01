local Tile = BaseClass("Tile")


local function __init(self,go)
  print("Tile __init")
  self.gameobject = go;
  self.transform = go.transform;
  local findCom = FindComponent.ADD(self.gameobject)
   self.background = findCom:GetComponent(typeof(Image))
   self.text = findCom:GetComponentByName("Text",typeof(TextMeshProUGUI))
end

local function Start(self)
     
end

local function Merge(self,cell)

      if self.cell~=nil then
         self.cell.tile = nil;   
      end
      self.cell  = nil;
      cell.tile.locked = true;

      cs_coroutine.start(function()
  
            local elapsed = 0;
            local duration = 0.1;
            local from = self.gameobject.transform.position;
            local to  = cell.gameobject.transform.position;
            while elapsed < duration do
               self.gameobject.transform.position = Vector3.Lerp(from,to,elapsed/duration)
               elapsed = elapsed+Time.deltaTime;
               coroutine.yield(nil)  ---等下一帧   
            end
            self.gameobject.transform.position = to ;
            GameObject.Destroy(self.gameobject)

      end)
end

 local function SetState(self,state)

        self.state = state;
        self.background.color = state.backgroundColor;
        self.text.color = state.textColor;
        self.text.text = state.number;

 end

 

 local function Spawn(self,cell)
       --  print("spawn",cell.gameobject.name,cell.coordinates.x,cell.coordinates.y);
        if self.cell~=nil then
           self.cell.tile = nil;
        end
        self.cell = cell;
        self.cell:SetTile(self)
        self.gameobject.transform.position = self.cell.gameobject.transform.position;
 end

local function Update(self)
    print("Tile   Update")
end

local function MoveTo(self,cell)
 
      if self.cell~=nil then
         self.cell.tile = nil;
      end
      self.cell = cell;
      self.cell.tile = self;
      cs_coroutine.start(function()
         self:Animate(self.cell.transform.position,false)       
      end)

end

local function Animate(self,to,merging)
         --    coroutine.yield(WaitForSeconds(1))
         -- coroutine.yield(nil)  ---等下一帧  
      local elapsed = 0;
      local duration = 0.1;
      local from = self.transform.position;
      while elapsed<duration do
         self.transform.position = Vector3.Lerp(from,to,elapsed/duration);
         elapsed = elapsed + Time.deltaTime;
         coroutine.yield(nil)  ---等下一帧   
      end
      self.transform.position = to;
      if merging then
         GameObject.Destroy(self.gameobject)
      end
end

Tile.Start = Start;
Tile.__init = __init;
Tile.SetState = SetState;
Tile.Spawn = Spawn;
Tile.Merge = Merge;
Tile.MoveTo = MoveTo;
 Tile.Animate=Animate;
return Tile