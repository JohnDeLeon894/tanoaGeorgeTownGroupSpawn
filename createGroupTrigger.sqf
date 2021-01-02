
private _group = _this select 0;
private _side = _this select 1;
_groupName = format['%1_%2',_side, _group];
hint _groupName;

private _groupSize = '';
private _units = '';
private _spawnPoint = '';

switch (_side) do {
	case west: {
		_groupSize = BLUE_GROUP_SIZE;
		_units = BLUE_UNITS;
		_spawnPoint = WEST_SPAWN;
	};
	case East: {
		_groupSize = RED_GROUP_SIZE;
		_units = RED_UNITS;
		_spawnPoint = EAST_SPAWN;
	};
	default hint format['no side chosen. Side: %1', _side];
};
private _conditionText = format['count units %1 == 0 && %2 countside allUnits < 64', _groupName, _side];
// [_group, _count, _unitsArray, _position, side] call spawnGroups;
private _activationText = format ['[%1, %2, %3, %4, %5] execVM "spawngroup.sqf"; hint "trigger acitivated!"; trigger_%6 = true;', _groupName, _groupSize, _units, _spawnPoint, _side, _group ];
private _deactivationText = format['trigger_%1 = false;', _group];
player globalChat _group;
private _groupTrigger = createTrigger ['EmptyDetector', [0,0,0]];
_groupTrigger setTriggerStatements[_conditionText, _activationText,_deactivationText];
_groupTrigger setTriggerActivation ['NONE', 'NOT PRESENT', true];
_groupTrigger setTriggerInterval 5;
_groupTrigger enableSimulation true;
