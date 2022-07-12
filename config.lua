QBCore = exports['qb-core']:GetCoreObject()

CustomFont = nil --[nil]: use system default font - or ['name of your custom font']: You need your_custum_font.gfx EX: CustomFont = 'Oswald'

Config = {}
Config.scoretopass = 80
Config.SpeedMultiplier = 3.6
Config.seatbelt = false


--[[
 /$$$$$$$$                                            /$$     /$$
| $$_____/                                           | $$    |__/
| $$     /$$$$$$   /$$$$$$  /$$$$$$/$$$$   /$$$$$$  /$$$$$$   /$$  /$$$$$$  /$$$$$$$   /$$$$$$$
| $$$$$ /$$__  $$ /$$__  $$| $$_  $$_  $$ |____  $$|_  $$_/  | $$ /$$__  $$| $$__  $$ /$$_____/
| $$__/| $$  \ $$| $$  \__/| $$ \ $$ \ $$  /$$$$$$$  | $$    | $$| $$  \ $$| $$  \ $$|  $$$$$$
| $$   | $$  | $$| $$      | $$ | $$ | $$ /$$__  $$  | $$ /$$| $$| $$  | $$| $$  | $$ \____  $$
| $$   |  $$$$$$/| $$      | $$ | $$ | $$|  $$$$$$$  |  $$$$/| $$|  $$$$$$/| $$  | $$ /$$$$$$$/
|__/    \______/ |__/      |__/ |__/ |__/ \_______/   \___/  |__/ \______/ |__/  |__/|_______/
--]]

Config.formations = {
	{
		title = "Examen théorique",
		description = "Commencez votre aventure en vérifiant vos connaissance générales",
		image = "resources/formations/code.png",
		type = "N",
		price = 500
	},
	{
		title = "Passage permis A",
		description = "Obligatoire pour la conduite de véhicule deux roues",
		image = "resources/formations/sanchez.jpg",
		type = "A",
		vehicles = {'sanchez'},
		price = 1500
	},
	{
		title = "Passage permis B",
		description = "Le permis B permet de conduire une voiture ou une camionnette. Il permet aussi de conduire, sous conditions, un camping-car, une moto légère (scooter, moto 125) ou un tracteur",
		image = "resources/formations/blista.jpg",
		type = "B",
		vehicles = {'blista'},
		price = 2000
	},
	{
		title = "Passage permis C",
		description = "La catégorie C du permis de conduire autorise la conduite des véhicules affectés au transport de marchandises ou de matériel",
		image = "resources/formations/phantom.jpg",
		type = "C",
		vehicles = {'phantom3'},
		price = 4000
	},
	{
		title = "Passage permis D",
		description = "Le permis D autorise la conduite d'un véhicule affecté au transport de personnes comportant plus de 9 places assises (conducteur compris)",
		image = "resources/formations/bus.jpg",
		type = "D",
		vehicles = {'bus'},
		price = 6000
	}
}

Config.SpeedLimits = {
	residence = 80,
	town      = 80,
	freeway   = 130
}

Config.Zones = {
	VehicleSpawnPoint = {
		Pos   = vector4(249.409, -1407.230, 30.4094, 317.0),
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = -1
	}
}

Config.CheckPoints = {
	{
		Pos = vector3(249.409, -1407.230, 29.537),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			CreateThread(function()
				local class = GetVehicleClass(vehicle)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
				FreezeEntityPosition(vehicle, true)

				if class ~= 8 and class ~= 13 and class ~= 14 then
					QBCore.Functions.Notify(Lang:t('info.fasten_your_seat_belt_and_start_the_engine_to_start_the_test'), 'primary', 4000)

					while not Checkseatbelt() do
						Wait(100)
					end
				else
					QBCore.Functions.Notify(Lang:t('info.start_the_engine_to_start_the_test'), 'primary', 4000)
				end

				while not GetIsVehicleEngineRunning(vehicle) do
					Wait(100)
				end
				FreezeEntityPosition(vehicle, false)
				QBCore.Functions.Notify(Lang:t('success.very_good_go_to_the_next_point'), 'success', 4000)
			end)
		end
	},
	{
		Pos = vector3(255.139, -1400.731, 29.537),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point_the_speed_limit_is_x_kmh', {speed = Config.SpeedLimits['residence']}), 'primary', 4000)
		end
	},
	{
		Pos = vector3(271.874, -1370.574, 30.932),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point'), 'primary', 4000)
		end
	},
	{
		Pos = vector3(234.907, -1345.385, 29.542),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			CreateThread(function()
				QBCore.Functions.Notify(Lang:t('warning.stop_for_pedestrians'), 'primary', 4000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
				FreezeEntityPosition(vehicle, true)
				Wait(4000)
				FreezeEntityPosition(vehicle, false)
				QBCore.Functions.Notify(Lang:t('success.very_good_go_to_the_next_point'), 'success', 4000)
			end)
		end
	},
	{
		Pos = vector3(217.821, -1410.520, 28.292),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('town')
			CreateThread(function()
				QBCore.Functions.Notify(Lang:t('info.stop_and_look_to_the_left_it_is_time_to_really_drive_on_the_road_the_speed_limits_in_the_city_are_x_kmh', {speed = Config.SpeedLimits['town']}), 'primary', 4000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
				FreezeEntityPosition(vehicle, true)
				Wait(6000)
				FreezeEntityPosition(vehicle, false)
				QBCore.Functions.Notify(Lang:t('info.very_well_turn_right_and_follow_directions'), 'primary', 4000)
			end)
		end
	},
	{
		Pos = vector3(178.550, -1401.755, 27.725),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.watch_the_traffic_and_turn_on_your_lights'), 'primary', 4000)
		end
	},
	{
		Pos = vector3(113.160, -1365.276, 27.725),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point'), 'primary', 4000)
		end
	},
	{
		Pos = vector3(-73.542, -1364.335, 27.789),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.stop_for_passing_vehicles'), 'primary', 4000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Wait(6000)
			FreezeEntityPosition(vehicle, false)
			QBCore.Functions.Notify(Lang:t('success.very_good_go_to_the_next_point'), 'success', 4000)
		end
	},
	{
		Pos = vector3(-355.143, -1420.282, 27.868),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point'), 'primary', 4000)
		end
	},
	{
		Pos = vector3(-439.148, -1417.100, 27.704),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point'), 'primary', 4000)
		end
	},
	{
		Pos = vector3(-453.790, -1444.726, 27.665),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('freeway')
			QBCore.Functions.Notify(Lang:t('info.it_is_time_to_drive_on_the_highway_speed_limit_x_kmh', {speed = Config.SpeedLimits['freeway']}), 'primary', 4000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},
	{
		Pos = vector3(-463.237, -1592.178, 37.519),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point'), 'primary', 4000)
		end
	},
	{
		Pos = vector3(-900.647, -1986.28, 26.109),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point'), 'primary', 4000)
		end
	},
	{
		Pos = vector3(1225.759, -1948.792, 38.718),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point'), 'primary', 4000)
		end
	},
	{
		Pos = vector3(1225.759, -1948.792, 38.718),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.entered_town_pay_attention_to_your_speed_speed_limit_x_kmh', {speed = Config.SpeedLimits['town']}), 'primary', 4000)
			SetTimeout(4000, function()
				setCurrentZoneType('town')
			end)

		end
	},
	{
		Pos = vector3(1163.603, -1841.771, 35.679),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.im_impressed_but_dont_forget_to_stay_alert_whilst_driving'), 'primary', 4000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},
	{
		Pos = vector3(235.283, -1398.329, 28.921),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			for i = -1, 5,1 do
				seat = GetPedInVehicleSeat(vehicle,i)
				if seat ~= 0 then
					TaskLeaveVehicle(seat,vehicle,0)
					SetVehicleDoorsLocked(vehicle)
				end
			   end
			   Wait(3000)
			QBCore.Functions.DeleteVehicle(vehicle)
		end
	}
}

Config.PedList = {
	{
		model = 'ig_paper',
		coords = vector3(210.49, -1381.94, 29.58),
		heading = 140.35,
		gender = 'male',
        scenario = 'WORLD_HUMAN_CLIPBOARD'
	},
	{
		model = 'ig_paper',
		coords = vector3(250.96, -1413.1, 29.59),
		heading = 32.17,
		gender = 'male',
        scenario = 'WORLD_HUMAN_CLIPBOARD'
	},
}



-- DON TOUCH UNLESS YOU KNOW WHAT YOU DO
function GetFormationByType(type)
	for _,v in pairs(Config.formations) do
		if (v.type == type) then return v end
	end
	return null
end