within MediaTwoPhaseMixture;
package Water_MixtureTwoPhase_pT
  "Water model from Modelica.Media compatible to PartialMixtureTwoPhaseMedium"

 extends MediaTwoPhaseMixture.PartialMixtureTwoPhaseMedium(
   final mediumName="TwoPhaseMixtureWater",
   final substanceNames={"water"},
   final reducedX = true,
   final singleState=false,
   reference_X=cat(1,fill(0,nX-1),{1}),
   fluidConstants = BrineConstants);
//   final extraPropertiesNames={"gas enthalpy","liquid enthalpy"},

  constant Modelica.SIunits.MolarMass M_H2O = 0.018015 "[kg/mol] TODO";

 redeclare model extends BaseProperties "Base properties of medium"

   Real GVF=q*d/d_g "gas void fraction";
   Modelica.SIunits.Density d_l = Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.rhol_p(p);
   Modelica.SIunits.Density d_g = Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.rhov_p(p);
   Modelica.SIunits.SpecificEnthalpy h_l = bubbleEnthalpy(sat);
   Modelica.SIunits.SpecificEnthalpy h_g = dewEnthalpy(sat);
   Real q = min(max((h - h_l)/(h_g - h_l+ 1e-18), 0), 1)
      "(min=0,max=1) gas phase mass fraction";
 //  Integer phase_out "calculated phase";
   //END no gas case
 equation
   u = h - p/d;
   MM = M_H2O;
   R  = Modelica.Constants.R/MM;

 //End GVF

 //DENSITY
 //  q = vapourQuality(state);
     d = Modelica.Media.Water.WaterIF97_base.density_ph(p,h);
 //  d = d_l/(1-q*(1-d_l/d_g));
 //End DENSITY

 //ENTHALPY
   h = specificEnthalpy_pTX(p,T,X);
 /*
      if (p_H2O>p) then
    h_H2O_g = Modelica.Media.Water.WaterIF97_base.specificEnthalpy_pT(p,T,1);
  else
    h_H2O_g = Modelica.Media.Water.WaterIF97_base.dewEnthalpy(Modelica.Media.Water.WaterIF97_base.setSat_p(p));
  end if;
  h_gas_dissolved = 0;
  Delta_h_solution = solutionEnthalpy(T) 
      "TODO: gilt nur bei gesättigter Lösung";
*/
 //assert(abs(((1-q)*h_l + q*h_g-h)/h) < 1e-3,"Enthalpie stimmt nicht! h_calc="+String((1-q)*h_l + q*h_g)+"<>h="+String(h));
 //End ENTHALPY

   s=0 "TODO";

   state = ThermodynamicState(
     p=p,
     T=T,
     X=X,
     h=h,
     GVF=GVF,
     q=q,
     s=0,
     d_g=d_g,
     d_l=d_l,
     d=d,
     phase=0) "phase_out";

   sat.psat = p "TODO";
   sat.Tsat = T "saturationTemperature(p) TODO";
   sat.X = X;

   annotation (Documentation(info="<html></html>"),
               Documentation(revisions="<html>

</html>"));
 end BaseProperties;

  redeclare function specificEnthalpy_pTX
    input Modelica.SIunits.Pressure p;
    input Modelica.SIunits.Temp_K T;
    input MassFraction X[:] "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  /*  input MassFraction q "(min=0,max=1)";
  input Real y "molar fraction of gas in gas phase";*/
  //  input Real[3] TP;
    output Modelica.SIunits.SpecificEnthalpy h=Modelica.Media.Water.WaterIF97_base.specificEnthalpy_pT(p,T);
  algorithm
  //  Modelica.Utilities.Streams.print("specificEnthalpy_pTXqy("+String(p)+","+String(T)+",X,"+String(q)+","+String(y)+")");
    annotation(LateInline=true,inverse(T = temperature_phX(p=p,h=h,X=X,phase=phase)));
  end specificEnthalpy_pTX;

  redeclare function temperature_phX
    "numerically inverts specificEnthalpy_liquid_pTX"
    input Modelica.SIunits.Pressure p;
    input Modelica.SIunits.SpecificEnthalpy h;
    input MassFraction X[:] "mass fraction m_XCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Modelica.SIunits.Temp_K T=Modelica.Media.Water.WaterIF97_base.temperature_ph(p,h);
  algorithm
  //  Modelica.Utilities.Streams.print("temperature_phX");

     annotation(LateInline=true,inverse(h = specificEnthalpy_pTX(p=p,T=T,phase=phase,X=X)));
  end temperature_phX;

redeclare record extends ThermodynamicState
    "a selection of variables that uniquely defines the thermodynamic state"
/*  AbsolutePressure p "Absolute pressure of medium";
  Temperature T(unit="K") "Temperature of medium";
  MassFraction X[nX] "Mass fraction of NaCl in kg/kg";*/
  SpecificEnthalpy h "Specific enthalpy";
  SpecificEntropy s "Specific entropy";
  Density d(start=300) "density";
  Real GVF "Gas Void Fraction";
  Density d_l(start=300) "density liquid phase";
  Density d_g(start=300) "density gas phase";
  Real q "vapor quality on a mass basis [mass vapor/total mass]";

   annotation (Documentation(info="<html>

</html>"));
end ThermodynamicState;

  redeclare function extends dewEnthalpy "dew curve specific enthalpy of water"
  algorithm
    hv :=  Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hv_p(sat.psat);
  end dewEnthalpy;

  redeclare function extends bubbleEnthalpy
    "boiling curve specific enthalpy of water"
  algorithm
    hl := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hl_p(sat.psat);
  end bubbleEnthalpy;

  redeclare function extends saturationTemperature
  algorithm
     //T := Modelica.Media.Water.IF97_Utilities.BaseIF97.Basic.tsat(p);
     T := Modelica.Media.Water.WaterIF97_base.saturationTemperature(p);
  end saturationTemperature;

  redeclare function extends dynamicViscosity
  algorithm
    eta := Modelica.Media.Water.WaterIF97_base.dynamicViscosity(state);
  end dynamicViscosity;

redeclare function extends specificEntropy "specific entropy of water"
algorithm
    s := Modelica.Media.Water.IF97_Utilities.s_ph(state.p, state.h, state.phase);
end specificEntropy;

redeclare function specificEnthalpy_ps
    "Computes specific enthalpy as a function of pressure and temperature"
    extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SpecificEnthalpy h "specific enthalpy";
algorithm
  h := Modelica.Media.Water.IF97_Utilities.h_ps(p, s, phase);
end specificEnthalpy_ps;

redeclare function extends setState_psX
    "Return thermodynamic state of water as function of p and s"
algorithm
  state := ThermodynamicState(
    d=density_ps(p,s),
    T=temperature_ps(p,s),
    phase=0,
    h=specificEnthalpy_ps(p,s),
    p=p,
    X=X,
    s=s,
    q=-1,
    GVF=-1,
    d_l=-1,
    d_g=-1);
end setState_psX;

  redeclare function extends temperature "return temperature of ideal gas"
  algorithm
    T := state.T;
  end temperature;

      redeclare function extends density "return density of ideal gas"
      algorithm
    d := state.d;
      end density;

 annotation (Documentation(info="<html>
  <h1>Water_MixtureTwoPhase_pT</h1>
  This is a an example use of PartialMixtureTwoPhaseMedium.
  It is a (incomplete) water model using the template PartialMixtureTwoPhaseMedium. It uses the property functions from Modelica.Media.Water.<br/>
  
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
end Water_MixtureTwoPhase_pT;
