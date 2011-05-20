within MediaTwoPhaseMixture;
partial package PartialMixtureTwoPhaseMedium "Base class for two phase medium of a mixture of substances "


  extends Modelica.Media.Interfaces.PartialMixtureMedium;
//  constant Boolean smoothModel "true if the (derived) model should not generate state events";
  constant Boolean onePhase = false
  "true if the (derived) model should never be called with two-phase inputs";


  redeclare replaceable record extends FluidConstants
  "extended fluid constants"
  /*    Temperature criticalTemperature "critical temperature";
    AbsolutePressure criticalPressure "critical pressure";
    MolarVolume criticalMolarVolume "critical molar Volume";
    Real acentricFactor "Pitzer acentric factor";
    Temperature triplePointTemperature "triple point temperature";
    AbsolutePressure triplePointPressure "triple point pressure";
    Temperature meltingPoint "melting point at 101325 Pa";
    Temperature normalBoilingPoint "normal boiling point (at 101325 Pa)";
    DipoleMoment dipoleMoment 
      "dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
    Boolean hasIdealGasHeatCapacity=false 
      "true if ideal gas heat capacity is available";
    Boolean hasCriticalData=false "true if critical data are known";
    Boolean hasDipoleMoment=false "true if a dipole moment known";
    Boolean hasFundamentalEquation=false "true if a fundamental equation";
    Boolean hasLiquidHeatCapacity=false 
      "true if liquid heat capacity is available";
    Boolean hasSolidHeatCapacity=false 
      "true if solid heat capacity is available";
    Boolean hasAccurateViscosityData=false 
      "true if accurate data for a viscosity function is available";
    Boolean hasAccurateConductivityData=false 
      "true if accurate data for thermal conductivity is available";
    Boolean hasVapourPressureCurve=false 
      "true if vapour pressure data, e.g. Antoine coefficents are known";
    Boolean hasAcentricFactor=false "true if Pitzer accentric factor is known";
    SpecificEnthalpy HCRIT0=0.0 
      "Critical specific enthalpy of the fundamental equation";
    SpecificEntropy SCRIT0=0.0 
      "Critical specific entropy of the fundamental equation";
    SpecificEnthalpy deltah=0.0 
      "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
    SpecificEntropy deltas=0.0 
      "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
      */
    annotation(Documentation(info="<html></html>"));
  end FluidConstants;

constant FluidConstants[nS] fluidConstants "constant data for the fluid";


redeclare replaceable record extends ThermodynamicState
  "Thermodynamic state of two phase medium"
    FixedPhase phase(min=0, max=2)
    "phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g. interactive use";
    Density d_l(start=300) "density liquid phase";
    Density d_g(start=300) "density gas phase";
    annotation(Documentation(info="<html></html>"));
//MassFraction X[nX] "Mass fraction of NaCl in kg/kg"
end ThermodynamicState;


  replaceable record SaturationProperties
  "Saturation properties of two phase medium"
    extends Modelica.Icons.Record;
    AbsolutePressure psat "saturation pressure";
    Temperature Tsat "saturation temperature";
    MassFraction X[nX] "Mass fractions";
    annotation(Documentation(info="<html></html>"));
  end SaturationProperties;


  redeclare replaceable partial model extends BaseProperties
  "Base properties (p, d, T, h, s, u, R, MM, sat) of two phase medium"
  //  Temperature T(start=300);
    Modelica.SIunits.SpecificEntropy s;
    SaturationProperties sat "Saturation properties at the medium pressure";
    annotation(Documentation(info="<html></html>"));
  end BaseProperties;


  replaceable partial function setDewState
  "Return the thermodynamic state on the dew line"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "saturation point";
    input FixedPhase phase(min = 1, max = 2) =  1 "phase: default is one phase";
    output ThermodynamicState state "complete thermodynamic state info";
    annotation(Documentation(info="<html></html>"));
  end setDewState;


  replaceable partial function setBubbleState
  "Return the thermodynamic state on the bubble line"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "saturation point";
    input FixedPhase phase(min = 1, max = 2) =  1 "phase: default is one phase";
    output ThermodynamicState state "complete thermodynamic state info";
    annotation(Documentation(info="<html></html>"));
  end setBubbleState;


  redeclare replaceable partial function extends setState_dTX
  "Return thermodynamic state as function of d, T and composition X or Xi"
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    annotation(Documentation(info="<html></html>"));
  end setState_dTX;


  redeclare replaceable partial function extends setState_phX
  "Return thermodynamic state as function of p, h and composition X or Xi"
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    annotation(Documentation(info="<html></html>"));
  end setState_phX;


  redeclare replaceable partial function extends setState_psX
  "Return thermodynamic state as function of p, s and composition X or Xi"
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    annotation(Documentation(info="<html></html>"));
  end setState_psX;


  redeclare replaceable partial function extends setState_pTX
  "Return thermodynamic state as function of p, T and composition X or Xi"
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    annotation(Documentation(info="<html></html>"));
  end setState_pTX;


  replaceable function setSat_TX
  "Return saturation property record from temperature"
    extends Modelica.Icons.Function;
    input Temperature T "temperature";
    input MassFraction X[nX] "Mass fractions";
    output SaturationProperties sat "saturation property record";
  algorithm
    sat.Tsat := T;
    sat.psat := saturationPressure(T,X);
    annotation(Documentation(info="<html></html>"));
  end setSat_TX;


  replaceable function setSat_pX
  "Return saturation property record from pressure"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "pressure";
    input MassFraction X[nX] "Mass fractions";
    output SaturationProperties sat "saturation property record";
  algorithm
    sat.psat := p;
    sat.Tsat := saturationTemperature(p,X);
    annotation(Documentation(info="<html></html>"));
  end setSat_pX;


  replaceable partial function bubbleEnthalpy
  "Return bubble point specific enthalpy"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output Modelica.SIunits.SpecificEnthalpy hl
    "boiling curve specific enthalpy";
    annotation(Documentation(info="<html></html>"));
  end bubbleEnthalpy;


    replaceable partial function dewEnthalpy
  "Return dew point specific enthalpy"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output Modelica.SIunits.SpecificEnthalpy hv "dew curve specific enthalpy";
    annotation(Documentation(info="<html></html>"));
    end dewEnthalpy;


    replaceable partial function bubbleEntropy
  "Return bubble point specific entropy"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "saturation property record";
    output Modelica.SIunits.SpecificEntropy sl "boiling curve specific entropy";
    annotation(Documentation(info="<html></html>"));
    end bubbleEntropy;


    replaceable partial function dewEntropy "Return dew point specific entropy"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "saturation property record";
    output Modelica.SIunits.SpecificEntropy sv "dew curve specific entropy";
    annotation(Documentation(info="<html></html>"));
    end dewEntropy;


    replaceable partial function bubbleDensity "Return bubble point density"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output Density dl "boiling curve density";
    annotation(Documentation(info="<html></html>"));
    end bubbleDensity;


    replaceable partial function dewDensity "Return dew point density"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output Density dv "dew curve density";
    annotation(Documentation(info="<html></html>"));
    end dewDensity;


    replaceable partial function saturationPressure
  "Return saturation pressure"
      extends Modelica.Icons.Function;
      input Temperature T "temperature";
      input MassFraction X[:] "fluid composition as mass fractions";
      output AbsolutePressure p "saturation pressure";

    annotation(Documentation(info="<html></html>"));
    end saturationPressure;


    replaceable partial function saturationTemperature
  "Return saturation temperature"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "pressure";
      input MassFraction X[:] "fluid composition as mass fractions";
      output Temperature T "saturation temperature";

    annotation(Documentation(info="<html></html>"));
    end saturationTemperature;


    replaceable function saturationPressure_sat "Return saturation temperature"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output AbsolutePressure p "saturation pressure";
    algorithm
      p := sat.psat;
    annotation(Documentation(info="<html></html>"));
    end saturationPressure_sat;


    replaceable function saturationTemperature_sat
  "Return saturation temperature"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output Temperature T "saturation temperature";
    algorithm
      T := sat.Tsat;
    annotation(Documentation(info="<html></html>"));
    end saturationTemperature_sat;


    replaceable partial function saturationTemperature_derp
  "Return derivative of saturation temperature w.r.t. pressure"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "pressure";
      output Real dTp "derivative of saturation temperature w.r.t. pressure";
    annotation(Documentation(info="<html></html>"));
    end saturationTemperature_derp;


    replaceable function saturationTemperature_derp_sat
  "Return derivative of saturation temperature w.r.t. pressure"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output Real dTp "derivative of saturation temperature w.r.t. pressure";
    algorithm
      dTp := saturationTemperature_derp(sat.psat);
    annotation(Documentation(info="<html></html>"));
    end saturationTemperature_derp_sat;


  replaceable partial function surfaceTension
  "Return surface tension sigma in the two phase region"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "saturation property record";
    output SurfaceTension sigma "Surface tension sigma in the two phase region";
    annotation(Documentation(info="<html></html>"));
  end surfaceTension;

  /*  redeclare replaceable partial function extends molarMass 
    "Return the molar mass of the medium"
    algorithm 
      MM := fluidConstants[1].molarMass;
    end molarMass;*/


    replaceable partial function dBubbleDensity_dPressure
  "Return bubble point density derivative"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output DerDensityByPressure ddldp "boiling curve density derivative";
    annotation(Documentation(info="<html></html>"));
    end dBubbleDensity_dPressure;


    replaceable partial function dDewDensity_dPressure
  "Return dew point density derivative"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output DerDensityByPressure ddvdp "saturated steam density derivative";
    annotation(Documentation(info="<html></html>"));
    end dDewDensity_dPressure;


    replaceable partial function dBubbleEnthalpy_dPressure
  "Return bubble point specific enthalpy derivative"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output DerEnthalpyByPressure dhldp
    "boiling curve specific enthalpy derivative";
    annotation(Documentation(info="<html></html>"));
    end dBubbleEnthalpy_dPressure;


    replaceable partial function dDewEnthalpy_dPressure
  "Return dew point specific enthalpy derivative"
      extends Modelica.Icons.Function;

      input SaturationProperties sat "saturation property record";
      output DerEnthalpyByPressure dhvdp
    "saturated steam specific enthalpy derivative";
    annotation(Documentation(info="<html></html>"));
    end dDewEnthalpy_dPressure;


    redeclare replaceable function specificEnthalpy_pTX
  "Return specific enthalpy from pressure, temperature and mass fraction"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[nX] "Mass fractions";
      input FixedPhase phase=0
    "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "Specific enthalpy at p, T, X";
    algorithm
      h := specificEnthalpy(setState_pTX(p,T,X,phase));
    annotation(Documentation(info="<html></html>"));
    end specificEnthalpy_pTX;


    redeclare replaceable function temperature_phX
  "Return temperature from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[nX] "Mass fractions";
      input FixedPhase phase=0
    "2 for two-phase, 1 for one-phase, 0 if not known";
      output Temperature T "Temperature";
    algorithm
      T := temperature(setState_phX(p,h,X,phase));
    annotation(Documentation(info="<html></html>"));
    end temperature_phX;


    redeclare replaceable function density_phX
  "Return density from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[nX] "Mass fractions";
      input FixedPhase phase=0
    "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "density";
    algorithm
      d := density(setState_phX(p,h,X,phase));
    annotation(Documentation(info="<html></html>"));
    end density_phX;


    redeclare replaceable function temperature_psX
  "Return temperature from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[nX] "Mass fractions";
      input FixedPhase phase=0
    "2 for two-phase, 1 for one-phase, 0 if not known";
      output Temperature T "Temperature";
    algorithm
      T := temperature(setState_psX(p,s,X,phase));
    annotation(Documentation(info="<html></html>"));
    end temperature_psX;


    redeclare replaceable function density_psX
  "Return density from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[nX] "Mass fractions";
      input FixedPhase phase=0
    "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm
      d := density(setState_psX(p,s,X,phase));
    annotation(Documentation(info="<html></html>"));
    end density_psX;


    redeclare replaceable function specificEnthalpy_psX
  "Return specific enthalpy from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[nX] "Mass fractions";
      input FixedPhase phase=0
    "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := specificEnthalpy(setState_psX(p,s,X,phase));
    annotation(Documentation(info="<html></html>"));
    end specificEnthalpy_psX;


  replaceable function setState_pT "Return thermodynamic state from p and T"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output ThermodynamicState state "thermodynamic state record";
  algorithm
    state := setState_pTX(p,T,fill(0,0),phase);
    annotation(Documentation(info="<html></html>"));
  end setState_pT;


  replaceable function setState_ph "Return thermodynamic state from p and h"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output ThermodynamicState state "thermodynamic state record";
  algorithm
    state := setState_phX(p,h,fill(0, 0),phase);
    annotation(Documentation(info="<html></html>"));
  end setState_ph;


  replaceable function setState_ps "Return thermodynamic state from p and s"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output ThermodynamicState state "thermodynamic state record";
  algorithm
    state := setState_psX(p,s,fill(0,0),phase);
    annotation(Documentation(info="<html></html>"));
  end setState_ps;


  replaceable function setState_dT "Return thermodynamic state from d and T"
    extends Modelica.Icons.Function;
    input Density d "density";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output ThermodynamicState state "thermodynamic state record";
  algorithm
    state := setState_dTX(d,T,fill(0,0),phase);
    annotation(Documentation(info="<html></html>"));
  end setState_dT;


  replaceable function setState_px
  "Return thermodynamic state from pressure and vapour quality"
    input AbsolutePressure p "Pressure";
    input MassFraction x "Vapour quality";
    output ThermodynamicState state "Thermodynamic state record";
  algorithm
  state := setState_ph(
      p,
      (1 - x)*bubbleEnthalpy(
      MediaTwoPhaseMixture.PartialMixtureTwoPhaseMedium.setSat_pX(p)) + x*
      dewEnthalpy(MediaTwoPhaseMixture.PartialMixtureTwoPhaseMedium.setSat_pX(p)),
      2);
    annotation(Documentation(info="<html></html>"));
  end setState_px;


  replaceable function setState_Tx
  "Return thermodynamic state from temperature and vapour quality"
    input Temperature T "Temperature";
    input MassFraction x "Vapour quality";
    output ThermodynamicState state "thermodynamic state record";
  algorithm
  state := setState_ph(
      saturationPressure_sat(
      MediaTwoPhaseMixture.PartialMixtureTwoPhaseMedium.setSat_TX(T)),
      (1 - x)*bubbleEnthalpy(
      MediaTwoPhaseMixture.PartialMixtureTwoPhaseMedium.setSat_TX(T)) + x*
      dewEnthalpy(MediaTwoPhaseMixture.PartialMixtureTwoPhaseMedium.setSat_TX(T)),
      2);
    annotation(Documentation(info="<html></html>"));
  end setState_Tx;


  replaceable function vapourQuality "Return vapour quality"
    input ThermodynamicState state "Thermodynamic state record";
    output MassFraction q "Vapour quality";
protected
    constant SpecificEnthalpy eps = 1e-8;
  algorithm
  q := min(max((specificEnthalpy(state) - bubbleEnthalpy(
    setSat_pX(pressure(state),state.X)))
    /(dewEnthalpy(setSat_pX(pressure(state),state.X)) - bubbleEnthalpy(setSat_pX(pressure(state),state.X))
     + eps), 0), 1);
    annotation(Documentation(info="<html></html>"));
  end vapourQuality;


  replaceable function density_ph "Return density from p and h"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Density";
  algorithm
    d := density_phX(p, h, fill(0,0), phase);
    annotation(Documentation(info="<html></html>"));
  end density_ph;


  replaceable function temperature_ph "Return temperature from p and h"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Temperature T "Temperature";
  algorithm
    T := temperature_phX(p, h, fill(0,0),phase);
    annotation(Documentation(info="<html></html>"));
  end temperature_ph;


  replaceable function pressure_dT "Return pressure from d and T"
    extends Modelica.Icons.Function;
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output AbsolutePressure p "Pressure";
  algorithm
    p := pressure(setState_dTX(d, T, fill(0,0),phase));
    annotation(Documentation(info="<html></html>"));
  end pressure_dT;


  replaceable function specificEnthalpy_dT
  "Return specific enthalpy from d and T"
    extends Modelica.Icons.Function;
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := specificEnthalpy(setState_dTX(d, T, fill(0,0),phase));
    annotation(Documentation(info="<html></html>"));
  end specificEnthalpy_dT;


  replaceable function specificEnthalpy_ps
  "Return specific enthalpy from p and s"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := specificEnthalpy_psX(p,s,fill(0,0));
    annotation(Documentation(info="<html></html>"));
  end specificEnthalpy_ps;


  replaceable function temperature_ps "Return temperature from p and s"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Temperature T "Temperature";
  algorithm
    T := temperature_psX(p,s,fill(0,0),phase);
    annotation(Documentation(info="<html></html>"));
  end temperature_ps;


  replaceable function density_ps "Return density from p and s"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Density";
  algorithm
    d := density_psX(p, s, fill(0,0), phase);
    annotation(Documentation(info="<html></html>"));
  end density_ps;


  replaceable function specificEnthalpy_pT
  "Return specific enthalpy from p and T"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := specificEnthalpy_pTX(p, T, fill(0,0),phase);
    annotation(Documentation(info="<html></html>"));
  end specificEnthalpy_pT;


  replaceable function density_pT "Return density from p and T"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Density";
  algorithm
    d := density(setState_pTX(p, T, fill(0,0),phase));
    annotation(Documentation(info="<html></html>"));
  end density_pT;


replaceable function specificEnthalpy_dTX
  "Return specific enthalpy from d, T, and X or Xi"
  extends Modelica.Icons.Function;
  input Density d "Pressure";
  input Temperature T "Specific entropy";
  input MassFraction X[nX] "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SpecificEnthalpy h "specific enthalpy";
algorithm
  h := specificEnthalpy(setState_dTX(d,T,X,phase));

annotation(Documentation(info="<html></html>"));
end specificEnthalpy_dTX;


redeclare replaceable function pressure
  input ThermodynamicState state "Thermodynamic state record";
  output Modelica.SIunits.Pressure p;
algorithm
  p:=state.p;
end pressure;


redeclare replaceable function specificEnthalpy
  input ThermodynamicState state "Thermodynamic state record";
  output Modelica.SIunits.SpecificEnthalpy h;
algorithm
  h:=state.h;
end specificEnthalpy;


replaceable function densityLiquidPhase
  input ThermodynamicState state "Thermodynamic state record";
  output Modelica.SIunits.Density d_l;
algorithm
  d_l:=state.d_l;
end densityLiquidPhase;


  annotation (Documentation(info="<html>
  <h1>PartialMixtureTwoPhaseMedium</h1>
  This is a template for two phase medium of a mixture of substances and is used by REFPROPMedium.<br/>
  It has been created by merging PartialMixtureMedium and PartialTwoPhaseMedium from Modelica.Media.Interfaces.<br/>  

<h3> Created by</h3>
Henning Francke<br/>
Helmholtz Centre Potsdam<br/>
GFZ German Research Centre for Geosciences<br/>
Telegrafenberg, D-14473 Potsdam<br/>
Germany
<p>
<a href=mailto:info@xrg-simulation.de>francke@gfz-potsdam.de</a>
  </html>
"), uses(Modelica(version="3.1")));
end PartialMixtureTwoPhaseMedium;
