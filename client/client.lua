QBCore = exports['qb-core']:GetCoreObject()

local peds = {}
local multilang = {}

local function StartTheoryTest()
	CurrentTest = 'theory'
	SendNUIMessage({
		openQuestion = true,
		multilang = {
			question = Lang:t('info.question'),
			mtheader = Lang:t('info.driving_school'),
			mlcontent = Lang:t('info.mlcontent'),
			mlbt = Lang:t('info.mlbt'),
			mlprogression = Lang:t('info.mlprogression'),
			mlresultgood = Lang:t('info.mlresultgood'),
			mlresultbad = Lang:t('info.mlresultbad'),
			submit = Lang:t('info.mlsubmit'),
			mlclose = Lang:t('info.mlclose'),
			questionlist = {
				{
					question = Lang:t('info.questionlist1q'),
					propositionA = Lang:t('info.questionlist1a'),
					propositionB = Lang:t('info.questionlist1b'),
					propositionC = Lang:t('info.questionlist1c'),
					propositionD = Lang:t('info.questionlist1d'),
					reponse = Lang:t('info.questionlist1r'),
				},
				{
					question = Lang:t('info.questionlist2q'),
					propositionA = Lang:t('info.questionlist2a'),
					propositionB = Lang:t('info.questionlist2b'),
					propositionC = Lang:t('info.questionlist2c'),
					propositionD = Lang:t('info.questionlist2d'),
					reponse = Lang:t('info.questionlist2r'),
				},
				{
					question = Lang:t('info.questionlist3q'),
					propositionA = Lang:t('info.questionlist3a'),
					propositionB = Lang:t('info.questionlist3b'),
					propositionC = Lang:t('info.questionlist3c'),
					propositionD = Lang:t('info.questionlist3d'),
					reponse = Lang:t('info.questionlist3r'),
				},
				{
					question = Lang:t('info.questionlist4q'),
					propositionA = Lang:t('info.questionlist4a'),
					propositionB = Lang:t('info.questionlist4b'),
					propositionC = Lang:t('info.questionlist4c'),
					propositionD = Lang:t('info.questionlist4d'),
					reponse = Lang:t('info.questionlist4r'),
				},
				{
					question = Lang:t('info.questionlist5q'),
					propositionA = Lang:t('info.questionlist5a'),
					propositionB = Lang:t('info.questionlist5b'),
					propositionC = Lang:t('info.questionlist5c'),
					propositionD = Lang:t('info.questionlist5d'),
					reponse = Lang:t('info.questionlist5r'),
				},
				{
					question = Lang:t('info.questionlist6q'),
					propositionA = Lang:t('info.questionlist6a'),
					propositionB = Lang:t('info.questionlist6b'),
					propositionC = Lang:t('info.questionlist6c'),
					propositionD = Lang:t('info.questionlist6d'),
					reponse = Lang:t('info.questionlist6r'),
				},
				{
					question = Lang:t('info.questionlist7q'),
					propositionA = Lang:t('info.questionlist7a'),
					propositionB = Lang:t('info.questionlist7b'),
					propositionC = Lang:t('info.questionlist7c'),
					propositionD = Lang:t('info.questionlist7d'),
					reponse = Lang:t('info.questionlist7r'),
				},
				{
					question = Lang:t('info.questionlist8q'),
					propositionA = Lang:t('info.questionlist8a'),
					propositionB = Lang:t('info.questionlist8b'),
					propositionC = Lang:t('info.questionlist8c'),
					propositionD = Lang:t('info.questionlist8d'),
					reponse = Lang:t('info.questionlist8r'),
				},
				{
					question = Lang:t('info.questionlist9q'),
					propositionA = Lang:t('info.questionlist9a'),
					propositionB = Lang:t('info.questionlist9b'),
					propositionC = Lang:t('info.questionlist9c'),
					propositionD = Lang:t('info.questionlist9d'),
					reponse = Lang:t('info.questionlist9r'),
				},
				{
					question = Lang:t('info.questionlist10q'),
					propositionA = Lang:t('info.questionlist10a'),
					propositionB = Lang:t('info.questionlist10b'),
					propositionC = Lang:t('info.questionlist10c'),
					propositionD = Lang:t('info.questionlist10d'),
					reponse = Lang:t('info.questionlist10r'),
				},
			}
		}
	})
	SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)
end

local function payTest(test)
	local p = promise.new()
	QBCore.Functions.TriggerCallback('driverschool:server:payTest', function(result)
		p:resolve(result)
	end, test)
	return Citizen.Await(p)
end

local function StopTheoryTest(success)
	CurrentTest = nil
	SendNUIMessage({
		openQuestion = false,
		multilang = {}
	})
	SetNuiFocus(false)
	if success then
		TriggerServerEvent('driverschool:server:addLicense', 'N')
		QBCore.Functions.Notify(Lang:t('info.you_have_passed_the_driving_theory_test_congratulations'), 'success', 2000)
	else
		QBCore.Functions.Notify(Lang:t('info.you_have_failed_the_driving_theory_test_prepare_well_for_next_time'), 'error', 2000)
	end
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

RegisterNUICallback('question', function(data, cb)
	if (payTest("N")) then
		SendNUIMessage({ openSection = 'question' })
		cb()
	else
		QBCore.Functions.Notify(Lang:t('error.you_dont_have_enough_money'), 'error')
	end
end)

RegisterNUICallback('end', function(data, cb)
	StopTheoryTest(true)
	cb()
end)

RegisterNUICallback('close', function()
	CurrentTest = nil
	SendNUIMessage({ openQuestion = false, multilang = {} })
	SetNuiFocus(false)
end)

RegisterNUICallback('kick', function(data, cb)
	StopTheoryTest(false)
	cb()
end)

RegisterNetEvent('driverschool:client:startTheoryTest', function()
    CurrentTest = 'theory'
	SendNUIMessage({ openQuestion = true })
	SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)
end)

RegisterNetEvent('driverschool:client:startTest', function(type)
	if type ~= 'N' then
		if (payTest(type)) then
			StartDriveTest(type)
		else
			QBCore.Functions.Notify(Lang:t('error.you_dont_have_enough_money'), 'error')
		end
	else
		StartTheoryTest()

	end
end)



RegisterNetEvent('driverschool:client:payTest', function(data)
	PlayerData = QBCore.Functions.GetPlayerData()
	if data.type ~= 'N' then
		if PlayerData.metadata['licences'].N then
			if IsSpawnPointClear(vector3(Config.Zones.VehicleSpawnPoint.Pos.x, Config.Zones.VehicleSpawnPoint.Pos.y, Config.Zones.VehicleSpawnPoint.Pos.z), 2.5) then
				TriggerEvent('driverschool:client:startTest', data.type)
			else
				QBCore.Functions.Notify(Lang:t('info.someone_is_at_the_starting_line_please_wait_a_moment'), 'error', 2000)
			end
		else
			QBCore.Functions.Notify(Lang:t('info.you_have_not_passed_the_theory_test'), 'error', 2000)
		end
	else
		if PlayerData.metadata['licences'].N then
			QBCore.Functions.Notify(Lang:t('info.have_you_passed_the_theory_test'), 'error', 2000)
		else
			TriggerEvent('driverschool:client:startTest', data.type)
		end
	end
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
            event = 'driverschool:client:payTest',
            icon = 'fas fa-id-card',
            label = Lang:t('menu.driving_theory_test', {price = Config.Prices.N}),
			type = 'N',
			canInteract = function()
				PlayerData = QBCore.Functions.GetPlayerData()
				if PlayerData.metadata['licences'].N then
					return false
				else
					return true
				end
			end
        },
		{
            event = 'driverschool:client:payTest',
            icon = 'fas fa-motorcycle',
            label = Lang:t('menu.a_class_driving_practice_test', {price = Config.Prices.A}),
			plant = peds[2],
			type = 'A',
			canInteract = function()
				PlayerData = QBCore.Functions.GetPlayerData()
				if PlayerData.metadata['licences'].N then
					if PlayerData.metadata['licences'].A then
						return false
					else
						return true
					end
				else
					return false
				end
			end
        },
		{
            event = 'driverschool:client:payTest',
            icon = 'fas fa-car',
            label = Lang:t('menu.b_class_driving_practice_test', {price = Config.Prices.B}),
			type = 'B',
			canInteract = function()
				PlayerData = QBCore.Functions.GetPlayerData()
				if PlayerData.metadata['licences'].N then
					if PlayerData.metadata['licences'].B then
						return false
					else
						return true
					end
				else
					return false
				end
			end
        },
		{
			event = 'driverschool:client:payTest',
            icon = 'fas fa-truck',
            label = Lang:t('menu.c_class_driving_practice_test', {price = Config.Prices.C}),
			type = 'C',
			canInteract = function()
				PlayerData = QBCore.Functions.GetPlayerData()
				if PlayerData.metadata['licences'].N then
					if PlayerData.metadata['licences'].C then
						return false
					else
						return true
					end
				else
					return false
				end
			end
        },
		{
            event = 'driverschool:client:payTest',
            icon = 'fas fa-bus',
            label = Lang:t('menu.d_class_driving_practice_test', {price = Config.Prices.D}),
			type = 'D',
			canInteract = function()
				PlayerData = QBCore.Functions.GetPlayerData()
				if PlayerData.metadata['licences'].N then
					if PlayerData.metadata['licences'].D then
						return false
					else
						return true
					end
				else
					return false
				end
			end
        }
    },
    distance = 10.0
})
