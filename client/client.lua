QBCore = exports['qb-core']:GetCoreObject()

local peds = {}
local multilang = {}

RegisterNetEvent('driverschool:client:openmenu', function(data)
	local formations = Config.formations;
	local playerData = QBCore.Functions.GetPlayerData()


	for _,v in pairs(formations) do
		v.disabled = playerData.metadata["licences"][v.type]
	end

	SendNUIMessage({
		action = "open",
		formations = formations,
	})

	SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)
end)

local function payTest(test)
	local p = promise.new()
	QBCore.Functions.TriggerCallback('driverschool:server:payTest', function(result)
		p:resolve(result)
	end, test)
	return Citizen.Await(p)
end

local function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}
	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end
	for k, entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))
		if distance <= maxDistance then
			nearbyEntities[#nearbyEntities+1] = isPlayerEntities and k or entity
		end
	end
	return nearbyEntities
end

local function GetVehiclesInArea(coords, maxDistance)
	return EnumerateEntitiesWithinDistance(QBCore.Functions.GetVehicles(), false, coords, maxDistance)
end

local function IsSpawnPointClear(coords, maxDistance)
	return #GetVehiclesInArea(coords, maxDistance) == 0
end

RegisterNUICallback('payTest', function(data, cb)
	if (payTest(data.type)) then
		SendNUIMessage({ action = 'start', type = data.type })
		cb()
	else
		QBCore.Functions.Notify(Lang:t('error.you_dont_have_enough_money'), 'error')
	end
end)

RegisterNUICallback('startTest', function(data, cb)
	PlayerData = QBCore.Functions.GetPlayerData()

	if PlayerData.metadata['licences'].N then
		if IsSpawnPointClear(vector3(Config.Zones.VehicleSpawnPoint.Pos.x, Config.Zones.VehicleSpawnPoint.Pos.y, Config.Zones.VehicleSpawnPoint.Pos.z), 2.5) then
			if (payTest(data.type)) then
				SetNuiFocus(false)
				SendNUIMessage({ action = "close" })
				StartDriveTest(data.type)
			else
				QBCore.Functions.Notify(Lang:t('error.you_dont_have_enough_money'), 'error')
			end
		else
			QBCore.Functions.Notify(Lang:t('info.someone_is_at_the_starting_line_please_wait_a_moment'), 'error', 2000)
		end
	else
		QBCore.Functions.Notify(Lang:t('info.you_have_not_passed_the_theory_test'), 'error', 2000)
	end
end)

RegisterNUICallback('give', function(data, cb)
	TriggerServerEvent('driverschool:server:addLicense', 'N')
end)


RegisterNUICallback('close', function()
	CurrentTest = nil
	SetNuiFocus(false)
end)

local function NearPed(model, coords, heading, gender, animDict, animName, scenario)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Wait(1)
	end
	local genderNum = null
	if gender == 'male' then
		genderNum = 4
	elseif gender == 'female' then
		genderNum = 5
	end
	local ped = CreatePed(genderNum, GetHashKey(v.model), coords, heading, false, true)
	SetEntityAlpha(ped, 0, false)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end
	if scenario then
		TaskStartScenarioInPlace(ped, scenario, 0, true)
	end
	for i = 0, 255, 51 do
		Wait(50)
		SetEntityAlpha(ped, i, false)
	end
	return ped
end

CreateThread(function() -- Create Blips
    local blip = AddBlipForCoord(vector3(210.49, -1381.94, 29.58))
    SetBlipSprite(blip, 525)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 4)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
	if CustomFont ~= nil then
		AddTextComponentString('<font face=\'' .. CustomFont ..'\'>' .. Lang:t('info.driving_school') .. '</font>')
	else
		AddTextComponentString(Lang:t('info.driving_school'))
	end
    EndTextCommandSetBlipName(blip)
end)

CreateThread(function() --Spawn Ped
	while true do
		Wait(500)
		for k = 1, #Config.PedList, 1 do
			v = Config.PedList[k]
			local playerCoords = GetEntityCoords(PlayerPedId())
			local dist = #(playerCoords - v.coords)
			if dist < 50.0 and not peds[k] then
				local ped = NearPed(v.model, v.coords, v.heading, v.gender, v.animDict, v.animName, v.scenario)
				peds[k] = {ped = ped}
			end
			if dist >= 50.0 and peds[k] then
				for i = 255, 0, -51 do
					Wait(50)
					SetEntityAlpha(peds[k].ped, i, false)
				end
				DeletePed(peds[k].ped)
				peds[k] = nil
			end
		end
	end
end)

exports['qb-target']:AddTargetModel(`ig_paper`, {
    options = {
		{
            event = 'driverschool:client:openmenu',
            icon = 'fas fa-id-card',
            label = Lang:t('menu.open'),
        }
    },
    distance = 10.0
})
