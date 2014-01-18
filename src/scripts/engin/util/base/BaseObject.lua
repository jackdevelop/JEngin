--[[
 	BaseObject
 	public ->> 全局公开类
 	
	对象的基础类
 
 
 * @author  改自 dualface
 * $Id:$
 * @version 1.0
]]
local BaseObject = class("BaseObject")


function BaseObject:ctor(id, state, map)
    assert(type(state) == "table", "BaseObject:ctor() - invalid state")

    for k, v in pairs(state) do
        local kn = k .. "_"
        self[kn] = v
    end

    local classId, index = unpack(string.split(id, ":"))
    self.map_        = map
    self.id_         = id
    self.classId_    = classId
    self.classIndex_ = BaseObject.CLASS_INDEX[classId]
    self.index_      = toint(index)
    self.x_          = toint(self.x_)
    self.y_          = toint(self.y_)
    self.offsetX_    = toint(self.offsetX_)
    self.offsetY_    = toint(self.offsetY_)
    self.state_      = state
    self.valid_      = false
    self.play_       = false
    self.tag_        = 0
    self.sprite_     = nil
    
    if type(self.viewZOrdered_) ~= "boolean" then
        self.viewZOrdered_ = true
    end
end

--function BaseObject:init()
--    if not self.behaviors_ then return end
--
--    local behaviors
--    if type(self.behaviors_) == "string" then
--        behaviors = string.split(self.behaviors_, ",")
--    else
--        behaviors = self.behaviors_
--    end
--
--    for i, behaviorName in ipairs(behaviors) do
--        behaviorName = string.trim(behaviorName)
--        if behaviorName ~= "" then self:bindBehavior(behaviorName) end
--    end
--end

function BaseObject:getId()
    return self.id_
end

function BaseObject:getClassId()
    return self.classId_
end

function BaseObject:getIndex()
    return self.index_
end

function BaseObject:validate()
end

function BaseObject:isValid()
    return self.valid_
end

function BaseObject:getTag()
    return self.tag_
end

function BaseObject:setTag(tag)
    self.tag_ = tag
end

function BaseObject:getPosition()
    return self.x_, self.y_
end

function BaseObject:setPosition(x, y)
    self.x_, self.y_ = x, y
end

function BaseObject:isViewCreated()
    return self.sprite_ ~= nil
end

function BaseObject:isViewZOrdered()
    return self.viewZOrdered_
end

function BaseObject:getView()
    return nil
end

function BaseObject:createView(batch, marksLayer, debugLayer)
    assert(self.batch_ == nil, "BaseObject:createView() - view already created")
    self.batch_      = batch
    self.marksLayer_ = marksLayer
    self.debugLayer_ = debugLayer
end

function BaseObject:removeView()
    assert(self.batch_ ~= nil, "BaseObject:removeView() - view not exists")
    self.batch_      = nil
    self.marksLayer_ = nil
    self.debugLayer_ = nil
end

function BaseObject:updateView()
end

function BaseObject:preparePlay()
end

function BaseObject:startPlay()
    self.play_ = true
end

function BaseObject:stopPlay()
    self.play_ = false
end

function BaseObject:isPlay()
    return self.play_
end


return BaseObject
