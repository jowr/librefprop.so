within MediaTwoPhaseMixture.Examples;
model PropsMixture
//package Medium = REFPROPMedium(final substanceNames={"isobutan"});
//package Medium = REFPROPMedium(final substanceNames={"R12"});
package Medium = REFPROPMedium(final substanceNames={"isobutan","propane"});
// ",final explicitVars = "pd"";
//package Medium = MediaTwoPhaseMixture.REFPROPMedium(final substanceNames={"CO2","water"});

  Medium.BaseProperties props;

  Modelica.SIunits.Pressure psat=Medium.saturationPressure(300);

/*  Modelica.SIunits.SpecificEnthalpy h=Medium.specificEnthalpy_pTX(1e5,293,{.5,.5});
  Modelica.SIunits.Density d;
  Modelica.SIunits.SpecificEntropy s;
  Modelica.SIunits.Temperature Tsat;
  Modelica.SIunits.Pressure psat;
  */
Modelica.SIunits.Pressure p=Medium.pressure(props.state);
//  Modelica.SIunits.MolarMass MM;
/*Modelica.SIunits.DynamicViscosity eta = Medium.dynamicViscosity(props.state);

Modelica.SIunits.DynamicViscosity eta_l = Medium.dynamicViscosity_liq(props.state);
Modelica.SIunits.DynamicViscosity eta_g = Medium.dynamicViscosity_gas(props.state);
*/
  Real q = Medium.vapourQuality(props.state);
equation

    props.p = 1e5;
//    props.h = 1.848e5;
  //  props.s = 5.88105;
   props.T = 400;
//    props.Xi = {.5};
//    props.X = {.1,.9};
    props.Xi = {.5};

  //  d = props.d;
  //h = props.h;
  //h = Medium.dewEnthalpy(props.sat);

  //d = Medium.density(props.state);
  //s = specificEntropy(props.state);
  //s = props.state.s;
//  MM = Medium.molarMass(props.state);

/*  
  Tsat = Medium.saturationTemperature(props.p,props.X);
//  Tsat = Medium.temperature_pqX(props.p,0.5,props.X);
  psat = Medium.saturationPressure(props.T,props.X);
//  psat = Medium.pressure_TqX(props.T,0.5,props.X);
//  h = Medium.dewEnthalpy(props.sat);
//  s = Medium.dewEntropy(props.sat);
  s = Medium.bubbleEntropy(props.sat);
//  d = Medium.dewDensity(props.sat);
  d = Medium.bubbleDensity(props.sat);
*/

end PropsMixture;
