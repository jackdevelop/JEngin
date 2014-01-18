--[[
登陆场景
]]
local BaseScene = require("engin.mvcs.view.BaseScene")
local LoginScene = class("LoginScene", BaseScene)



function LoginScene:ctor(param)
	
	
	local function updateCheckBoxButtonLabel(login_btn)
		local serverUrlTxt = self.serverUrlTxt_:getText();
		if StringUtil:length(serverUrlTxt) > 0 then --输入了地址
			UrlConfig.ServerUrl = serverUrlTxt;
			login_btn:setButtonLabelString("开始登陆")
			
			local loginCallBack = function (result)
				local status = result['status'] --后台返回的数据成功与否的编码
				if status == 1 then 
					login_btn:setButtonLabelString("登陆成功！")
				end
			end
			
			HttpLoad:json("commandId",param,loginCallBack)
		end
    end

	
	
	
	
	
	local loginButtonParam = {
	    --off = "ui/CheckBoxButton2Off.png",
	    on = GameImageUIProperties.CheckBoxButton2Off,
	}
	cc.ui.UICheckBoxButton.new(loginButtonParam)
        :setButtonLabel(cc.ui.UILabel.new({text = "登陆", size = 16,  color = display.COLOR_BLUE}))
        --:setButtonLabelOffset(0, 40)
        --:setButtonEnabled(false)
        :setButtonLabelAlignment(display.CENTER)
        :onButtonStateChanged(function(event)
            updateCheckBoxButtonLabel(event.target)
        end)
        :align(display.CENTER,display.cx,display.cy)
        :addTo(self)
        
        
     local editBoxParams = {
      	image = "ui/SliderBarFixed.png",
  		imagePressed ="ui/SliderBarFixed.png",
  		imageDisabled ="ui/SliderBarFixed.png",
  		size  = CCSize(240, 40),
  		align = ui.TEXT_ALIGN_RIGHT,
        listener = function() end,
     }
     self.serverUrlTxt_ = ui.newEditBox(editBoxParams)
     	:align(display.CENTER,display.cx,display.cy+100)
     	:addTo(self);
     self.serverUrlTxt_:setText("http://hao123.com123")
    
end




function LoginScene:onTouch(event, x, y)
end


return LoginScene
