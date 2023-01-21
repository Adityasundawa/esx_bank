ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterNetEvent('esx_banking:deposit', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	amount = tonumber(amount)

	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('esx_banking:result', _source, "error", _U('invaild_amount'))
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))

		TriggerClientEvent('esx_banking:result', _source, "success", _U('deposited'))
	end
end)

RegisterNetEvent('esx_banking:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = xPlayer.getAccount('bank').money

	amount = tonumber(amount)

	if amount == nil or amount <= 0 or amount > base then
		TriggerClientEvent('esx_banking:result', _source, "error", _U('invaild_amount'))
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)

		TriggerClientEvent('esx_banking:result', _source, "success", _U('withdrawed'))
	end
end)

RegisterNetEvent('esx_banking:balance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('esx_banking:currentbalance', _source, xPlayer.getAccount('bank').money)
end)

RegisterNetEvent('esx_banking:transfer', function(target, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromId(target)
	local balance = xPlayer.getAccount('bank').money

	amount = tonumber(amount)

	if xTarget == nil or xTarget == -1 then
		TriggerClientEvent('esx_banking:result', _source, "error", _U('invaild_target'))
	else
		if tonumber(_source) == tonumber(target) then
			TriggerClientEvent('esx_banking:result', _source, "error", _U('missing_money_cash'))
		else
			if balance <= 0 or balance < tonumber(amount) or tonumber(amount) <= 0 then
				TriggerClientEvent('esx_banking:result', _source, "error", _U('missing_money_bank'))
			else
				xPlayer.removeAccountMoney('bank', tonumber(amount))
				xTarget.addAccountMoney('bank', tonumber(amount))

				TriggerClientEvent('esx_banking:result', _source, "success", _U('transfered'))
			end
		end
	end
end)
