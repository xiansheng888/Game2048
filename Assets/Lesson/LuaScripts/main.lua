local _, LuaDebuggee = pcall(require, 'LuaDebuggee')
if LuaDebuggee and LuaDebuggee.StartDebug then
	if LuaDebuggee.StartDebug('127.0.0.1', 9826) then
		print('LuaPerfect: Successfully connected to debugger!')
	else
		print('LuaPerfect: Failed to connect debugger!')
	end
else
	print('LuaPerfect: Check documents at: https://luaperfect.net')
end

require("head")
require("json")
require("BaseClass")
cs_coroutine = (require 'cs_coroutine')

 GameManager = require("GameLogic.GameManager")
 TileBoard   = require("GameLogic.TileBoard")
 TileGrid    = require("GameLogic.TileGrid")
 Tile        = require("GameLogic.Tile")
 TileCell    = require("GameLogic.TileCell")

Tool =  FindComponent.ADD(GameObject.Find("Canvas"))

Vector2Int = {
				up ={x=0,y=-1},
				down={x=0,y=1},
				left ={x=-1,y=0},
				right = {x=1,y=0}
			};

function table.RemoveItem(list,item)
	for index, value in ipairs(list) do
		if value == item then
			table.remove(list,index);
			return;
		end
	end
end

local function  Awake()
 
	GameManager();   

 
end

local function  OnEnable()
   
end
local function Start()
 
end


--local function Update()
  
--end

local function OnDestroy()
     
end

Main= {};
Main.Awake = Awake;
Main.OnEnable = OnEnable;
Main.Start = Start;
Main.Update = Update;
Main.OnDestroy = OnDestroy;


---用于绑定lua函数到c#的事件上，
function Bind(func,self)
    assert(type(func)=="function","func参数必须为函数")
	local function tmp(...)
		func(self,...);
	end
    return tmp;
end


setmetatable(_G,{__newindex=function(t,k,v)
     error("不能声明全局变量"..k)
end})

 




