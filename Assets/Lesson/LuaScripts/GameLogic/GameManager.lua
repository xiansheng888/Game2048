local GameManager = BaseClass("GameManager")

local function __init(self)
     self.score = 0;

     Tool:ADDFUNC(CS.FUNC.Start,Bind(self.Start,self));
     Tool:ADDFUNC(CS.FUNC.OnEnable,Bind(self.OnEnable,self));
     Tool:ADDFUNC(CS.FUNC.OnDisable,Bind(self.OnDisable,self));

     self.scoreText =Tool:GetComponentByName("scoreValue",typeof(TextMeshProUGUI))
     self.gameOver = Tool:GetComponentByName("GameOver",typeof(CanvasGroup))
     self.restartBtn = self.gameOver.transform:Find("restartBtn"):GetComponent(typeof(Button));
    self.restartBtn.onClick:AddListener(function()   self:NewGame();   end)
     self.hiscoreText = Tool:GetComponentByName("BestValue",typeof(TextMeshProUGUI))
     self.board=TileBoard.New();
end

local function Start(self)
     self:NewGame(); 
end
local function OnEnable(self)
    
     self.restartBtn.onClick:AddListener(function() 
        self:NewGame();
     end)
end

local function OnDisable(self)
       self.restartBtn.onClick:RemoveAllListeners();
end

---私有加载分数方法
local function LoadHiscore(self)
    return PlayerPrefs.GetInt("hiscore", 0);
end
local function SaveHiscore(self)
        local  hiscore = LoadHiscore();
        if self.score > hiscore then
            PlayerPrefs.SetInt("hiscore", self.score);
        end
end

local function SetScore(self,score)
    self.score = score;
    self.scoreText.text = self.score;
    SaveHiscore(self);
end

local function LoadHiscore(self)
    return PlayerPrefs.GetInt("hiscore", 0);
end

local function NewGame(self)
    SetScore(self,0)
    self.hiscoreText.text  = LoadHiscore();
    self.gameOver.alpha = 0;
    self.gameOver.interactable = false;

    self.board:ClearBoard();
    self.board:CreateTile();
    self.board:CreateTile();
    self.board:SetEnable(true)
end


local function Update(self)
    print("GameManager   Update")
end

function GameManager:GameOver()
    self.board:SetEnable(false)
    self.gameOver.interactable = true;

     cs_coroutine.start(function()
            coroutine.yield(WaitForSeconds(1))
            local elapsed = 0;
            local duration = 0.5;
            local from = self.gameOver.alpha;  

            while elapsed < duration do
                self.gameOver.alpha = Mathf.Lerp(from, 1, elapsed / duration);
                elapsed = elapsed+ Time.deltaTime;
                coroutine.yield(nil)  ---等下一帧
                end
            self.gameOver.alpha = 1;
    end)

end
 
local function IncreaseScore(self,point)
    SetScore(self, self.score + point);
end

GameManager.Start = Start;
GameManager.Update = Update;
GameManager.NewGame = NewGame;
GameManager.__init = __init;
GameManager.IncreaseScore=IncreaseScore;

GameManager.OnEnable=OnEnable;
GameManager.OnDisable=OnDisable;

local _instance = nil;
return function ()
    if not _instance then
        _instance = GameManager.New();
    end
    return _instance;
end