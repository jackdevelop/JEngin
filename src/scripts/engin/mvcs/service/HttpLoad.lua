--[[
 	HttpLoad
 	public ->> 全局公开类
 	
	http的连接类
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local HttpLoad = class("HttpLoad")



function HttpLoad:ctor()
    self.requestCount = 0
end


function HttpLoad:json(commandId,param,callBack)
    self.requestCount = self.requestCount + 1
    local index = self.requestCount
    local request = network.createHTTPRequest(function(event)
        self:onResponse(callBack,event, index, true)
        
--        local request = event.request;
--        local cookieStr = request:getCookieString();
--        if cookieStr then
--	        local cookie = network.parseCookie(cookieStr)
--	        dump(cookie, "GET COOKIE FROM SERVER")
--        end
    end, UrlConfig.ServerUrl, "POST")
	 request:addPOSTValue("commandId", commandId);
    request:addPOSTValue("data", param);
  	--request:setTimeout(0.01);
    request:setCookieString(network.makeCookieString({C1 = "V1", C2 = "V2"}))
    printf("REQUEST START %d", index)
    request:start()
end




function HttpLoad:onResponse(callBack,event, index, dumpResponse)
    local request = event.request
    printf("REQUEST %d - event.name = %s", index, event.name)
    if event.name == "completed" then
    
    	local statusCode = request:getResponseStatusCode();
    	local result = request:getResponseHeadersString();
        printf("REQUEST %d - getResponseStatusCode() = %d", index, request:getResponseStatusCode())
        printf("REQUEST %d - getResponseHeadersString() =\n%s", index, request:getResponseHeadersString())

        if statusCode == 200 then
        	printf("REQUEST %d - getResponseDataLength() = %d", index, request:getResponseDataLength())
            if dumpResponse then
                printf("REQUEST %d - getResponseString() =\n%s", index, request:getResponseString())
            end
            HttpLoadResultHandle:succesHandle(callBack,result)
        else
        	HttpLoadResultHandle:errorHandle(callBack,statusCode)
        end
    else
        printf("REQUEST %d - getErrorCode() = %d, getErrorMessage() = %s", index, request:getErrorCode(), request:getErrorMessage())
    end
end












return HttpLoad
