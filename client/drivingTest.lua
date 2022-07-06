local seatbelterr = {}
local wrongvehicle = false
local notinvehicle = false
local CurrentTest = nil
local CurrentTestType = nil
local CurrentVehicle = nil
local CurrentCheckPoint = 0
local LastCheckPoint = -1
local CurrentBlip = nil
local CurrentZoneType = nil
local DriveErrors = 0
local IsAboveSpeedLimit = false
local LastVehicleHealth = nil

local function SetCurrentZoneType(type)
	CurrentZoneType = type
end

local function StartTestThreads()
	CreateThread(function() -- Drive test
		while CurrentTest == 'drive' do
			Wait(0)
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			local nextCheckPoint = CurrentCheckPoint + 1

			if Config.CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then RemoveBlip(CurrentBlip) end
				CurrentTest = nil
				QBCore.Functions.Notify(Lang:t('success.you_have_completed_your_driving_test'), 'success', 2000)
				StopDriveTest(((100 - DriveErrors) >= Config.scoretopass))
				return;
			end

			if IsPedInAnyVehicle(playerPed, false) then
				notinvehicle = false
				local vehin = GetVehiclePedIsIn(playerPed)
				local vehinplate = QBCore.Functions.GetPlate(vehin)
				local vehplate = QBCore.Functions.GetPlate(CurrentVehicle)
                local class = GetVehicleClass(vehin)

				if vehinplate ~= vehplate then
					if not wrongvehicle then
						QBCore.Functions.Notify(Lang:t('error.you_can_only_use_the_vehicle_provided_by_the_driving_school_to_take_this_test'), 'error', 2000)
						wrongvehicle = true
					end
				else
					wrongvehicle = false
                    local speed = GetEntitySpeed(vehin) * Config.SpeedMultiplier
                    local tooMuchSpeed = false
                    for k, v in pairs(Config.SpeedLimits) do
                        if CurrentZoneType == k and speed > v then
                            tooMuchSpeed = true
                            if not IsAboveSpeedLimit then
                                DriveErrors = DriveErrors + 5
                                IsAboveSpeedLimit = true
                                QBCore.Functions.Notify(Lang:t('warning.you_drive_too_fast'), 'primary', 2000)
                                QBCore.Functions.Notify(Lang:t('error.you_have_been_deducted_5_points'), 'error', 2000)
                                QBCore.Functions.Notify(Lang:t('error.total_score_has_been_deducted_x', {score = DriveErrors}), 'error', 2000)
                            end
                        end
                    end
                    if not tooMuchSpeed then
                        IsAboveSpeedLimit = false
                    end
                    local health = GetEntityHealth(vehin)
                    if health < LastVehicleHealth then
                        DriveErrors = DriveErrors + 5
                        QBCore.Functions.Notify(Lang:t('warning.you_damaged_the_vehicle'), 'primary', 2000)
                        QBCore.Functions.Notify(Lang:t('error.you_have_been_deducted_5_points'), 'error', 2000)
                        QBCore.Functions.Notify(Lang:t('error.total_score_has_been_deducted_x', {score = DriveErrors}), 'error', 2000)
                        LastVehicleHealth = health
                        Wait(1500)
                    end
                    if class ~= 8 and class ~= 13 and class ~= 14 then
                        if not exports['cd_carhud']:checkseatbelt() and CurrentCheckPoint > 1 and not seatbelterr[CurrentCheckPoint] and speed > 10 then
                            seatbelterr[CurrentCheckPoint] = true
                            DriveErrors = DriveErrors + 5
                            QBCore.Functions.Notify(Lang:t('warning.youre_not_wearing_a_seat_belt'), 'primary', 2000)
                            QBCore.Functions.Notify(Lang:t('error.you_have_been_deducted_5_points'), 'error', 2000)
                            QBCore.Functions.Notify(Lang:t('error.total_score_has_been_deducted_x', {score = DriveErrors}), 'error', 2000)
                            Wait(1500)
                        end
                    end

					if CurrentCheckPoint ~= LastCheckPoint then
						if DoesBlipExist(CurrentBlip) then
							RemoveBlip(CurrentBlip)
						end
						CurrentBlip = AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos)
						SetBlipRoute(CurrentBlip, 1)
						LastCheckPoint = CurrentCheckPoint
					end
					local distance = #(coords - Config.CheckPoints[nextCheckPoint].Pos)
					if distance <= 100.0 then
						DrawMarker(1, Config.CheckPoints[nextCheckPoint].Pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
					end
					if distance <= 3.0 then
						Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
						CurrentCheckPoint = CurrentCheckPoint + 1
					end
				end
			else
				if CurrentCheckPoint > 1 then
					if not notinvehicle then
						QBCore.Functions.Notify(Lang:t('error.you_need_a_vehicle_to_take_the_test'), 'error', 2000)
						notinvehicle = true
					end
				end
			end
		end
	end)
end

function StopDriveTest(success)
	if success then
		TriggerServerEvent('driverschool:server:addLicense', CurrentTestType)
		QBCore.Functions.Notify(Lang:t('info.you_have_passed_the_x_class_driving_license_practice_test_congratulations', {class = CurrentTestType}), 'success', 2000)
	else
		QBCore.Functions.Notify(Lang:t('info.you_have_failed_the_practical_test_of_your_x_class_driver_s_license_prepare_well_for_the_next_time', {class = CurrentTestType}), 'error', 2000)
	end
	CurrentTest     = nil
	CurrentTestType = nil
	seatbelterr = {}
end

function StartDriveTest(type)
	QBCore.Functions.Notify(Lang:t('info.get_in_the_vehicle_at_the_starting_line_and_start_the_test'), 'primary', 4000)
	QBCore.Functions.SpawnVehicle(GetFormationByType(type).vehicles[1], function(vehicle)
		SetVehicleNumberPlateText(vehicle, 'TL' .. string.format('%06d', math.random(1, 999999)))
		SetEntityHeading(vehicle, Config.Zones.VehicleSpawnPoint.Pos.w)
		exports['LegacyFuel']:SetFuel(vehicle, 100.0)
		TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(vehicle))
		SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
        SetVehicleDirtLevel(vehicle)
        SetVehicleUndriveable(vehicle, false)
        WashDecalsFromVehicle(vehicle, 1.0)
		CurrentTest = 'drive'
		CurrentTestType = type
		CurrentCheckPoint = 0
		LastCheckPoint = -1
		CurrentZoneType = 'residence'
		DriveErrors = 0
		IsAboveSpeedLimit = false
		CurrentVehicle = vehicle
		LastVehicleHealth = GetEntityHealth(vehicle)
	end, Config.Zones.VehicleSpawnPoint.Pos, true)
	StartTestThreads()
end