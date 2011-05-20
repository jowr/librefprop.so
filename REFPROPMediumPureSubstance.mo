within MediaTwoPhaseMixture;
package REFPROPMediumPureSubstance
  "Two Phase one component medium whose property functions are supplied by a wrapper for the refprop.dll"

extends Modelica.Media.Interfaces.PartialTwoPhaseMedium(
    mediumName="REFPROP Medium",
    final singleState=false,
    fluidConstants=rpConstants);
//"mediumName is being checked for consistency at flowports"

constant Boolean debugmode = false;

constant String explicitVars = "ph"
    "set of Variables the model is explicit for";

redeclare record extends SaturationProperties
  MassFraction X[nX] "Mass fractions";
end SaturationProperties;

redeclare function extends saturationTemperature
  extends Modelica.Icons.Function;
  input MassFraction X[:]=reference_X "fluid composition as mass fractions";
algorithm
    T := getSatProp_REFPROP_check("T", "p", fluidnames,p,X);
end saturationTemperature;

final constant String fluidnames= substanceNames[1];

  constant FluidConstants[nS] rpConstants(
       each chemicalFormula = "REFPROP Medium",
       each structureFormula="REFPROP Medium",
       each casRegistryNumber="007",
       each iupacName="REFPROP Medium",
       each molarMass=0.1,
       each criticalTemperature = 600,
       each criticalPressure = 300e5,
       each criticalMolarVolume = 1,
       each acentricFactor = 1,
       each triplePointTemperature = 273.15,
       each triplePointPressure = 1e5,
       each meltingPoint = 1,
       each normalBoilingPoint = 1,
       each dipoleMoment = 1) "TODO wahre Werte einsetzen";

redeclare record extends ThermodynamicState
    "a selection of variables that uniquely defines the thermodynamic state"
  AbsolutePressure p "Absolute pressure of medium";
  Temperature T "Temperature of medium";
  MassFraction X[nX] "Composition (Mass fractions  in kg/kg)";
  MolarMass MM "Molar Mass of the whole mixture";
  Density d(start=300) "density";
  Density d_l(start=300) "density liquid phase";
  Density d_g(start=300) "density gas phase";
  Real q "vapor quality on a mass basis [mass vapor/total mass]";
  SpecificEnergy u "Specific energy";
  SpecificEnthalpy h "Specific enthalpy";
  SpecificEntropy s "Specific entropy";
  Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp;
  Modelica.SIunits.SpecificHeatCapacityAtConstantVolume cv;
  VelocityOfSound c;
  MolarMass MM_l "Molar Mass of liquid phase";
  MolarMass MM_g "Molar Mass of gas phase";
  MassFraction X_l[nX] "Composition of liquid phase (Mass fractions  in kg/kg)";
  MassFraction X_g[nX] "Composition of gas phase (Mass fractions  in kg/kg)";
//  Real GVF "Gas Void Fraction";
end ThermodynamicState;

  redeclare model extends BaseProperties
    "Base properties of mediumsome state variables are calculated in setState and then again directly in order to make automatic inversion possible"

    Modelica.SIunits.SpecificEntropy s;
    SaturationProperties sat "Saturation properties at the medium pressure";
  equation
    u = state.u "h - p/d";
    MM = state.MM;
    R  = Modelica.Constants.R/MM;

  //ph-explicit
  if explicitVars=="ph" or explicitVars=="hp" then
    state = setState_phX(p,h,X,0,fluidnames);
    T = temperature_phX(p,h,X);
  //  T = state.T "double calculation, but necessary if s is given";

    s = specificEntropy_phX(p,h,X)
        "state.s double calculation, but necessary if s is given";
    d = density_phX(p,h,X)
        "state.d double calculation, but necessary if d is given";
  elseif explicitVars=="pT" or explicitVars=="Tp" then
  //pT-explicit
    state = setState_pTX(p,T,X,0,fluidnames);
    h = specificEnthalpy_pTX(p,T,X)
        "double calculation, but necessary if s is given";
    s = specificEntropy_pTX(p,T,X)
        "state.s double calculation, but necessary if s is given";
    d = density_pTX(p,T,X)
        "state.d double calculation, but necessary if d is given";
  elseif explicitVars=="dT" or explicitVars=="Td" then
    //Td-explicit
    state = setState_dTX(d,T,X,0,fluidnames);
    h = specificEnthalpy_dTX(d,T,X)
        "double calculation, but necessary if s is given";
    s = specificEntropy_dTX(d,T,X)
        "state.s double calculation, but necessary if s is given";
    p = pressure_dTX(d,T,X)
        "state.d double calculation, but necessary if d is given";
  elseif explicitVars=="ps" or explicitVars=="ps" then
    state = setState_psX(p,s,X,0,fluidnames);
    T = temperature_psX(p,s,X);
    h = specificEnthalpy_psX(p,s,X);
    d = density_psX(p,s,X);
  elseif explicitVars=="pd" or explicitVars=="pd" then
    state = setState_pdX(p,d,X,0,fluidnames);
    T = temperature_pdX(p,d,X);
    h = specificEnthalpy_pdX(p,d,X);
    s = specificEntropy_pdX(p,d,X);
  elseif explicitVars=="hT" or explicitVars=="Th" then
    state = setState_ThX(T,h,X,0,fluidnames);
    p = pressure_ThX(T,h,X);
    s = specificEntropy_ThX(T,h,X);
    d = density_ThX(T,h,X);
  elseif explicitVars=="sT" or explicitVars=="Ts" then
    state = setState_TsX(T,s,X,0,fluidnames);
    p = pressure_TsX(T,s,X);
    h = specificEnthalpy_TsX(T,s,X);
    d = density_TsX(T,s,X);
  elseif explicitVars=="hd" or explicitVars=="hd" then
    state = setState_hdX(h,d,X,0,fluidnames);
    p = pressure_hdX(h,d,X);
    s = specificEntropy_hdX(h,d,X);
    T = temperature_hdX(h,d,X);
  elseif explicitVars=="hs" or explicitVars=="sh" then
    state = setState_hsX(h,s,X,0,fluidnames);
    p = pressure_hsX(h,s,X);
    T = temperature_hsX(h,s,X);
    d = density_hsX(h,s,X);
  elseif explicitVars=="sd" or explicitVars=="ds" then
    state = setState_dsX(d,s,X,0,fluidnames);
    p = pressure_dsX(d,s,X);
    h = specificEnthalpy_dsX(d,s,X);
    T = temperature_dsX(d,s,X);
  end if;

    sat.psat = p;
    sat.Tsat = saturationTemperature(p,X);
    sat.X = X;
   annotation (Documentation(info="
 <html>
 The baseproperties model is explicit for one set of 2 variables, which can be chosen to be ph, pT, ps, pd, Th, dT, Ts, hd, hs, ds (set explicitVars when calling this package or in package).<br/>
 That means, that if only one of these variables is explicitly given, the other one is calculated by inverting its property function.<br/>
 Then alle state variables are calculated using the corresponding setstate_XX function.<br/>
 In order to avoid numerical inversion by the solver, 3 state variables are set explicitly using their respective property function, which has its inverses defined.<br/>
 Example: So for p and h as explicit variables a state given by p and T is calculated by first calculating h with specificEnthalpy_pTX (inverse function of temperature_phX), 
 then calculating the other variables using setState_phX. s and d, however, are then calculated, although they are already known in the state variable.<br/>
 Knowing this, the baseproperty model can be adapted to your calculation needs to decrease computation time:
 <ul>
 <li>Choose the explicitVars to the combination occurring most often in your model. (The combination dT might be favorable, because it is used by REFPROP's internal algorithm.)</li>
 <li>if you are sure, that it won't be needed, replace explicit calculation of T/s/d/h with definition as state (commented line)</li>
 </ul>
 </html>"));
  end BaseProperties;

  function StrJoin "Converts an Array of Strings into a string separated by |"
    input String[:] s_in;
    input String delimiter;
    output String s_out;
  algorithm
    s_out :=s_in[1];
    for i in 2:size(s_in,1) loop
      s_out :=s_out + delimiter + s_in[i];
    end for;
  end StrJoin;

  partial function partialREFPROP "Declaration of array props"
  //used by getSatProp_REFPROP_check() and getProp_REFPROP_check()
    extends Modelica.Icons.Function;
  protected
     Real[16+2*nX] props;
     String errormsg=StrJoin(fill("xxxx",64),"")
      "Allocating memory, string will be written by C function, doesn't work for strings longer than 40 bytes";
  end partialREFPROP;

  function getSatProp_REFPROP_check
    "wrapper for getSatProp_REFPROP returning 1 property value with error check"
    extends partialREFPROP;
     input String what2calc;
     input String statevar;
     input String fluidnames;
    //     input Real[:] props;
     input Real statevarval;
     input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
  //   input String errormsg;
     output Real val;
  algorithm
     assert(size(X,1)>0,"The mass fraction vector must have at least 1 element.");
     val :=getSatProp_REFPROP(what2calc,statevar,fluidnames,props,statevarval,X,errormsg)
      "just passing through";
  //Error string decoding in wrapper-c-function
     assert(props[1]==0 or props[1]==141,"Errorcode "+String(props[1])+" in REFPROP wrapper function:\n"+errormsg +"\n");
    if props[1]==141 then
      Modelica.Utilities.Streams.print("Saturation properties cannot be calculated, because P > p_crit!...");
      val :=-999;
    end if;
  end getSatProp_REFPROP_check;

  function getSatProp_REFPROP
    "calls C function with property identifier & returns single property"
     input String what2calc;
     input String statevar;
     input String fluidnames;
     input Real[:] props;
     input Real statevarval;
     input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
     input String errormsg;
     output Real val;

   external "C" val=  satprops_REFPROP(what2calc, statevar, fluidnames, props, statevarval, X, REFPROP_PATH, errormsg);

   annotation (Include="#include <refprop_wrapper.h>", Library="REFPROP_wrapper");
  end getSatProp_REFPROP;

redeclare function extends saturationPressure
  extends Modelica.Icons.Function;
algorithm
    p := getSatProp_REFPROP_check("p", "T", fluidnames,T,X);
end saturationPressure;

  function getProp_REFPROP_check
    "wrapper for getProp_REFPROP returning 1 property value with error check"
    extends partialREFPROP;
      input String what2calc;
      input String statevars;
      input String fluidnames;
      input Real statevar1;
      input Real statevar2;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
      output Real val;
  algorithm
  //  Modelica.Utilities.Streams.print("X:"+String(size(X,1)));
     assert(size(X,1)>0,"The mass fraction vector must have at least 1 element.");

     val :=getProp_REFPROP(what2calc,statevars,fluidnames,props,statevar1,statevar2,X,phase,errormsg)
      "just passing through";

     assert(props[1]==0,"Errorcode "+String(props[1])+" in REFPROP wrapper function:\n"+errormsg +"\n");

  end getProp_REFPROP_check;

  function getProp_REFPROP
    "calls C function with property identifier & returns single property"
      input String what2calc;
      input String statevars;
      input String fluidnames;
      input Real[:] props;
      input Real statevar1;
      input Real statevar2;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
      input String errormsg;
      output Real val;

  /*  //  external "C" rho=density(fluidnames, p,T, "d:\\Programme\\REFPROP\\");
 //    external "C" rho = density(fluidnames, p,T, X, "d:\\Programme\\REFPROP\\");

 /*  Modelica.SIunits.MoleFraction[:] Y=MassFraction2MoleFraction(X,MM);* /
 external "C" d = density(fluidnames, p,T, X, REFPROP_PATH);
  annotation (Include="#include <refprop_density_mix.h>", Library="REFPROP_density_mix");
*/
     external "C" val=  props_REFPROP(what2calc, statevars, fluidnames, props, statevar1, statevar2, X, phase, REFPROP_PATH, errormsg);

  annotation (Include="#include <refprop_wrapper.h>", Library="REFPROP_wrapper");
  end getProp_REFPROP;

  function setState "Calculates medium properties"
    extends partialREFPROP;
    input String statevars;
    input Real statevar1;
    input Real statevar2;
    input Modelica.SIunits.MassFraction X[:]=reference_X "Mass fractions";
    input FixedPhase phase "2 for two-phase, 1 for one-phase, 0 if not known";
    input String fluidnames;
    output ThermodynamicState state "thermodynamic state record";
  //  Real[:] props=getProps_REFPROP_check(statevars, fluidnames,statevar1, statevar2, X, phase);
  /*protected 
  Real[16+2*nX] props;
  String errormsg=StrJoin(fill("xxxx",64),"") 
    "Allocating memory, string will be written by C function";*/

  algorithm
    assert(size(X,1)>0,"The mass fraction vector must have at least 1 element.");
    getProp_REFPROP("",statevars,fluidnames,props,statevar1,statevar2,X,phase,errormsg);
    assert(props[1]==0,"Error in REFPROP wrapper function: "+errormsg +"\n");

    state := ThermodynamicState(  p= props[2],
                                T= props[3],
                                X= X,
                                MM= props[4],
                                d=props[5],
                                d_l=props[6],
                                d_g=props[7],
                                q=props[8],
                                u=props[9],
                                h=props[10],
                                s=props[11],
                                cv=props[12],
                                cp=props[13],
                                c=props[14],
                                MM_l=props[15],
                                MM_g=props[16],
                                X_l=props[17:16+nX],
                                X_g=props[17+nX:16+2*nX],
                                phase=0);

  end setState;

redeclare function extends dewEnthalpy "dew curve specific enthalpy"
  extends Modelica.Icons.Function;
algorithm
    hv := getProp_REFPROP_check("h", "pq", fluidnames, sat.psat,1,sat.X,1);
end dewEnthalpy;

  redeclare function extends dewEntropy "dew curve specific entropy of water"
    extends Modelica.Icons.Function;
  algorithm
    sv := getProp_REFPROP_check("s", "pq", fluidnames, sat.psat,1,sat.X,1);
  end dewEntropy;

  redeclare function extends dewDensity "dew curve specific density of water"
    extends Modelica.Icons.Function;
  algorithm
    dv := getProp_REFPROP_check("d", "pq", fluidnames, sat.psat,1,sat.X,1);
  end dewDensity;

  redeclare function extends bubbleEnthalpy
    "boiling curve specific enthalpy of water"
    extends Modelica.Icons.Function;
  algorithm
    hl := getProp_REFPROP_check("h", "pq", fluidnames, sat.psat,0,sat.X,1);
  end bubbleEnthalpy;

  redeclare function extends bubbleEntropy
    "boiling curve specific entropy of water"
    extends Modelica.Icons.Function;
  algorithm
    sl := getProp_REFPROP_check("s", "pq", fluidnames, sat.psat,0,sat.X,1);
  //  sl := getSatProp_REFPROP_check("s", "p", fluidnames, sat.psat,sat.X);

  end bubbleEntropy;

  redeclare function extends bubbleDensity
    "boiling curve specific density of water"
    extends Modelica.Icons.Function;
  algorithm
      dl := getProp_REFPROP_check("d", "pq", fluidnames, sat.psat,0,sat.X,1);
  end bubbleDensity;

redeclare replaceable partial function extends molarMass
    "Return the molar mass of the medium"
  extends Modelica.Icons.Function;
algorithm
/*    MM:=getProp_REFPROP("M", "", fluidnames,0,0,state.X,phase);
    assert(props[1]<size(errorstrings,1) and props[1]>=0 and (props[1]==0 or errorstrings[integer(props[1])]<>""),
      "Error in REFPROP wrapper function: Unknown error code ("+String(props[1])+").\n"+errormsg);
    assert(props[1]==0,"Error in REFPROP wrapper function: "+errormsg +"\n"+ errorstrings[integer(props[1])]);
//    Modelica.Utilities.Streams.print(errormsg);*/
  MM:=state.MM;
end molarMass;

redeclare replaceable partial function extends setState_phX
    "Calculates medium properties from p,h,X"
      input String fluidnames;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_phX...");
  end if;
  state := setState("ph",p,h,X,phase,fluidnames);
end setState_phX;

   redeclare function density_phX "calls REFPROP-Wrapper, returns density"
   extends Modelica.Icons.Function;
     input Modelica.SIunits.Pressure p;
     input Modelica.SIunits.SpecificEnthalpy h;
     input MassFraction X[:]=reference_X
      "composition defined by mass fractions";
     input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
     output Modelica.SIunits.Density d;
   algorithm
     if debugmode then
       Modelica.Utilities.Streams.print("Run density_phX...");
     end if;
       d :=getProp_REFPROP_check("d", "ph", fluidnames,p,h,X,phase);
     annotation(LateInline=true,inverse(h=specificEnthalpy_pdX(p,d,X,phase),
                                        p=pressure_hdX(h,d,X,phase)));
   end density_phX;

   redeclare function temperature_phX
    "calls REFPROP-Wrapper, returns temperature"
   extends Modelica.Icons.Function;
       input Modelica.SIunits.Pressure p;
       input Modelica.SIunits.SpecificEnthalpy h;
       input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
       input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
     output Modelica.SIunits.Temperature T;
   algorithm
     if debugmode then
       Modelica.Utilities.Streams.print("Run temperature_phX("+String(p)+","+String(h)+",X)");
     end if;
       T :=getProp_REFPROP_check("T", "ph", fluidnames,p,h,X,phase);
   //    Modelica.Utilities.Streams.print(errormsg);
   //    Modelica.Utilities.Streams.print("Run temperature_phX...");
     annotation(LateInline=true,inverse(h=specificEnthalpy_pTX(p,T,X,phase),
                                        p=pressure_ThX(T,h,X,phase)));
   end temperature_phX;

  function specificEntropy_phX
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p;
    input Modelica.SIunits.SpecificEnthalpy h;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
  //  input String fluidnames;
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.SpecificEntropy s;
  /*protected 
   Real[14+2*nX] props;
   String errormsg=StrJoin(fill("xxxx",10),"");*/
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run specificEntropy_phX...");
    end if;
      // p="+String(p)+",h="+String(h)+", X={"+String(X[1])+","+String(X[2])+"}");
      s:=getProp_REFPROP_check("s", "ph", fluidnames,p,h,X,phase);
    annotation(LateInline=true,inverse(h=specificEnthalpy_psX(p,s,X,phase),
                                       p=pressure_hsX(h,s,X,phase)));
  end specificEntropy_phX;

redeclare replaceable partial function extends setState_pTX
      input String fluidnames;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_pTX...");
  end if;
  state := setState("pT",p,T,X,phase,fluidnames);
end setState_pTX;

   redeclare function density_pTX "calls REFPROP-Wrapper, returns density"
   extends Modelica.Icons.Function;
    //    input String fluidnames;
       input Modelica.SIunits.Pressure p;
       input Modelica.SIunits.Temperature T;
       input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
       input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
     output Modelica.SIunits.Density d;

   algorithm
     if debugmode then
       Modelica.Utilities.Streams.print("Run density_pTX...");
     end if;
       d :=getProp_REFPROP_check("d", "pT", fluidnames,p,T,X,phase);
     annotation(LateInline=true,inverse(T=temperature_pdX(p,d,X,phase),
                                        p=pressure_dTX(d,T,X,phase)));
   end density_pTX;

  redeclare function specificEnthalpy_pTX
    "calls REFPROP-Wrapper, returns specific enthalpy"
    //does not extend existing function from PartialMedium because there the algorithm is already defined
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p;
    input Modelica.SIunits.Temp_K T;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
  //  input String fluidnames;
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.SpecificEnthalpy h;
  /*protected 
   Real[14+2*nX] props;
   String errormsg=StrJoin(fill("xxxx",10),"");*/
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run specificEnthalpy_pTX...");
    end if;
      // p="+String(p)+",T="+String(T)+", X={"+String(X[1])+","+String(X[2])+"}");
      h :=getProp_REFPROP_check("h", "pT", fluidnames,p,T,X,phase);
    annotation(LateInline=true,inverse(T=temperature_phX(p,h,X,phase),
                                       p=pressure_ThX(T,h,X,phase)));
  end specificEnthalpy_pTX;

  redeclare function specificEntropy_pTX
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p;
    input Modelica.SIunits.Temp_K T;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
  //  input String fluidnames;
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.SpecificEntropy s;
  /*protected 
   Real[14+2*nX] props;
   String errormsg=StrJoin(fill("xxxx",10),"");*/
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run specificEntropy_pTX...");
    end if;
      s:=getProp_REFPROP_check("s", "pT", fluidnames,p,T,X,phase);
     annotation(LateInline=true,inverse(T=temperature_psX(p,s,X,phase),
                                       p=pressure_TsX(T,s,X,phase)));
  end specificEntropy_pTX;

redeclare replaceable partial function extends setState_psX
    "Calculates medium properties from p,s,X"
      input String fluidnames;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_psX...");
  end if;
  state := setState("ps",p,s,X,phase,fluidnames);
end setState_psX;

   redeclare function temperature_psX
    "calls REFPROP-Wrapper, returns temperature"
   extends Modelica.Icons.Function;
       input Modelica.SIunits.Pressure p;
       input Modelica.SIunits.SpecificEntropy s;
       input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
       input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
     output Modelica.SIunits.Temperature T;
   algorithm
     if debugmode then
       Modelica.Utilities.Streams.print("Run temperature_psX...");
     end if;
       T :=getProp_REFPROP_check("T", "ps", fluidnames,p,s,X,phase);
     annotation(LateInline=true,inverse(s=specificEntropy_pTX(p,T,X,phase),
                                        p=pressure_TsX(T,s,X,phase)));
   end temperature_psX;

  redeclare function specificEnthalpy_psX
    "calls REFPROP-Wrapper, returns specific enthalpy"
    //does not extend existing function from PartialMedium because there the algorithm is already defined
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p;
    input Modelica.SIunits.SpecificEntropy s;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
  //  input String fluidnames;
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.SpecificEnthalpy h;
  /*protected 
   Real[14+2*nX] props;
   String errormsg=StrJoin(fill("xxxx",10),"");*/
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run specificEnthalpy_psX...");
    end if;
      h :=getProp_REFPROP_check("h", "ps", fluidnames,p,s,X,phase);
    annotation(LateInline=true,inverse(s=specificEntropy_phX(p,h,X,phase),
                                       p=pressure_hsX(h,s,X,phase)));
  end specificEnthalpy_psX;

   redeclare function density_psX "calls REFPROP-Wrapper, returns density"
   extends Modelica.Icons.Function;
       input Modelica.SIunits.Pressure p;
       input Modelica.SIunits.SpecificEntropy s;
       input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
       input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
     output Modelica.SIunits.Density d;
   algorithm
     if debugmode then
       Modelica.Utilities.Streams.print("Run density_psX...");
     end if;
       d :=getProp_REFPROP_check("d", "ps", fluidnames,p,s,X,phase);
   //    Modelica.Utilities.Streams.print(errormsg);
     annotation(LateInline=true,inverse(s=specificEntropy_pdX(p,d,X,phase),
                                        p=pressure_dsX(d,s,X,phase)));
   end density_psX;

function setState_pdX "Calculates medium properties from p,d,X"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Density d "Density";
  input MassFraction X[:]=reference_X "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input String fluidnames;
  output ThermodynamicState state "thermodynamic state record";
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_pdX...");
  end if;
  state := setState("pd",p,d,X,phase,fluidnames);
end setState_pdX;

  function temperature_pdX "calls REFPROP-Wrapper, returns temperature"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p;
      input Modelica.SIunits.Density d;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Temperature T;
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run temperature_psX...");
    end if;
      T :=getProp_REFPROP_check("T", "pd", fluidnames,p,d,X,phase);
    annotation(LateInline=true,inverse(d=density_pTX(p,T,X,phase),
                                       p=pressure_dTX(d,T,X,phase)));
  end temperature_pdX;

  function specificEnthalpy_pdX
    "calls REFPROP-Wrapper, returns specific enthalpy"
    //does not extend existing function from PartialMedium because there the algorithm is already defined
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p;
    input Modelica.SIunits.Density d;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
  //  input String fluidnames;
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.SpecificEnthalpy h;
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run specificEnthalpy_psX...");
    end if;
      h :=getProp_REFPROP_check("h", "pd", fluidnames,p,d,X,phase);
    annotation(LateInline=true,inverse(d = density_phX(p,h,X,phase),
                                       p=pressure_hdX(h,d,X,phase)));
  end specificEnthalpy_pdX;

  function specificEntropy_pdX
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p;
    input Modelica.SIunits.Density d;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
  //  input String fluidnames;
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.SpecificEntropy s;
  /*protected 
   Real[14+2*nX] props;
   String errormsg=StrJoin(fill("xxxx",10),"");*/
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run specificEntropy_pdX...");
    end if;
      s:=getProp_REFPROP_check("s", "pd", fluidnames,p,d,X,phase);
    annotation(LateInline=true,inverse(d = density_psX(p,s,X,phase),
                                       p=pressure_dsX(d,s,X,phase)));
  end specificEntropy_pdX;

function setState_ThX "Calculates medium properties from T,h,X"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  input SpecificEnthalpy h "Enthalpy";
  input MassFraction X[:]=reference_X "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input String fluidnames;
  output ThermodynamicState state "thermodynamic state record";
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_ThX...");
  end if;
  state := setState("Th",T,h,X,phase,fluidnames);
end setState_ThX;

  function pressure_ThX "calls REFPROP-Wrapper, returns pressure"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.Temperature T;
      input Modelica.SIunits.SpecificEnthalpy h;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Pressure p;
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run temperature_psX...");
    end if;
      p :=getProp_REFPROP_check("p", "Th", fluidnames,T,h,X,phase);
    annotation(LateInline=true,inverse(h=specificEnthalpy_pTX(p,T,X,phase),
                                       T=temperature_phX(p,h,X,phase)));
  end pressure_ThX;

  function density_ThX "calls REFPROP-Wrapper, returns density"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.Temperature T;
      input Modelica.SIunits.SpecificEnthalpy h;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Density d;
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run density_ThX...");
    end if;
      d :=getProp_REFPROP_check("d", "Th", fluidnames,T,h,X,phase);
  //    Modelica.Utilities.Streams.print(errormsg);
    annotation(LateInline=true,inverse(h=specificEnthalpy_dTX(d,T,X,phase),
                                       T=temperature_hdX(h,d,X,phase)));
  end density_ThX;

  function specificEntropy_ThX
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Temperature T;
    input Modelica.SIunits.SpecificEnthalpy h;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
  //  input String fluidnames;
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.SpecificEntropy s;
  /*protected 
   Real[14+2*nX] props;
   String errormsg=StrJoin(fill("xxxx",10),"");*/
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run specificEntropy_ThX...");
    end if;
      s:=getProp_REFPROP_check("s", "Th", fluidnames,T,h,X,phase);
    annotation(LateInline=true,inverse(h = specificEnthalpy_TsX(T,s,X,phase),
                                       T=temperature_hsX(h,s,X,phase)));
  end specificEntropy_ThX;

redeclare replaceable partial function extends setState_dTX
      input String fluidnames;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_dTX...");
  end if;
  state := setState("dT",d,T,X,phase,fluidnames);
end setState_dTX;

  function pressure_dTX "calls REFPROP-Wrapper, returns pressure"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d;
      input Modelica.SIunits.Temperature T;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Pressure p;
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run pressure_dTX...");
    end if;
      p :=getProp_REFPROP_check("p", "dT", fluidnames,d,T,X,phase);
    annotation(LateInline=true,inverse(d = density_pTX(p,T,X,phase),
                                       T=temperature_pdX(p,d,X,phase)));
  end pressure_dTX;

  function specificEnthalpy_dTX
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Density d;
    input Modelica.SIunits.Temperature T;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
  //  input String fluidnames;
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.SpecificEnthalpy h;
  /*protected 
   Real[14+2*nX] props;
   String errormsg=StrJoin(fill("xxxx",10),"");*/
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run specificEnthalpy_dTX...");
    end if;
      h :=getProp_REFPROP_check("h", "dT", fluidnames,d,T,X,phase);
    annotation(LateInline=true,inverse(d=density_ThX(T,h,X,phase),
                                       T=temperature_hdX(h,d,X,phase)));
  end specificEnthalpy_dTX;

  function specificEntropy_dTX
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Density d;
    input Modelica.SIunits.Temperature T;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
  //  input String fluidnames;
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.SpecificEntropy s;
  /*protected 
   Real[14+2*nX] props;
   String errormsg=StrJoin(fill("xxxx",10),"");*/
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run specificEntropy_dTX...");
    end if;
      s:=getProp_REFPROP_check("s", "dT", fluidnames,d,T,X,phase);
    annotation(LateInline=true,inverse(d = density_TsX(T,s,X,phase),
                                       T=temperature_dsX(d,s,X,phase)));
  end specificEntropy_dTX;

function setState_TsX "Calculates medium properties from T,s,X"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  input SpecificEntropy s "Entropy";
  input MassFraction X[:]=reference_X "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input String fluidnames;
  output ThermodynamicState state "thermodynamic state record";
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_TsX...");
  end if;
  state := setState("Ts",T,s,X,phase,fluidnames);
end setState_TsX;

  function pressure_TsX "calls REFPROP-Wrapper, returns pressure"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.Temperature T;
      input Modelica.SIunits.SpecificEntropy s;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Pressure p;
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run pressure_TsX...");
    end if;
      p :=getProp_REFPROP_check("p", "Ts", fluidnames,T,s,X,phase);
    annotation(LateInline=true,inverse(s = specificEntropy_pTX(p,T,X,phase),
                                       T=temperature_psX(p,s,X,phase)));
  end pressure_TsX;

  function specificEnthalpy_TsX
    "calls REFPROP-Wrapper, returns specific enthalpy"
    //does not extend existing function from PartialMedium because there the algorithm is already defined
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Temperature T;
    input Modelica.SIunits.SpecificEntropy s;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
  //  input String fluidnames;
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.SpecificEnthalpy h;
  /*protected 
   Real[14+2*nX] props;
   String errormsg=StrJoin(fill("xxxx",10),"");*/
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run specificEnthalpy_TsX...");
    end if;
      h :=getProp_REFPROP_check("h", "Ts", fluidnames,T,s,X,phase);
    annotation(LateInline=true,inverse(s = specificEntropy_ThX(T,h,X,phase),
                                       T=temperature_hsX(h,s,X,phase)));
  end specificEnthalpy_TsX;

  function density_TsX "calls REFPROP-Wrapper, returns density"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.Temperature T;
      input Modelica.SIunits.SpecificEntropy s;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Density d;
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run density_TsX...");
    end if;
      d :=getProp_REFPROP_check("d", "Ts", fluidnames,T,s,X,phase);
    annotation(LateInline=true,inverse(s=specificEntropy_dTX(d,T,X,phase),
                                       T=temperature_dsX(d,s,X,phase)));
  end density_TsX;

function setState_hdX "Calculates medium properties from h,d,X"
  extends Modelica.Icons.Function;
  input SpecificEnthalpy h "Enthalpy";
  input Density d "Temperature";
  input MassFraction X[:]=reference_X "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input String fluidnames;
  output ThermodynamicState state "thermodynamic state record";
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_hdX...");
  end if;
  state := setState("hd",h,d,X,phase,fluidnames);
end setState_hdX;

 function pressure_hdX "calls REFPROP-Wrapper, returns pressure"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.SpecificEnthalpy h;
      input Modelica.SIunits.Density d;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Pressure p;
 algorithm
   if debugmode then
     Modelica.Utilities.Streams.print("Run pressure_hdX...");
   end if;
      p :=getProp_REFPROP_check("p", "hd", fluidnames,h,d,X,phase);
    annotation(LateInline=true,inverse(d=density_phX(p,h,X,phase),
                                       h=specificEnthalpy_pdX(p,d,X,phase)));
 end pressure_hdX;

  function temperature_hdX "calls REFPROP-Wrapper, returns temperature"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.SpecificEnthalpy h;
      input Modelica.SIunits.Density d;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Temperature T;
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run temperature_hdX("+String(h)+","+String(d)+",X)");
    end if;
      T :=getProp_REFPROP_check("T", "hd", fluidnames,h,d,X,phase);
    annotation(LateInline=true,inverse(d=density_ThX(T,h,X,phase),
                                       h=specificEnthalpy_dTX(d,T,X,phase)));
  end temperature_hdX;

  function specificEntropy_hdX
    extends Modelica.Icons.Function;
      input Modelica.SIunits.SpecificEnthalpy h;
      input Modelica.SIunits.Density d;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.SpecificEntropy s;
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run specificEntropy_hdX...");
    end if;
      s:=getProp_REFPROP_check("s", "hd", fluidnames,h,d,X,phase);
    annotation(LateInline=true,inverse(d=density_hsX(h,s,X,phase),
                                       h=specificEnthalpy_dsX(d,s,X,phase)));
  end specificEntropy_hdX;

function setState_hsX "Calculates medium properties from h,s,X"
  extends Modelica.Icons.Function;
  input SpecificEnthalpy h "Enthalpy";
  input SpecificEntropy s "Entropy";
  input MassFraction X[:]=reference_X "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input String fluidnames;
  output ThermodynamicState state "thermodynamic state record";
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_hsX...");
  end if;
  state := setState("hs",h,s,X,phase,fluidnames);
end setState_hsX;

function pressure_hsX "calls REFPROP-Wrapper, returns pressure"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.SpecificEnthalpy h;
      input Modelica.SIunits.SpecificEntropy s;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Pressure p;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Run pressure_hsX...");
  end if;
      p :=getProp_REFPROP_check("p", "hs", fluidnames,h,s,X,phase);
    annotation(LateInline=true,inverse(s=specificEntropy_phX(p,h,X,phase),
                                       h=specificEnthalpy_psX(p,s,X,phase)));
end pressure_hsX;

  function temperature_hsX "calls REFPROP-Wrapper, returns temperature"
  extends Modelica.Icons.Function;
    input Modelica.SIunits.SpecificEnthalpy h;
    input Modelica.SIunits.SpecificEntropy s;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Temperature T;
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run temperature_phX("+String(h)+","+String(s)+",X)");
    end if;
      T :=getProp_REFPROP_check("T", "hs", fluidnames,h,s,X,phase);
    annotation(LateInline=true,inverse(s=specificEntropy_ThX(T,h,X,phase),
                                       h=specificEnthalpy_TsX(T,s,X,phase)));
  end temperature_hsX;

  function density_hsX "calls REFPROP-Wrapper, returns density"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.SpecificEnthalpy h;
      input Modelica.SIunits.SpecificEntropy s;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Density d;
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run density_hsX...");
    end if;
      d :=getProp_REFPROP_check("d", "hs", fluidnames,h,s,X,phase);
    annotation(LateInline=true,inverse(s=specificEntropy_hdX(h,d,X,phase),
                                       h=specificEnthalpy_dsX(d,s,X,phase)));
  end density_hsX;

function setState_dsX "Calculates medium properties from d,s,X"
  extends Modelica.Icons.Function;
  input Density d "Temperature";
  input SpecificEntropy s "Entropy";
  input MassFraction X[:]=reference_X "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input String fluidnames;
  output ThermodynamicState state "thermodynamic state record";
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_dsX...");
  end if;
  state := setState("ds",d,s,X,phase,fluidnames);
end setState_dsX;

  function pressure_dsX "calls REFPROP-Wrapper, returns pressure"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d;
      input Modelica.SIunits.SpecificEntropy s;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Pressure p;
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run pressure_dsX...");
    end if;
      p :=getProp_REFPROP_check("p", "ds", fluidnames,d,s,X,phase);
    annotation(LateInline=true,inverse(s=specificEntropy_pdX(p,d,X,phase),
                                       d=density_psX(p,s,X,phase)));
  end pressure_dsX;

  function temperature_dsX "calls REFPROP-Wrapper, returns temperature"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d;
      input Modelica.SIunits.SpecificEntropy s;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Temperature T;
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run temperature_dsX("+String(d)+","+String(s)+",X)");
    end if;
      T :=getProp_REFPROP_check("T", "ds", fluidnames,d,s,X,phase);
    annotation(LateInline=true,inverse(s=specificEntropy_dTX(d,T,X,phase),
                                       d=density_TsX(T,s,X,phase)));
  end temperature_dsX;

  function specificEnthalpy_dsX
    "calls REFPROP-Wrapper, returns specific enthalpy"
    //does not extend existing function from PartialMedium because there the algorithm is already defined
    extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d;
      input Modelica.SIunits.SpecificEntropy s;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
  //  input String fluidnames;
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.SpecificEnthalpy h;
  /*protected 
   Real[14+2*nX] props;
   String errormsg=StrJoin(fill("xxxx",10),"");*/
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run specificEnthalpy_dsX...");
    end if;
      h :=getProp_REFPROP_check("h", "ds", fluidnames,d,s,X,phase);
    annotation(LateInline=true,inverse(s=specificEntropy_hdX(h,d,X,phase),
                                       d=density_hsX(h,s,X,phase)));
  end specificEnthalpy_dsX;

  function setState_pqX "Calculates medium properties from p,q,X"
    extends Modelica.Icons.Function;
    input Modelica.SIunits.AbsolutePressure p "Pressure";
    input Modelica.SIunits.MassFraction q "quality (vapor mass fraction)";
    input Modelica.SIunits.MassFraction X[:]=reference_X "Mass fractions";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input String fluidnames;
    output ThermodynamicState state "thermodynamic state record";
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Running setState_pqX...");
    end if;
    state := setState("pq",p,q,X,phase,fluidnames);
  end setState_pqX;

  function density_pqX "calls REFPROP-Wrapper, returns specific density"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p;
      input Real q;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Density d;
  /*  annotation(LateInline=true,inverse(p=pressure_dqX(d,q,X,phase),
                                     q=quality_pdX(p,d,X,phase)));*/
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run density_pqX...");
    end if;
      d :=getProp_REFPROP_check("d", "pq", fluidnames,p,q,X,phase);
  end density_pqX;

  function pressure_TqX "calls REFPROP-Wrapper, returns pressure"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.Temperature T;
      input Real q;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Pressure p;
    //T=quality_pTX(p,T,X,phase)
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run pressure_TqX...");
    end if;
      p :=getProp_REFPROP_check("p", "Tq", fluidnames,T,q,X,phase);
    annotation(LateInline=true,inverse(T=temperature_pqX(p,q,X,phase)));
  end pressure_TqX;

  function specificEnthalpy_pqX
    "calls REFPROP-Wrapper, returns specific enthalpy"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p;
      input Real q;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.SpecificEnthalpy h;
  //  annotation(LateInline=true,inverse(p = pressure_hqX(h,q,X,phase),quality_phX(p,h,X,phase)));
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run specificEnthalpy_pqX...");
    end if;
      h :=getProp_REFPROP_check("h", "pq", fluidnames,p,q,X,phase);
  end specificEnthalpy_pqX;

  function specificEntropy_pqX
    "calls REFPROP-Wrapper, returns specific entropy"
  extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p;
      input Real q;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.SpecificEntropy s;
  //  annotation(LateInline=true,inverse(p = pressure_sqX(s,q,X,phase),q=quality_psX(p,s,X,phase));
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run specificEntropy_pqX...");
    end if;
      s :=getProp_REFPROP_check("s", "pq", fluidnames,p,q,X,phase);
  end specificEntropy_pqX;

  function temperature_pqX
  extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p;
      input MassFraction q;
      input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
      input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Temperature T;
  //  annotation(LateInline=true,inverse(p = pressure_TqX(T,q,X,phase),q=quality_pTX(p,T,X,phase));
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Run temperature_phX("+String(p)+","+String(h)+",X)");
  //    Modelica.Utilities.Streams.print("Run temperature_phX...");
    end if;
      T :=getProp_REFPROP_check("T", "pq", fluidnames,p,q,X,phase);
  //    Modelica.Utilities.Streams.print(errormsg);
  end temperature_pqX;

 redeclare function extends specificEnthalpy
    "Return specific enthalpy - seems useless, but good for compatibility between PartialMedium and PartialMixedMediumTwoPhase"
  extends Modelica.Icons.Function;
 /*algorithm 
  h := state.h;*/
 end specificEnthalpy;

 redeclare function extends specificEntropy
    "Return specific entropy  - seems useless, but good for compatibility between PartialMedium and PartialMixedMediumTwoPhase"
 algorithm
  s := state.s;

   annotation (Documentation(info="<html>

</html>"));
 end specificEntropy;

  redeclare replaceable function extends density
    "returns density from state - seems useless, but good for compatibility between PartialMedium and PartialMixedMediumTwoPhase"
  algorithm
    d := state.d;
  end density;

 redeclare function extends pressure
    "Return specific entropy  - seems useless, but good for compatibility between PartialMedium and PartialMixedMediumTwoPhase"
 /*algorithm 
 p := state.p;*/
   annotation (Documentation(info="<html>

</html>"));
 end pressure;

redeclare function extends dynamicViscosity
algorithm
  eta := getProp_REFPROP_check("v", "Td", fluidnames,state.T,state.d,state.X,state.phase);
end dynamicViscosity;

redeclare function extends thermalConductivity
algorithm
  lambda := getProp_REFPROP_check("l", "Td", fluidnames,state.T,state.d,state.X,state.phase);
end thermalConductivity;

constant String REFPROP_PATH = "d:\\Program Files (x86)\\REFPROP\\";

  annotation (Documentation(info="<html>
  <h1>PartialMixtureTwoPhaseMedium</h1>
  This package is the same as REFPROPMedium except for the fact that ist is limited to single substance fluids, 
  so it can be used without a special medium template and is compatible with Modelica.Media.
  It extends the standard template Modelica.Media.Interfaces.PartialTwoPhaseMedium.<br/>   
  <h3>Documentation</h3>
  See the package REFPROPMedium for documentation.

<h3> Created by</h3>
Henning Francke<br/>
Helmholtz Centre Potsdam<br/>
GFZ German Research Centre for Geosciences<br/>
Telegrafenberg, D-14473 Potsdam<br/>
Germany
<p>
<a href=mailto:info@xrg-simulation.de>francke@gfz-potsdam.de</a>
  </html>
"), uses(Modelica(version="3.1")),
              Documentation(info="<html>
<p>
<b>REFPROPMedium</b> is a package that delivers <b>REFPROP</b> data to a model based on and compatible to the Modelica.Media library.
It can be used to model two-phase mixtures of all fluids whose data is delivered with REFPROP.
</p>
<p>
<h2>Installation</h2>
<ul>
  <li>We need access to the refprop.dll (set path with REFPROP_PATH) and to the Fluid-Data directory in the REFPROP directory.</li>
  <li>We need refprop_wrapper.lib in %DYMOLADIR%\\bin\\lib\ and refprop_wrapper.h in %DYMOLADIR%\\source\\</li>
  <li>We need the package PartialMixtureMediumTwoPhase</li>
</ul>
</p>
<h2>Usage</h2>
Create an Instance of REFPROPMedium and pass the components.defines the medium components (medium names are the names of the .fld files in the %REFPROP%\\fluids directory):
<pre>
  package Medium = REFPROPMedium (final substanceNames={\"nitrogen\",\"argon\"});
</pre>
Create an Instance of REFPROPMedium.Baseproperties:
<pre>
  Medium.BaseProperties props;
</pre>
You can then use the Baseproperties model to define the actual medium composition, define the thermodynamic state and calculate the corresponding properties.
<pre>
  props.p = 1e5;
  props.T = 300;
  props.Xi = {.8};
  d = props.d;
</pre>
<p>Any combination of the pressure, temperature, specific enthalpy, specific entropy and density (p,T,h,s,d) can be used to define a 
thermodynamic state. Explicit functions for all combinations exist in REFPROP and likewise in the REFPROPMedium package.
The calculation of all variables of a thermodynamic state, however, is by default done by setState_phX, so p and h have to be 
calculated from the given combination of two variables first. Actually, by doing this REFPROP already calculates all variables 
of the thermodynamic state, but they cannot be used directly. This is a limitation of DYMOLA, as it is not able to invert a function 
returning an array.
You can change the set of variables the property model is explicit for by setting the string variable explicitVars to \"pT\" or \"dT\":
<pre>
package Medium = REFPROPMedium(final substanceNames={\"water\"}, final explicitVars = \"pT\");
</pre>
</p>
<p>All calculated values are returned in SI-Units and are mass based.
</p>

<h2>TODO:</h2>
<ul>
  <li>Calculate bubble/dew entropy/enthalpy with SATP and ThermDLL instead of PQFLSH</li>
  <li>Call Refprop wraper only once instead of four times per solution of props</li>
</ul>
</html>
",
 revisions="<html>

</html>"), uses(Modelica(version="3.1")));
end REFPROPMediumPureSubstance;
