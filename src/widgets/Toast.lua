--[[
    说明: 提示小浮层
    作者: 林国锋
    日期: 2014-12-23

    usage:
        qy.Widget.Toast.make("内容", 1, cc.p(480, 320)):show()
]]

local Toast = class("Toast", app.V)

Toast.style = {
    ["skin"] = app.config.Theme .. ".ToastSkin"
}

function Toast:ctor()
    Toast.super.ctor(self)

    self:addCSB(self.style.skin)

    self:InjectView("Img_frame")
    self:InjectView("Text_title")

    self:setOpacity(0)
end

function Toast:setDuration(duration)
    self.duration = duration
end

function Toast:setTitle(title)
    self.Text_title:setString(title)
    local size = self.Text_title:getContentSize()
    self.Img_frame:setContentSize(cc.size(size.width + 20, math.max(size.height + 20, 40)))
end

function Toast:show()
    local originpos = cc.p(self:getPosition())
    self:setOpacity(0)
    self:setPosition(originpos.x, originpos.y - 50)
    self:stopAllActions()
    self:runAction(cc.Sequence:create(
        cc.Spawn:create(
            cc.MoveTo:create(0.2, originpos),
            cc.FadeIn:create(0.16)
        ),
        cc.DelayTime:create(self.duration),
        cc.Spawn:create(
            cc.MoveTo:create(0.2, cc.p(originpos.x, originpos.y + 50)),
            cc.FadeOut:create(0.3)
        ),
        cc.CallFunc:create(function()
            self:removeFromParent()
        end)
    ))
end

-- title: 显示的内容
-- duration: 显示多长时间, 默认为1.5秒
-- position: 在屏幕的位置, 默认屏幕中心
function Toast.make(title, duration, position)
    local toast = Toast.new()
    toast:setTitle(title)
    toast:setDuration(duration or 1.5)
    toast:setPosition(position or cc.p(display.cx, display.height * 0.78))
    toast:show()

    display:getRunningScene():getToastContainer():addChild(toast)

end

return Toast
