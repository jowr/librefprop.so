within MediaTwoPhaseMixture;
package REFPROPMediumPureSubstance "Two Phase single component two-phase medium whose property functions are supplied by REFPROP (via wrapper for refprop.dll). Extends PartialTwoPhaseMedium."
/*To create this package, REFPROPMedium has been copied and the following things have been changed:
-"extends PartialMixtureTwoPhaseMedium" -> "extends Modelica.Media.Interfaces.PartialTwoPhaseMedium"
-redeclare record SaturationProperties
-added preset X to saturationTemperature() and saturationPressure()
-added s and sat in BaseProperties
-add p,T,X in ThermodynamicState
-for specificEnthalpy_dTX:  redeclare function -> function 
*/


redeclare record extends SaturationProperties
  MassFraction X[nX] "Mass fractions";
end SaturationProperties;


redeclare function extends saturationPressure
//  extends Modelica.Icons.Function;
  input MassFraction X[:]={1} "fluid composition as mass fractions";
algorithm
    p := getSatProp_REFPROP_check("p", "T",T,X);
end saturationPressure;


redeclare function extends saturationTemperature
//  extends Modelica.Icons.Function;
  input MassFraction X[:]={1} "fluid composition as mass fractions";
algorithm
    T := getSatProp_REFPROP_check("T", "p",p,X);
end saturationTemperature;
constant Boolean debugmode = false
  "print messages in functions and in refpropwrapper.lib (to see the latter, start dymosim.exe in command window)";

constant String explicitVars = "ph"
  "set of variables the model is explicit for, may be set to all combinations of p,h,T,d,s,d, REFPROP works internally with dT";
final constant String fluidnames= StrJoin(substanceNames,"|");


extends Modelica.Media.Interfaces.PartialTwoPhaseMedium(
    mediumName="REFPROP Medium",
    final singleState=false,
    fluidConstants=rpConstants);
//"mediumName is being checked for consistency at flowports"

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
       each dipoleMoment = 1);


redeclare record extends ThermodynamicState
  "a selection of variables that uniquely defines the thermodynamic state"
  AbsolutePressure p "Absolute pressure of medium";
  Temperature T "Temperature of medium";
  MassFraction X[nX] "Composition (Mass fractions  in kg/kg)";/**/
  MolarMass MM "Molar Mass of the whole mixture";
  Density d(start=300) "density";
  Density d_l(start=300) "density liquid phase";
  Density d_g(start=300) "density gas phase";
  Real x "vapor quality on a mass basis [mass vapor/total mass]";
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


  redeclare model extends BaseProperties "Base properties of medium"

    Modelica.SIunits.SpecificEntropy s;
    SaturationProperties sat "Saturation properties at the medium pressure";
  equation
    u = state.u "h - p/d";
    MM = state.MM;
    R  = 1 "Modelica.Constants.R/MM";

  //ph-explicit
  if explicitVars=="ph" or explicitVars=="hp" then
    state = setState_phX(p,h,X,0) ",fluidnames)";
    T = temperature_phX(p,h,X)
      "double calculation, but necessary if T is given";
  //  T = state.T "can be used instead";

    s = specificEntropy_phX(p,h,X)
      "double calculation, but necessary if s is given";
  //  s = state.s "can be used instead";

    d = density_phX(p,h,X) "double calculation, but necessary if d is given";
    //d = state.d "can be used instead";
  elseif explicitVars=="pT" or explicitVars=="Tp" then
  //pT-explicit
    state = setState_pTX(p,T,X,0) ",fluidnames)";
    h = specificEnthalpy_pTX(p,T,X)
      "double calculation, but necessary if s is given";
    //h = state.h "can be used instead";

    s = specificEntropy_pTX(p,T,X)
      "state.s double calculation, but necessary if s is given";
  //  s = state.s "can be used instead";

    d = density_pTX(p,T,X)
      "state.d double calculation, but necessary if d is given";
    //d = state.d "can be used instead";
  elseif explicitVars=="dT" or explicitVars=="Td" then
    //Td-explicit
    state = setState_dTX(d,T,X,0) ",fluidnames)";
    h = specificEnthalpy_dTX(d,T,X)
      "double calculation, but necessary if s is given";
    //h = state.h "can be used instead";

    s = specificEntropy_dTX(d,T,X)
      "state.s double calculation, but necessary if s is given";
  //  s = state.s "can be used instead";
    p = pressure_dTX(d,T,X)
      "state.d double calculation, but necessary if d is given";
  //  p = state.p "can be used instead";
  elseif explicitVars=="ps" or explicitVars=="ps" then
    state = setState_psX(p,s,X,0) ",fluidnames)";
    T = temperature_psX(p,s,X);
    h = specificEnthalpy_psX(p,s,X);
    d = density_psX(p,s,X);
  elseif explicitVars=="pd" or explicitVars=="pd" then
    state = setState_pdX(p,d,X,0) ",fluidnames)";
    T = temperature_pdX(p,d,X);
    h = specificEnthalpy_pdX(p,d,X);
    s = specificEntropy_pdX(p,d,X);
  elseif explicitVars=="hT" or explicitVars=="Th" then
    state = setState_ThX(T,h,X,0) ",fluidnames)";
    p = pressure_ThX(T,h,X);
    s = specificEntropy_ThX(T,h,X);
    d = density_ThX(T,h,X);
  elseif explicitVars=="sT" or explicitVars=="Ts" then
    state = setState_TsX(T,s,X,0) ",fluidnames)";
    p = pressure_TsX(T,s,X);
    h = specificEnthalpy_TsX(T,s,X);
    d = density_TsX(T,s,X);
  elseif explicitVars=="hd" or explicitVars=="hd" then
    state = setState_hdX(h,d,X,0) ",fluidnames)";
    p = pressure_hdX(h,d,X);
    s = specificEntropy_hdX(h,d,X);
    T = temperature_hdX(h,d,X);
  elseif explicitVars=="hs" or explicitVars=="sh" then
    state = setState_hsX(h,s,X,0) ",fluidnames)";
    p = pressure_hsX(h,s,X);
    T = temperature_hsX(h,s,X);
    d = density_hsX(h,s,X);
  elseif explicitVars=="sd" or explicitVars=="ds" then
    state = setState_dsX(d,s,X,0) ",fluidnames)";
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
 <li>if you are sure, that it won't be needed, in BaseProperties replace explicit calculation of T/s/d/h with definition as state (commented line)</li>
 </ul>
 </html>"));
  end BaseProperties;









 redeclare function extends specificEntropy
  "Return specific entropy  - seems useless, but good for compatibility between PartialMedium and PartialMixedMediumTwoPhase"
 algorithm
  s := state.s;
 end specificEntropy;


  redeclare replaceable function extends density
  "returns density from state - seems useless, but good for compatibility between PartialMedium and PartialMixedMediumTwoPhase"
  algorithm
    d := state.d;
  end density;


redeclare function extends dewEnthalpy "dew curve specific enthalpy"
  extends Modelica.Icons.Function;
algorithm
    hv := getProp_REFPROP_check("h", "pq", sat.psat,1,sat.X,1);
end dewEnthalpy;


  redeclare function extends dewEntropy "dew curve specific entropy of water"
    extends Modelica.Icons.Function;
  algorithm
    sv := getProp_REFPROP_check("s", "pq", sat.psat,1,sat.X,1);
  end dewEntropy;


  redeclare function extends dewDensity "dew curve specific density of water"
    extends Modelica.Icons.Function;
  algorithm
    dv := getProp_REFPROP_check("d", "pq", sat.psat,1,sat.X,1);
  end dewDensity;


  redeclare function extends bubbleEnthalpy
  "boiling curve specific enthalpy of water"
    extends Modelica.Icons.Function;
  algorithm
    hl := getProp_REFPROP_check("h", "pq", sat.psat,0,sat.X,1);
  end bubbleEnthalpy;


  redeclare function extends bubbleEntropy
  "boiling curve specific entropy of water"
    extends Modelica.Icons.Function;
  algorithm
    sl := getProp_REFPROP_check("s", "pq", sat.psat,0,sat.X,1);
  end bubbleEntropy;


  redeclare function extends bubbleDensity
  "boiling curve specific density of water"
    extends Modelica.Icons.Function;
  algorithm
      dl := getProp_REFPROP_check("d", "pq", sat.psat,0,sat.X,1);
  end bubbleDensity;


redeclare replaceable partial function extends molarMass
  "Return the molar mass of the medium"
  extends Modelica.Icons.Function;
algorithm
  MM:=state.MM;
end molarMass;


redeclare replaceable partial function extends setState_phX
  "Calculates medium properties from p,h,X"
  //    input String fluidnames;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_phX("+String(p)+","+String(h)+",X)...");
  end if;
  state := setState("ph",p,h,X,phase) ",fluidnames)";
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
       Modelica.Utilities.Streams.print("Running density_phX("+String(p)+","+String(h)+",X)");
     end if;
       // p="+String(p)+",h="+String(h)+", X={"+String(X[1])+","+String(X[2])+"}");
       d :=getProp_REFPROP_check("d", "ph",p,h,X,phase);
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
      Modelica.Utilities.Streams.print("Running temperature_phX("+String(p)+","+String(h)+",X)");
   end if;
       T :=getProp_REFPROP_check("T", "ph",p,h,X,phase);
     annotation(LateInline=true,inverse(h=specificEnthalpy_pTX(p,T,X,phase),
                                        p=pressure_ThX(T,h,X,phase)));
   end temperature_phX;



redeclare replaceable partial function extends setState_pTX
//      input String fluidnames;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_pTX("+String(p)+","+String(T)+",X)...");
  end if;
  state := setState("pT",p,T,X,phase) ",fluidnames)";
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
         Modelica.Utilities.Streams.print("Running density_pTX("+String(p)+","+String(T)+",X)...");
       end if;
       d :=getProp_REFPROP_check("d", "pT",p,T,X,phase);
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
        Modelica.Utilities.Streams.print("Running specificEnthalpy_pTX("+String(p)+","+String(T)+",X)...");
      end if;
      // p="+String(p)+",T="+String(T)+", X={"+String(X[1])+","+String(X[2])+"}");
      h :=getProp_REFPROP_check("h", "pT",p,T,X,phase);
    annotation(LateInline=true,inverse(T=temperature_phX(p,h,X,phase),
                                       p=pressure_ThX(T,h,X,phase)));
  end specificEnthalpy_pTX;


  redeclare function specificEntropy_pTX
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p;
    input Modelica.SIunits.Temp_K T;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.SpecificEntropy s;
  algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Running specificEntropy_pTX("+String(p)+","+String(T)+",X)");
    end if;
    s:=getProp_REFPROP_check("s", "pT",p,T,X,phase);
     annotation(LateInline=true,inverse(T=temperature_psX(p,s,X,phase),
                                       p=pressure_TsX(T,s,X,phase)));
  end specificEntropy_pTX;


redeclare replaceable partial function extends setState_psX
  "Calculates medium properties from p,s,X"
//      input String fluidnames;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_psX("+String(p)+","+String(s)+",X)...");
  end if;
  state := setState("ps",p,s,X,phase) ",fluidnames)";
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
         Modelica.Utilities.Streams.print("Running temperature_psX("+String(p)+","+String(s)+",X)...");
       end if;
       T :=getProp_REFPROP_check("T", "ps",p,s,X,phase);
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
        Modelica.Utilities.Streams.print("Running specificEnthalpy_psX("+String(p)+","+String(s)+",X)...");
      end if;
      h :=getProp_REFPROP_check("h", "ps",p,s,X,phase);
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
       Modelica.Utilities.Streams.print("Running density_psX("+String(p)+","+String(s)+",X)");
     end if;
       d :=getProp_REFPROP_check("d", "ps",p,s,X,phase);
     annotation(LateInline=true,inverse(s=specificEntropy_pdX(p,d,X,phase),
                                        p=pressure_dsX(d,s,X,phase)));
   end density_psX;










redeclare replaceable partial function extends setState_dTX
//      input String fluidnames;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running setState_dTX("+String(d)+","+String(T)+",X)...");
  end if;
  state := setState("dT",d,T,X,phase) ",fluidnames)";
end setState_dTX;



























redeclare function extends dynamicViscosity
algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Running dynamicViscosity");
    end if;
  eta := getProp_REFPROP_check("v", "Td",state.T,state.d,state.X,state.phase);
end dynamicViscosity;


redeclare function extends thermalConductivity
algorithm
    if debugmode then
      Modelica.Utilities.Streams.print("Running thermalConductivity");
    end if;
  lambda := getProp_REFPROP_check("l", "Td",state.T,state.d,state.X,state.phase);
end thermalConductivity;


  redeclare function extends specificHeatCapacityCp

  algorithm
    cp:=state.cp;
  end specificHeatCapacityCp;


  redeclare function extends specificHeatCapacityCv

  algorithm
    cv:=state.cv;
  end specificHeatCapacityCv;


  redeclare function vapourQuality "Return vapour quality"
    input REFPROPMedium.ThermodynamicState state "Thermodynamic state record";
    output MassFraction x "Vapour quality";
  algorithm
    x := state.x;
    annotation(Documentation(info="<html></html>"));
  end vapourQuality;

  annotation (Documentation(info="<html>
<p>
<b>REFPROPMediumPureSubstance</b> is a package that delivers <b>REFPROP</b> data to a model based on and compatible to the Modelica.Media library.
It can be used to calculate two-phase states of all fluids whose data is delivered with REFPROP. It has been developed and tested only in Dymola up to 2012 FD01.
</p>
<p>
All files in this library, including the C source files are released under the Modelica License 2.
</p>
<h2>Installation</h2>
The installation basically consists in copying 2 files and changing one line in this package:
<ul>
  <li>We need access to the REFPROP.DLL and to the Fluid-Data directory in the REFPROP directory. 
  So you need to set the path to the REFPROP program directory with the constant String REFPROP_PATH (at the beginning of this parent package).
  Make sure you mask the backslashes. It should look something like
   <pre>constant String REFPROP_PATH = \"C:\\\\Program Files\\\\REFPROP\\\\\";</pre></li>
  <li>We need REFPROP_WRAPPER.LIB in %DYMOLADIR%\\BIN\\LIB\ and REFPROP_WRAPPER.H in %DYMOLADIR%\\SOURCE\\ (%DYMOLADIR% is DYMOLA's program directory)</li>
</ul>
This package needs the package PartialMixtureMediumTwoPhase which should be included in the parent package.

</p>
<h2>Usage</h2>
Being based on Modelica.Media, it is used like the two-phase water model:<br/>
Create an Instance of REFPROPMediumPureSubstance and pass the components.defines the medium components (medium names are the names of the .fld files in the %REFPROP%\\fluids directory):
<pre>
  package Medium = REFPROPMediumPureSubstance (final substanceNames={\"nitrogen\"});
</pre>
Create an Instance of REFPROPMediumPureSubstance.Baseproperties:
<pre>
  Medium.BaseProperties props;
</pre>
You can then use the Baseproperties model to define the thermodynamic state and calculate the corresponding properties.
<pre>
  props.p = 1e5;
  props.T = 300;
  d = props.d;
  h = props.h;
</pre>
<p>Any combination of the pressure, temperature, specific enthalpy, specific entropy and density (p,T,h,s,d) can be used to define a 
thermodynamic state. Explicit functions for all combinations exist in REFPROP and likewise in the REFPROPMedium package.
The calculation of all variables of a thermodynamic state, however, is by default done by setState_phX, so p and h have to be 
calculated from the given combination of two variables first. Actually, by doing this, REFPROP already calculates all variables 
of the thermodynamic state, but they cannot be used directly. This is a limitation of DYMOLA, as it is not able to invert a function 
returning an array.
You can change the set of variables the property model is explicit for by setting the string variable explicitVars e.g. to \"pT\" or \"dT\":
<pre>
package Medium = REFPROPMedium(final substanceNames={\"water\"}, final explicitVars = \"pT\");
</pre>
</p>
<p>All calculated values are returned in SI-Units and are mass based.
</p>


<h2>Details</h2>
  All property functions contain a definition of their inverses. So, in many cases no numerical inversion by the solver is needed because
  explicit REFPROP functions are used (meaning, numerical inversion happens in REFPROP instead).<br>
  Example: When explicitVars are set to \"ph\" and p and T are given, the specificEnthalpy is calculated first using the inverse function of 
  Temperature_phX --> specificEnthalpy_pTX. With p and h known all other variables are calculated by setstate_phX.
<p>

<h3> Created by</h3>
Henning Francke<br/>
Helmholtz Centre Potsdam<br/>
GFZ German Research Centre for Geosciences<br/>
Telegrafenberg, D-14473 Potsdam<br/>
Germany
<p>
<a href=mailto:francke@gfz-potsdam.de>francke@gfz-potsdam.de</a>
</html>
",
 revisions="<html>

</html>"));
end REFPROPMediumPureSubstance;
