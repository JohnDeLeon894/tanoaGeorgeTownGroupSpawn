if ( !isNull player) then {
	playerGroup = createGroup west;
	spawnGroups = compile preprocessFileLineNumbers 'spawngroup.sqf';
	[playerGroup, BLUE_GROUP_SIZE, BLUE_UNITS, WEST_SPAWN] call spawnGroups;
	playerUnit = units playerGroup select 0;
	selectPlayer playerUnit;

};