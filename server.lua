QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('driverschool:server:payTest', function(source, cb, type)
	local Player = QBCore.Functions.GetPlayer(source)
	local bankBalance = Player.Functions.GetMoney('bank')
	local cashBalance = Player.Functions.GetMoney('cash')
	local formation = GetFormationByType(type)
	local price = formation.price

	if bankBalance >= price then
		Player.Functions.RemoveMoney('bank', price, 'Pay the driving school test fee')
		TriggerEvent('okokBanking:AddTransferTransactionToSociety', price, source, "Auto-école", "Payement formation " .. formation.title)
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

local label =[[
  ||
  ||    ____    ____        ____  ____  _____    ____________  _____ ________  ______  ____  __
  ||   / __ \  / __ )      / __ \/ __ \/  _/ |  / / ____/ __ \/ ___// ____/ / / / __ \/ __ \/ /
  ||  / / / / / __  |_____/ / / / /_/ // / | | / / __/ / /_/ /\__ \/ /   / /_/ / / / / / / / /
  || / /_/ / / /_/ /_____/ /_/ / _, _// /  | |/ / /___/ _, _/___/ / /___/ __  / /_/ / /_/ / /___
  || \___\_\/_____/     /_____/_/ |_/___/  |___/_____/_/ |_|/____/\____/_/ /_/\____/\____/_____/
  ||
  ||                                    Created by Devix
  ||
]]

-- Grabs the latest version number from the web GitHub
PerformHttpRequest( "https://skrilax91.github.io/qb-driverschool", function( err, body, headers )
	-- Wait to reduce spam
	Citizen.Wait( 2000 )

	-- Get the current resource version
	local curVer = GetResourceMetadata( GetCurrentResourceName(), "version" )
	local latest = body

	label = label .. "  ||    Current version: " .. curVer

	if ( latest ~= nil ) then
		-- Print latest version

		label = label .. "\n  ||    Latest recommended version: " .. latest

		-- If the versions are different, print it out
		if ( latest ~= curVer ) then
			label = label .. "\n  ||    ^1Your qb-driverschool version is outdated, please update as soon as possible.^0"
		else
			label = label .. "\n  ||    ^2Qb-driverschool is up to date!^0\n"
		end
	else
		label = label .. "\n  ||    ^1There was an error getting the latest version information.^0\n"
	end

	print(label)

	-- Warn the console if the resource has been renamed, as this will cause issues with the resource's functionality.
	if ( GetCurrentResourceName() ~= "qb-driverschool" ) then
		print( "^1ERROR: Resource name is not qb-driverschool, expect there to be issues with the resource. To ensure there are no issues, please leave the resource name as qb-driverschool^0\n\n" )
	end
end )