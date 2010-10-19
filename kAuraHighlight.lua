 -- defines
local AURAS = {
		-- Death Knight
		{ id = 53766 }, -- anti-magic shell
		{ id = 48792 }, -- icebound fortitude
		{ id = 49222 }, -- bone shield
		{ id = 49039 }, -- lichborne
		{ id = 48265 }, -- unholy presence
		{ id = 48263 }, -- blood presence
		{ id = 48266 }, -- frost presence
		-- Druid
		{ id = 8936 }, -- regrowth
		{ id = 774 }, -- rejuvenation
		{ id = 33763 }, -- lifebloom
		{ id = 22812 }, -- barkskin
		{ id = 48438 }, -- wild growth
		-- Hunter
		-- Mage
		-- Priest
		{ id = 17 }, -- power word: shield
		{ id = 33206 }, -- pain suppresion
		{ id = 139 }, -- renew
		{ id = 6788 }, -- weakened soul
		{ id = 33076, caster = "player" }, -- prayer of mending
		{ id = 6346 }, -- fear ward
		-- Paladin
		{ id = 6940 }, -- hand of sacrifice
		{ id = 82327 }, -- Holy Radiance
		{ id = 25771 }, -- forbearance
		-- Rogue
		{ id = 5277 }, -- evasion
		-- Shaman
		{ id = 974 }, -- earth shield
		{ id = 61295 }, -- Riptide
		-- Warlock
		-- Warrior
	};

local FRAME_MARGIN = 3;
local ICON_MARGIN = 0;
local ICON_SIZE = 22;
	
-- imports
local kCore = kCore;
local kWidgets = kWidgets;
local kEvents = kEvents;

local UnitAuras = kCore.UnitAuras;

local AuraFrame = kWidgets.AuraFrame;

-- private
local HealthBarAuraFrame = function( parent, anchor, x, y )
	local frame = kWidgets.AuraFrame( parent, UnitAuras );
	frame:SetIconSize( ICON_SIZE );
	frame:SetMargin( FRAME_MARGIN );
	frame:SetPoint( anchor, parent.Health, anchor, x, y );
	frame:SetFrameStrata( parent:GetFrameStrata() );
	frame:SetFrameLevel( parent.Health:GetFrameLevel() + 1 );	
	frame:AddFilter( AURAS );
end

-- event handlers

-- main
	--HealthBarAuraFrame( oUF_Tukz_player, "TOP", 0, -ICON_MARGIN ); -- ORIGINAL VALUE
	--HealthBarAuraFrame( oUF_Tukz_target, "TOP", 0, -ICON_MARGIN ); -- ORIGINAL VALUE	
HealthBarAuraFrame( oUF_Tukz_player, "LEFT", 2, ICON_MARGIN );
HealthBarAuraFrame( oUF_Tukz_target, "LEFT", 2, ICON_MARGIN );
	
for index = 1, 5 do
	local frame = _G[ "oUF_Arena" .. tostring( index ) ]
	if ( not frame ) then break; end
	
	HealthBarAuraFrame( frame, "TOPLEFT", ICON_MARGIN, -ICON_MARGIN );
end

for index = 1, 5 do
	local frame = _G[ "oUF_PartyPet" .. tostring( index ) ]
	if ( not frame ) then break; end

	HealthBarAuraFrame( frame, "TOPRIGHT", -ICON_MARGIN, -ICON_MARGIN );
end

do
	local event;
	local partyFramesCreated = 1;
	local OnPartyMembersChanged = function( self )
		for index = partyFramesCreated, 5 do
			local frame = _G[ "oUF_GroupUnitButton" .. tostring( index ) ];
			if ( not frame ) then
				break;
			end
			
			HealthBarAuraFrame( frame, "CENTER", 0, 0 ); --HealthBarAuraFrame( frame, "TOPRIGHT", -ICON_MARGIN, -ICON_MARGIN ); ORIGINAL VALUE
			partyFramesCreated = partyFramesCreated + 1
		end
		
		if ( partyFramesCreated > 5 ) then
			kEvents.UnregisterEvent( event );
		end
	end
	event = kEvents.RegisterEvent( "PARTY_MEMBERS_CHANGED", OnPartyMembersChanged );
end
