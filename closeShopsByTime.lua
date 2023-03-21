--
-- closeShopsByTime
--
-- @author  nilBrain
-- @date  	24/06/2022


closeShopsByTime = {};
closeShopsByTime.blockedShops = {
	{g_gui.guis.ShopMenu, g_i18n:getText("map_shop")},
	{g_gui.guis.AnimalDialog, g_i18n:getText("animals_dealer")}
};

function closeShopsByTime:loadMap(mapFilename)
	if g_currentMission:getIsClient() then
		g_messageCenter:subscribe(MessageType.GUI_AFTER_OPEN, self.onGuiOpen, self);
	end;
end;

function closeShopsByTime:deleteMap()
	if g_currentMission:getIsClient() then
		g_messageCenter:unsubscribe(MessageType.GUI_AFTER_OPEN, self);
	end;
end;

function closeShopsByTime:onGuiOpen()
	local hr = g_currentMission.environment.currentHour;
	if hr == 12 or (hr >= g_currentMission.environment.lighting.nightStart or hr < g_currentMission.environment.lighting.nightEnd) then
		for _, shop in pairs(closeShopsByTime.blockedShops) do
			if g_gui.currentGui == shop[1] then
				self.closeGuiOrDialog(false, shop);
				break;
			end;
			if g_gui.currentListener == shop[1] then
				self.closeGuiOrDialog(true, shop);
			end;
		end;
	end;
end;

function closeShopsByTime.closeGuiOrDialog(isDialog, shop)
	if isDialog then
		g_gui:closeDialog(g_gui.currentListener);
	else
		g_gui:showGui("");
	end;			
	g_gui:showInfoDialog({visible = true, text = string.format(g_i18n:getText("shop_shopIsClosed"), shop[2]), dialogType = DialogElement.TYPE_INFO, isCloseAllowed = true});
end;

addModEventListener(closeShopsByTime);