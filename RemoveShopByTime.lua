--
-- RemoveShopByTime
--
-- @author  nilBrain
-- @date  	26/04/20


RemoveShopByTime={}

function RemoveShopByTime:update(dt)
	local hr = g_currentMission.environment.currentHour;
	if hr == 12 or (hr >= g_currentMission.environment.nightStart or hr < g_currentMission.environment.nightEnd) then
		if g_gui.currentGui == g_gui.guis.ShopMenu then
			g_gui:showGui("");
			g_gui:showInfoDialog({visible = true, text = g_i18n:getText("shop_shopIsClosed"), dialogType = DialogElement.TYPE_INFO, isCloseAllowed = true});
		end;
	end;
end;

addModEventListener(RemoveShopByTime);