--
-- RemoveShopsByTime
--
-- @author  nilBrain
-- @date  	28/04/20


RemoveShopsByTime = {};
RemoveShopsByTime.blockedShops = {
	{g_gui.guis.ShopMenu, g_i18n:getText("map_shop")},
	{g_gui.guis.AnimalScreen, g_i18n:getText("animals_dealer")}
};

function RemoveShopsByTime:loadMap(mapFilename)
	self.isClient = g_client ~= nil;
end;

function RemoveShopsByTime:update(dt)
	if self.isClient then
		local hr = g_currentMission.environment.currentHour;
		if hr == 12 or (hr >= g_currentMission.environment.nightStart or hr < g_currentMission.environment.nightEnd) then
			for _, shop in pairs(RemoveShopsByTime.blockedShops) do
				if g_gui.currentGui == shop[1] then
					g_gui:showGui("");
					g_gui:showInfoDialog({visible = true, text = string.format(g_i18n:getText("shop_shopIsClosed"), shop[2]), dialogType = DialogElement.TYPE_INFO, isCloseAllowed = true});
					break;
				end;
			end;
		end;
	end;
end;

addModEventListener(RemoveShopsByTime);