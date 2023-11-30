% This file was generated by sparlectra exportMatPower.jl
function mpc = bsp3
%% MATPOWER Case Format : Version 2
mpc.version = '2';
%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100.0;
%% bus data
mpc.bus = [
%bus	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
1	1	100.0	30.0	0.0	0.0	1	1.0	0.0	110.0	1	1.1	0.9; %Bus: ASTADT (ID: 73ab8d21-4570-4d69-9d34-763bff7c0704 kIdx: 1)
2	2	0.0	0.0	0.0	0.0	1	1.03	0.0	110.0	1	1.1	0.9; %Bus: STADION1 (ID: bfcfb8cd-c6ab-485a-b344-36649c32fe33 kIdx: 2)
3	3	0.0	0.0	0.0	0.0	1	1.02	0.0	110.0	1	1.1	0.9; %Bus: VERBUND (slack) (ID: a5046651-fdcd-4aba-a479-2e49440c2439 kIdx: 3)
];
%% generator data
mpc.gen = [
%bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
2	70.0	0	50.0	-50.0	1.03	100.0	1	0	0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0; %Gen: SynchronousMachine_GEN_STADION1 (ID: bfcfb8cd-c6ab-485a-b344-36649c32fe33)
3	0	0	0	0	1.02	100.0	1	0	0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0	0.0; %Gen: ExternalNetworkInjection_EXT_VERBUND (ID: a5046651-fdcd-4aba-a479-2e49440c2439)
];
%% branch data
mpc.branch = [
%fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
1	2	0.0	0.08264463	0.00907567	0	0	0	0.0	0.0	1	-360.0	360.0; %Branch: Name: L1_2, Typ: Line (ID: 96571286-03ab-46ad-bbae-f3073c486b4b)
2	3	0.0	0.08264463	0.00907567	0	0	0	0.0	0.0	1	-360.0	360.0; %Branch: Name: L2_3, Typ: Line (ID: e8b2d371-0af5-4446-8938-1228f0e7aca9)
3	1	0.0	0.08264463	0.00907567	0	0	0	0.0	0.0	1	-360.0	360.0; %Branch: Name: L3_1, Typ: Line (ID: d70df388-d341-4c69-9a0f-10649261a1f0)
];
