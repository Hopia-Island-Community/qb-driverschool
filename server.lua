QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('driverschool:server:payTest', function(source, cb, type)
	local Player = QBCore.Functions.GetPlayer(source)
	local bankBalance = Player.Functions.GetMoney('bank')
	local cashBalance = Player.Functions.GetMoney('cash')
	local price = Config.Prices[type]

	if bankBalance >= price then
		Player.Functions.RemoveMoney('bank', price, 'Pay the driving school test fee')
	elseif cashBalance >= price then
		Player.Functions.RemoveMoney('cash', price, 'Pay the driving school test fee')
	else
		return cb(false)
	end

	return cb(true)
end)

RegisterNetEvent('driverschool:server:addLicense', function(type)
    local Player = QBCore.Functions.GetPlayer(source)
	local licences = Player.PlayerData.metadata['licences'] or {};

	licences[type] = true

    Player.Functions.SetMetaData('licences', licences)
end)
