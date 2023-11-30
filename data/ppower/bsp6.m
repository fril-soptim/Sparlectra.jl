% This file was generated by sparlectra exportMatPower.jl
function mpc = bsp6
%% MATPOWER Case Format : Version 2
mpc.version = '2';
%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100.0;
%% bus data
mpc.bus = [
%bus	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
1	1	0.0	0.0	0.0	0.0	1	1.0	0.0	110.0	1	1.1	0.9; %Bus: Bus_1 (ID: 9712ab40-c635-418a-baeb-92a38fa1196d kIdx: 1)
2	3	0.0	0.0	0.0	0.0	1	1.03	0.0	110.0	1	1.1	0.9; %Bus: Bus_2 (slack) (ID: 83459fd2-cc98-4a89-bede-c4a03c771c1f kIdx: 2)
3	1	2.0	4.0	0.0	3.8	1	1.0	0.0	22.0	1	1.1	0.9; %Bus: Bus_3 (ID: 7dbd0c1f-a132-4585-a3eb-ebcdfecf17af kIdx: 3)
4	2	0.0	0.0	0.0	0.0	1	1.02	0.0	110.0	1	1.1	0.9; %Bus: Bus_4 (ID: 09b0966c-5847-46a8-8ee1-1cac8ac0baf3 kIdx: 4)
];
%% generator data
mpc.gen = [
%bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
1	2.0	-0.5	0	0	1.0	100.0	1	0	0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0; %Gen: Generator_SG1 (ID: 9712ab40-c635-418a-baeb-92a38fa1196d)
2	6.0	0	15.0	-15.0	1.03	100.0	1	0	0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0; %Gen: SynchronousMachine_VG1 (ID: 83459fd2-cc98-4a89-bede-c4a03c771c1f)
4	0	0	0	0	1.02	100.0	1	0	0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0; %Gen: ExternalNetworkInjection_ExG1 (ID: 09b0966c-5847-46a8-8ee1-1cac8ac0baf3)
];
%% branch data
mpc.branch = [
%fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
4	2	0.04132231	0.08057851	0.00907567	0	0	0	0.0	0.0	1	-360.0	360.0; %Branch: Name: L4_2, Typ: Line (ID: 7bf8299e-acdd-4d2a-80f7-529e7808d065)
4	1	0.00413223	0.0322314	0.00363027	0	0	0	0.0	0.0	1	-360.0	360.0; %Branch: Name: L4_1, Typ: Line (ID: 5ab32591-1813-49d6-813d-a595c5d6405b)
2	3	0.0041	0.09991591	-0.00042	0	0	0	1.0	0.0	1	-360.0	360.0; %Branch: Name: T1, Typ: Trafo (ID: 439da4a2-562d-47ac-ae13-eba05051dc6a)
];
