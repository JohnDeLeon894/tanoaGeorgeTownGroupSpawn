groupCount = 0;
spawnGroups = compile preprocessFileLineNumbers 'spawngroup.sqf';
callGroupTrigger = compile preprocessFileLineNumbers'createGroupTrigger.sqf';

private _groupAliveCheck = {
	private _groupName = _this select 0;
	private _groupSuffix = _this select 1;
	private _side = _this select 2;
	if (count units _groupName > 0) exitWith {
		private _exitText = format['group %1 still has living units',
		(format['west_%1', _groupSuffix])];
		hint _exitText;
		true
	};
	false
};

private _spawnGroup = {
	private _side = _this select 0;
	private _groupSize = _this select 1;
	private _unitsArray = _this select 2;
	private _spawnPoint = _this select 3;
	{
		private _markerPos = markerPos _x;
		private _groupName = missionNamespace getVariable format['%1_%2',_side, _x];
		private _groupAlive = [_groupName, _x, _side] call _groupAliveCheck;
		if(!_groupAlive) then {
			diag_log format ['***groupName: %1, side: %2***', _groupName, _side];
			missionNamespace setVariable [format['%1_%2',_side, _x], createGroup [_side, true]];
			_groupName = missionNamespace getVariable format['%1_%2',_side, _x];
			player globalChat format ['group name? %1', _groupName];
			[_groupName, _groupSize, _unitsArray, _spawnPoint, _side] call spawnGroups;
			[_x, _side] call callGroupTrigger;
			
		};
	} forEach allMapMarkers;
};

[west, BLUE_GROUP_SIZE, BLUE_UNITS, WEST_SPAWN] call _spawnGroup;
[east, RED_GROUP_SIZE, RED_UNITS, EAST_SPAWN] call _spawnGroup; 