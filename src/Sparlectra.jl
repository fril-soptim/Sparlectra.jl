module Sparlectra
# Author: Udo Schmitz (https://github.com/Welthulk)
# Purpose: network calculation


# resource data types for working with Sparlectra
const Wurzel3 = 1.7320508075688772
const SparlectraVersion = VersionNumber("0.4.10")
abstract type AbstractBranch end
export
  # constants
  Wurzel3, ComponentTyp,
  # classes  
  # Component
  AbstractComponent, Component, ImpPGMComp, ImpPGMComp3WT, 
  # Node
  Node, 
  # Line
  ACLineSegment,
  # Trafo
  TrafoTyp, PowerTransformerTaps,  PowerTransformerWinding,  PowerTransformer, TransformerModelParameters,
  # ProSumer
  ProSumer,
  # Branch
  AbstractBranch, Branch,BranchModel,  BranchFlow, getBranchFlow, setBranchFlow!, setBranchStatus!,getBranchLosses, setBranchLosses!,
  # Shunt
  Shunt,
  # Net
  Net,
  
  # functions  
  # Compomnent
  toComponentTyp,  getRXBG,
  # Transformers
  getSideNumber2WT,  getWinding2WT,  calcTransformerRatio,  recalc_trafo_model_data,  create2WTRatioTransformerNoTaps,  create3WTWindings!,
  getTrafoImpPGMComp,  getWT3AuxBusID,  isPerUnit_RXGB,
  # Nodes  
  setRatedS!,  setVmVa!,  addShuntPower!,  addLoadPower!,  addGenPower!,  getNodeVn,  isSlack,  isPVNode,  toNodeType,
  busComparison,   toString,
  # Branch
  setBranchFlow!,  setBranchStatus!,
  # Shunt
  getGBShunt,  getPQShunt,
  # ACLineSegment
  get_line_parameters,
  # ProSumer
  isSlack, isGenerator, isAPUNode, setQGenReplacement!, getQGenReplacement, toProSumptionType,
  # Net
  addBus!, addShunt!, addACLine!, add2WTrafo!, addProsumer!, validate, geNetBusIdx, setTotalLosses!, getTotalLosses,
  # create_powermat.jl
  casefileparser, createNetFromMatPowerFile,
  # exportMatPower.jl
  writeMatpowerCasefile,
  # equicircuit.jl
  calcComplexRatio, calcNeutralU,  createYBUS, adjacentBranches,
  # nbi.jl
  getNBI, mdoRCM,
  # jacobian.jl
  setJacobianDebug, runpf!,
  # losses.jl
  calcNetLosses!,
  
  # results.jl
  printACPFlowResults, convertPVtoPQ!


include("component.jl")
include("lines.jl")
include("transformer.jl")
include("prosumer.jl")
include("node.jl")
include("branch.jl")
include("shunt.jl")
include("network.jl")
include("import.jl")
include("equicircuit.jl")
include("jacobian.jl")
include("losses.jl")
include("nbi.jl")
include("createnet_powermat.jl")
include("exportMatPower.jl")
include("results.jl")


end # module Sparlectra
