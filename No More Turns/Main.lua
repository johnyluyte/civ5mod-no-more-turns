-- Lua Script1
-- Author: chunnorris
-- DateCreated: 9/28/2015 3:17:41 PM
--------------------------------------------------------------

-- After the player reaches `time_limit`, they have `turn_buffer` before receiving penalty.


-- input: 10:15:03 , output: 36018 (seconds)
function getTotalSecondsFromCurrentTimestamp()
	local hour, min, sec;
	hour, min, sec = os.date("%H:%M:%S"):match("([^,]+):([^,]+):([^,]+)");
	return hour*3600 + min*60 + sec;
end

-- input: 36018 (seconds), output: 10:15:03
function getTimestampFromTotalSeconds(totalSeconds)
    local hour, min, sec;
	hour = math.floor(totalSeconds/3600);
	min = math.floor((totalSeconds%3600)/60);
	sec = (totalSeconds%60);
	return tostring(hour.. ":" .. min .. ":" .. sec);
end


-- Seconds limited for one sessions.   
-- time_limit = 60 = 1 minute
-- time_limit = 3600 = 1 hour
local time_limit = 3600;

-- Does the player reach time_limit?
local is_time_limit_reached = false;

-- Turns before citizens starts to build Protest Signs.
local turn_buffer_before_penalty = 5;

-- Get the Timestamp(in seconds) when the player starts or loads a game.
local secs_session_started = getTotalSecondsFromCurrentTimestamp();

-- Get the Player instance of the player who is playing the game.
local humanPlayer;
for id, pPlayer in pairs(Players) do
	if pPlayer:IsEverAlive() and pPlayer:IsHuman() then
		humanPlayer = pPlayer;
	end
end


-- ContextPtr:SetUpdate runs on each screen update.
ContextPtr:SetUpdate(function()
	-- Get the current Timestamp(in seconds).
	local secs_now = getTotalSecondsFromCurrentTimestamp();

	-- If secs_elapsed < 0, it means that the game has been played through the midnight.
	-- This is bad for your health. You should not stayed up late just to play one more turn.
	local secs_elapsed = secs_now - secs_session_started;
	if secs_elapsed < 0 then
		secs_elapsed = 86400 + secs_now - secs_session_started;
	end;

	-- Display "how many seconds had elapsed in this session" in the UI.
	Controls.ClockSecElapsed:SetString(getTimestampFromTotalSeconds(secs_elapsed+90) .. " had elapsed after game started.");

	if secs_elapsed > time_limit then
	    is_time_limit_reached = true;
	end;
end);

-- This function will run every time a new turn starts.
function onTurnStart()
    -- Do nothing if the `time_limit` is not reached.
    if is_time_limit_reached == false then
		return;
	-- Notify the player if the session_limit is reached, but trun buffer 
	elseif turn_buffer_before_penalty > 0 then
	    notifyTimeLimitReached();
	else
	    citizenBuildProtestSign();
	end
end
Events.ActivePlayerTurnStart.Add(onTurnStart);

-- Notify the player that the `time-limit` had been reached.
function notifyTimeLimitReached()
	local pCity = humanPlayer:GetCapitalCity();
	local sTitle = turn_buffer_before_penalty .. " turns before Citizens strike";
	local sText = "You have been playing civ5 for 1 hour without taking a rest. Your citizens will start to protest (gain [ICON_HAPPINESS_3]" ..
	" Unhappiness) if you do not take a rest.[NEWLINE][NEWLINE] Turns left before Citizens strike: " .. turn_buffer_before_penalty;

	humanPlayer:AddNotification(NotificationTypes.NOTIFICATION_STARVING, sText, sTitle, pCity:GetX(), pCity:GetY())
	turn_buffer_before_penalty = turn_buffer_before_penalty - 1;
end

-- The `time_limit` had been reached and the `turn_buffer` is over. Citizens starts to get angry.
function citizenBuildProtestSign()
	local pCity = humanPlayer:GetCapitalCity();	

	-- BuildingClass ID of Protest Sign is 5566
	local numOfProtestSign = humanPlayer:GetBuildingClassCount(5566);
	-- Citizens build a new Protest Sign.
	numOfProtestSign = numOfProtestSign + 1;
	pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_PROTESTSIGN, numOfProtestSign);

	-- Show Notification
	local sTitle = "Citizens in " .. pCity:GetName() .. " are protesting!";
	local sText = "Citizens are not happy about their leader working all day without rest! They bulit a Protest Sign in " .. 
	pCity:GetName() .. ". The Protest Signs gradually increase [ICON_HAPPINESS_4] unhappiness in all your cities. [NEWLINE][NEWLINE]Number of Protest Sign: " .. numOfProtestSign;
	humanPlayer:AddNotification(NotificationTypes.NOTIFICATION_STARVING, sText, sTitle, pCity:GetX(), pCity:GetY())
end
