BLUE_GROUP_SIZE = 4;
RED_GROUP_SIZE = 6;
WEST_SPAWN = markerPos 'west_spawn';
EAST_SPAWN = markerPos 'east_spawn';

Isis_Unit_Configs = "getText (_x >> 'faction') == 'LOP_ISTS_OPF' && getText (_x >> 'simulation') == 'soldier';" configClasses (configFile >> "CfgVehicles");
RED_UNITS = Isis_Unit_Configs apply {configName _x};

bluforUnitsConfig= "getText (_x >> 'faction') == 'LOP_PMC' && getText (_x >> 'simulation') == 'soldier';] call BIS_fnc_inString;" configClasses (configFile >> "CfgVehicles");
BLUE_UNITS = bluforUnitsConfig apply {configName _x};

[] execVM 'spawnPlayer.sqf';
[] execVM 'createGroupPerMarker.sqf';
