playercursel = lbCurSel 10;
_unit = player;
_playerselectedgroup = ((PlayerListArray2 select playercursel) select 3);
[_unit] joinSilent _playerselectedgroup;