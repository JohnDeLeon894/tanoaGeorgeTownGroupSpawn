// spawns units when called
// [_group, _count, _unitsArray, _position, side, groupMarker] call spawnGroups;

private _group 			 = _this select 0;
private _count 			 = _this select 1;
private _unitsArray	 = _this select 2;
private _position 	 = _this select 3;
private _side 			 = _this select 4;
private _groupMarker = _this select 5;
private _k = 0;
private _j = 10;
private _continue = true;

private _westWaypointLoop = {
	while {_continue} do {
		_k = _k+1;
		private _locName = format ['objective_%1', _k];
		if(_locName in allMapMarkers) then {
			_group addWaypoint[markerPos _locName, 100, _k - 1];
		} else {
			_group addWaypoint[EAST_SPAWN, 100];
			_continue = false;
		};
	};
};

private _eastWaypointLoop = {
			_group addWaypoint[ markerPos _groupMarker, 100];
			hint format['the markder passed %1', _groupMarker];
};

private _spawnGroup = {
	if(_count < 1 ) exitWith {hint "exiting spawn loop"};
	// spawns unit and adds to group
	player globalChat format['group name passed  to spawn script %1 ',_group];
	for [{private _i=0}, {_i<_count}, {_i=_i+1}] do {
		if (_side countside allUnits > 90) exitWith {
			player globalChat format['Troop limit reached at troop count %1', _side countside allUnits ];
		};
		_soldierRole =  _unitsArray call BIS_fnc_selectRandom; 
		_soldierRole createUnit [_position, _group];
	};
	player globalChat format['Created group %1!', _group];

	while {(count (waypoints _group)) > 0} do {
		deleteWaypoint ((waypoints _group) select 0);
	};

	switch (_side) do {
		case west: {[] call _westWaypointLoop; _group setBehaviour "SAFE";};
		case east: {[] call _eastWaypointLoop;};
		default {hint format['no side chosen: %1', _side] };
	};
};

[] call _spawnGroup;
