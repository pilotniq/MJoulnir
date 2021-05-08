import test from 'ava';
import {Battery} from './boatModel.js';

// const fn = () => 'foo';

test('BatteryState.calcCellVoltageFromSOC(0.8) returns 3.8', t => {
	t.is(Battery.estimateCellVoltageFromSOC(0.8).toFixed(3), "3.941");
});

test('BatteryState.estimateSOCfromCellVoltage(0.8) returns 3.8', t => {
	t.is(Battery.estimateSOCfromCellVoltage(3.941).toFixed(2), "0.80");
});