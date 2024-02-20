# Author: Udo Schmitz (https://github.com/Welthulk)
# Date: 10.05.2023
# include-file transformer.jl

mutable struct TransformesModelParameters
  sn::Float64 # PGM-Parameter sn in VA
  uk::Float64 # PGM-Parameter sn in percent
  pk::Float64 # PGM-Parameter sn in W
  i0::Float64 # PGM-Parameter sn in A
  p0::Float64 # PGM-Parameter sn in W

  function TransformesModelParameters(sn::Float64, uk::Float64, pk::Float64, i0::Float64, p0::Float64)
    new(sn, uk, pk, i0, p0)
  end

  function Base.show(io::IO, x::TransformesModelParameters)
    print(io, "AdditionalParameters(")
    print(io, "sn=$(x.sn), ")
    print(io, "uk=$(x.uk), ")
    print(io, "pk=$(x.pk), ")
    print(io, "i0=$(x.i0), ")
    print(io, "p0=$(x.p0)")
    print(io, ")")
  end

end
mutable struct PowerTransformerTaps
  step::Int                          # aktive step 
  lowStep::Int                       # cim:TapChanger.lowStep
  highStep::Int                      # cim:TapChanger.highStep
  neutralStep::Int                   # cim:TapChanger.neutralStep # 
  voltageIncrement::Float64          # cim:RatioTapChanger.stepVoltageIncrement in percent  
  neutralU::Union{Nothing,Float64}   # cim:TapChanger.neutralU, usually = ratedU of the transformer end, but can deviate

  function PowerTransformerTaps(Step::Int, LowStep::Int, HighStep::Int, NeutralStep::Int, VoltageIncrement::Float64, NeutralU::Union{Nothing,Float64})
    new(Step, LowStep, HighStep, NeutralStep, VoltageIncrement, NeutralU)
  end

  function Base.show(io::IO, x::PowerTransformerTaps)
    print(io, "PowerTransformerTaps(")
    print(io, "step=$(x.step), ")
    print(io, "lowStep=$(x.lowStep), ")
    print(io, "hightStep=$(x.highStep), ")
    print(io, "neutralStep=$(x.neutralStep), ")
    print(io, "voltageIncrement=$(x.voltageIncrement), ")
    if !isnothing(x.neutralU)
      print(io, "neutralU=$(x.neutralU), ")
    end
    print(io, ")")
  end
end

mutable struct PowerTransformerWinding
  Vn::Float64
  r::Float64
  x::Float64
  b::Union{Nothing,Float64}
  g::Union{Nothing,Float64}
  shift_degree::Union{Nothing,Float64}       # cim:PowerTransformerEnd.phaseAngleClock 
  ratedU::Union{Nothing,Float64}             # cim:PowerTransformerEnd.ratedU
  ratedS::Union{Nothing,Float64}             # cim:PowerTransformerEnd.ratedS  
  taps::Union{Nothing,PowerTransformerTaps}
  isPu_RXGB::Union{Nothing,Bool}          # r,x,b in p.u. given? nothing = false

  function PowerTransformerWinding(
    ;
    Vn::Float64,
    r::Float64,
    x::Float64,
    b::Union{Nothing,Float64} = nothing,
    g::Union{Nothing,Float64} = nothing,
    shift_degree::Union{Nothing,Float64} = nothing,
    ratedU::Union{Nothing,Float64} = nothing,
    ratedS::Union{Nothing,Float64} = nothing,
    taps::Union{Nothing,PowerTransformerTaps} = nothing,
    isPu_RXGB::Union{Nothing,Bool} = nothing,
  )
    new(Vn, r, x, b, g, shift_degree, ratedU, ratedS, taps, isPu_RXGB)
  end

  function Base.show(io::IO, x::PowerTransformerWinding)
    print(io, "PowerTransformerWinding(")
    print(io, "Vn=$(x.Vn), ")
    print(io, "r=$(x.r), ")
    print(io, "x=$(x.x), ")
    if !(isnothing(x.b))
      print(io, "b=$(x.b), ")
    end
    if !(isnothing(x.g))
      print(io, "g=$(x.g), ")
    end
    if !(isnothing(x.shift_degree))
      print(io, "shift_degree=$(x.shift_degree), ")
    end
    if !(isnothing(x.ratedU))
      print(io, "ratedU=$(x.ratedU), ")
    end
    if !(isnothing(x.ratedS))
      print(io, "ratedS=$(x.ratedS), ")
    end
    if !(isnothing(x.taps))
      print(io, "taps=$(x.taps), ")
    end
    if !(isnothing(x.isPu_RXGB))
      print(io, "isPu_RXGB=$(x.isPu_RXGB), ")
    end
    print(io, ")")
  end
end

# helper
function hasTaps(x::Union{Nothing,PowerTransformerWinding})::Bool
  if isnothing(x)
    return false
  else
    return !(isnothing(x.taps))
  end
end

function isPerUnit_RXGB(o::PowerTransformerWinding)
  if isnothing(o.isPu_RXGB)
    return false
  else
    return o.isPu_RXGB
  end  
end

mutable struct PowerTransformer
  comp::AbstractComponent
  trafoTyp::TrafoTyp
  isControlled::Bool              # cim:TapChanger.controlEnabled 
  nS::Integer                     # Number of (aktive) Sides >=2   
  nController::Integer            # Number of Sides controlled
  isBiWinder::Bool
  HVSideNumber::Integer           # Number of HV Side [1,2,3], for 3WT HV =1, MV=2, LV=3 
  tapSideNumber::Integer          # Number of Tap Side [1,2,3], = 0 if no Tap
  side1::PowerTransformerWinding
  side2::PowerTransformerWinding
  side3::Union{Nothing,PowerTransformerWinding}
  exParms::Union{Nothing,TransformesModelParameters}

  function PowerTransformer(comp::AbstractComponent, tapEnable::Bool, 
                            s1::PowerTransformerWinding, s2::PowerTransformerWinding, s3::Union{Nothing,PowerTransformerWinding} = nothing, 
                            trafoTyp::TrafoTyp = ResDataTypes.Ratio,
                            exParms::Union{Nothing,TransformesModelParameters} = nothing)
    if isnothing(s3)
      n = 2
      isBi = true
    else
      isBi = false
      n = 3
    end

    controller = 0
    TapSideNumber = 0
    for x in [s1, s2, s3]
      if hasTaps(x)
        controller += 1
        if controller == 1
          TapSideNumber = x == s1 ? 1 : (x == s2 ? 2 : 3)
        end
      end
    end

    v1 = s1.Vn
    v2 = s2.Vn
    if !isnothing(s3)
      v3 = s3.Vn
    else
      v3 = 0.0
    end
    # find HV Side
    if v1 >= v2 && v1 >= v3
      HVSideNumber = 1
    elseif v2 >= v1 && v2 >= v3
      HVSideNumber = 2
    else
      HVSideNumber = 3
    end

    new(comp, trafoTyp, tapEnable, n, controller, isBi, HVSideNumber, TapSideNumber, s1, s2, s3, exParms)
  end

  function Base.show(io::IO, x::PowerTransformer)
    print(io, "PowerTransformer(")
    print(io, x.comp)
    print(io, " trafoTyp=", toString(x.trafoTyp), ", ")
    print(io, "isControlled=$(x.isControlled), ")
    print(io, "ns=$(x.nS), ")
    print(io, "nController=$(x.nController), ")
    print(io, "isBiWinder=$(x.isBiWinder), ")
    println(io, "") # next line
    println(io, "side1=$(x.side1), ")
    if (isnothing(x.side3))
      print(io, "side2=$(x.side2) ")
    else
      println(io, "side2=$(x.side2), ")
      print(io, "side3=$(x.side3) ")
    end
    if !(isnothing(x.exParms))
      print(io, "exParms=$(x.exParms), ")
    end
    print(io, ")")
  end
end

# helper
function toString(o::TrafoTyp)::String
  if o == Ratio
    return "Ratio"
  elseif o == PhaseShifter
    return "PhaseShifter"
  elseif o == PhaseTapChanger
    return "PhaseTapChanger"
  else
    return "UnknownT"
  end
end
