local inMenu = true
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj
		end)

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if not inMenu then
			local player = PlayerPedId()
			local playerloc = GetEntityCoords(player)

			for _, search in pairs(Config.Banks) do
				local distance = #(search.coords - playerloc)

				if distance <= 3 then
					ESX.ShowHelpNotification(_U('press_key'))

					if IsControlJustPressed(1, 38) then
						inMenu = true

						SetNuiFocus(true, true)
						SendNUIMessage({type = 'openGeneral'})

						TriggerServerEvent('esx_banking:balance')
					end
				end
			end
		else
			if IsControlJustPressed(1, 322) then
				inMenu = false

				SetNuiFocus(false, false)
				SendNUIMessage({type = 'close'})
			end
		end
	end
end)

Citizen.CreateThread(function()
	if Config.ShowBlips then
		for k, v in ipairs(Config.Banks)do
			local blip = AddBlipForCoord(v.coords)

			SetBlipSprite(blip, v.id)
			SetBlipScale(blip, 0.7)
			SetBlipAsShortRange(blip, true)

			if v.principal ~= nil and v.principal then
				SetBlipColour(blip, 77)
			end

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(tostring(v.name))
			EndTextCommandSetBlipName(blip)
		end
	end
end)

RegisterNetEvent('esx_banking:currentbalance', function(balance)
	local id = PlayerId()
	local playerName = GetPlayerName(id)

	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		player = playerName
	})
end)

RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('esx_banking:deposit', tonumber(data.amount))
	TriggerServerEvent('esx_banking:balance')
end)

RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('esx_banking:withdraw', tonumber(data.amountw))
	TriggerServerEvent('esx_banking:balance')
end)

RegisterNUICallback('balance', function()
	TriggerServerEvent('esx_banking:balance')
end)

RegisterNetEvent('esx_banking:back', function(balance)
	SendNUIMessage({
		type = 'balanceReturn',
		bal = balance
	})
end)

RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('esx_banking:transfer', data.to, data.amountt)
	TriggerServerEvent('esx_banking:balance')
end)

RegisterNetEvent('esx_banking:result', function(type, message)
	SendNUIMessage({
		type = 'result',
		m = message,
		t = type
	})
end)

RegisterNUICallback('NUIFocusOff', function()
	inMenu = false

	SetNuiFocus(false, false)
	SendNUIMessage({
		type = 'closeAll'
	})
end)
