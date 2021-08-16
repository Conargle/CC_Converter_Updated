if not CC_Converter then
    CC_Converter = {}
    CC_Converter.ModPath = ModPath
end

--Add localized strings for menu
Hooks:Add("LocalizationManagerPostInit", "CC_Converter_MenuLocalization", function(loc)
	loc:load_localization_file(CC_Converter.ModPath .. "/loc/en.txt")
end)

local function giveCC(value)
	local current = Application:digest_value(managers.custom_safehouse._global.total)
	local future = current + value
	Global.custom_safehouse_manager.total = Application:digest_value(future, true)
end

--How much off shore cash per CC
local exchangeRate = 20000000

--Initialize menu
Hooks:Add("MenuManagerInitialize", "CC_Converter_MenuManagerInitialize", function(menu_manager)
        
	-- Buy 1 Coin
    MenuCallbackHandler.callback_cc_converter_convert1 = function()
		
        local confirm_title = "Buy a Continental Coin?"
        local confirm_message = ""
        local confirm_options = {
            [1] = {
                text = "Yes",
                callback = function() CC_Converter:convert_one(exchangeRate) end
            },
            [2] = {
                text = "No",
                is_cancel_button = true
            }
        }
        CC_Converter:ConfirmationDialog(confirm_title, confirm_message, confirm_options)
    end
	
    -- Buy $100,000,000 of coins.
	MenuCallbackHandler.callback_cc_converter_convert2 = function()
		
        local confirm_title = "Spend $100,000,000 on 5 Continental Coins?"
        local confirm_message = ""
        local confirm_options = {
            [1] = {
                text = "Yes",
                callback = function() CC_Converter:convert_small(exchangeRate) end
            },
            [2] = {
                text = "No",
                is_cancel_button = true
            }
        }
        CC_Converter:ConfirmationDialog(confirm_title, confirm_message, confirm_options)
    end	
	
	-- Buy $1,000,000,000 of coins.
	MenuCallbackHandler.callback_cc_converter_convert3 = function()
		
        local confirm_title = "Spend $1,000,000,000 on 50 Continental Coins?"
        local confirm_message = ""
        local confirm_options = {
            [1] = {
                text = "Yes",
                callback = function() CC_Converter:convert_big(exchangeRate) end
            },
            [2] = {
                text = "No",
                is_cancel_button = true
            }
        }
        CC_Converter:ConfirmationDialog(confirm_title, confirm_message, confirm_options)
    end	
  
    ------------------------------------------------------------------------------------
    
    MenuHelper:LoadFromJsonFile(CC_Converter.ModPath .. "/menu/options.txt", CC_Converter, CC_Converter.MenuData)
    
end)

function CC_Converter:ConfirmationDialog(title, message, options)
	local menu = QuickMenu:new(title, message, options)
	menu:Show()    
end

function CC_Converter:convert_one(amount)
	if Application:digest_value(managers.money._global.offshore) >= amount then
		managers.money:_deduct_from_offshore(amount)
		giveCC(1)
	end
end

function CC_Converter:convert_small(amount)
	if Application:digest_value(managers.money._global.offshore) >= 100000000 then
		managers.money:_deduct_from_offshore(100000000)
		giveCC(1*(100000000 / amount))
	end
end

function CC_Converter:convert_big(amount)
	if Application:digest_value(managers.money._global.offshore) >= 1000000000 then
		managers.money:_deduct_from_offshore(1000000000)
		giveCC(1*(1000000000 / amount))
	end
end