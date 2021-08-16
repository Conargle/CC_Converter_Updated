if not CC_Converter then
    CC_Converter = {}
    CC_Converter.ModPath = ModPath
end

--Load Text Strings
Hooks:Add("LocalizationManagerPostInit", "CC_Converter_MenuLocalization", function(loc)
	loc:load_localization_file(CC_Converter.ModPath .. "/loc/english.txt")
end)

local function giveCC(value)
	local current = Application:digest_value(managers.custom_safehouse._global.total)
	local future = current + value
	Global.custom_safehouse_manager.total = Application:digest_value(future, true)
end

--Cost Per Coin
local exchangeRate = 10000000

--Create Menu
Hooks:Add("MenuManagerInitialize", "CC_Converter_MenuManagerInitialize", function(menu_manager)
    
	--Buy 1
    MenuCallbackHandler.callback_cc_converter_convert1 = function()
		
        local confirm_title = managers.localization:text("cc_converter_convert1_confirm_title")
        local confirm_message = managers.localization:text("cc_converter_confirm_msg")
        local confirm_options = {
            [1] = {
                text = managers.localization:text("cc_converter_positive_choice"),
                callback = function() CC_Converter:convert_1(exchangeRate) end
            },
            [2] = {
                text = managers.localization:text("cc_converter_negative_choice"),
                is_cancel_button = true
            }
        }
        CC_Converter:ConfirmationDialog(confirm_title, confirm_message, confirm_options)
    end
	
	--Buy 5
	MenuCallbackHandler.callback_cc_converter_convert2 = function()
		
        local confirm_title = managers.localization:text("cc_converter_convert2_confirm_title")
        local confirm_message = managers.localization:text("cc_converter_confirm_msg")
        local confirm_options = {
            [1] = {
                text = managers.localization:text("cc_converter_positive_choice"),
                callback = function() CC_Converter:convert_5(exchangeRate) end
            },
            [2] = {
                text = managers.localization:text("cc_converter_negative_choice"),
                is_cancel_button = true
            }
        }
        CC_Converter:ConfirmationDialog(confirm_title, confirm_message, confirm_options)
    end	
	
	-- Buy 10 Deal
	MenuCallbackHandler.callback_cc_converter_convert3 = function()
		
        local confirm_title = managers.localization:text("cc_converter_convert3_confirm_title")
        local confirm_message = managers.localization:text("cc_converter_confirm_msg")
        local confirm_options = {
            [1] = {
                text = managers.localization:text("cc_converter_positive_choice"),
                callback = function() CC_Converter:convert_10(exchangeRate) end
            },
            [2] = {
                text = managers.localization:text("cc_converter_negative_choice"),
				is_cancel_button = true
            }
        }
        CC_Converter:ConfirmationDialog(confirm_title, confirm_message, confirm_options)
    end	
	
 	-- Buy 25 Deal
	MenuCallbackHandler.callback_cc_converter_convert4 = function()
		
        local confirm_title = managers.localization:text("cc_converter_convert4_confirm_title")
        local confirm_message = managers.localization:text("cc_converter_confirm_msg")
        local confirm_options = {
            [1] = {
                text = managers.localization:text("cc_converter_positive_choice"),
                callback = function() CC_Converter:convert_50(exchangeRate) end
            },
            [2] = {
                text = managers.localization:text("cc_converter_negative_choice"),
                is_cancel_button = true
            }
        }
        CC_Converter:ConfirmationDialog(confirm_title, confirm_message, confirm_options)
    end	
	
	-- Buy 50 Deal
	MenuCallbackHandler.callback_cc_converter_convert5 = function()
		
        local confirm_title = managers.localization:text("cc_converter_convert5_confirm_title")
        local confirm_message = managers.localization:text("cc_converter_confirm_msg")
        local confirm_options = {
            [1] = {
                text = managers.localization:text("cc_converter_positive_choice"),
                callback = function() CC_Converter:convert_100(exchangeRate) end
            },
            [2] = {
                text = managers.localization:text("cc_converter_negative_choice"),
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

function CC_Converter:convert_1(amount)
	if Application:digest_value(managers.money._global.offshore) >= amount then
		managers.money:_deduct_from_offshore(amount)
		giveCC(1)
	end
end

function CC_Converter:convert_5(amount)
	if Application:digest_value(managers.money._global.offshore) >= 50000000 then
		managers.money:_deduct_from_offshore(50000000)
		giveCC(1*(50000000 / amount))
	end
end

function CC_Converter:convert_10(amount)
	if Application:digest_value(managers.money._global.offshore) >= 100000000 then
		managers.money:_deduct_from_offshore(100000000)
		giveCC(1*(100000000 / amount))
	end
end

function CC_Converter:convert_50(amount)
	if Application:digest_value(managers.money._global.offshore) >= 500000000 then
		managers.money:_deduct_from_offshore(500000000)
		giveCC(1*(500000000 / amount))
	end
end

function CC_Converter:convert_100(amount)
	if Application:digest_value(managers.money._global.offshore) >= 1000000000 then
		managers.money:_deduct_from_offshore(1000000000)
		giveCC(1*(1000000000 / amount))
	end
end
