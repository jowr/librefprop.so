within MediaTwoPhaseMixture.Examples;
model PropsPureSubstance
//package Medium = Modelica.Media.Water.WaterIF97_ph;
//package Medium = REFPROPMedium(final substanceNames={"water"},  final explicitVars = "pT");
//package Medium = REFPROPMedium(final substanceNames={"ammonia"});
//package Medium = REFPROPMedium(final substanceNames={"co2"});
package Medium = MediaTwoPhaseMixture.REFPROPMediumPureSubstance (
                                             final substanceNames={"butane"});

//package Medium = REFPROPMediumPureSubstance(final substanceNames={"water"});
//package Medium = REFPROPMediumPureSubstance(final substanceNames={"ammonia"},  final explicitVars = "ph");

  Medium.BaseProperties props;
//  Modelica.SIunits.Density d=Medium.density_phX(props.p,props.h);
//  d = Medium.bubbleDensity(props.sat);
//  d = Medium.density_pTX(1e5,300);
//  Modelica.SIunits.SpecificEnthalpy h;
//  Modelica.SIunits.SpecificEntropy s;
//  Modelica.SIunits.Temperature T=props.T;
  Modelica.SIunits.Pressure psat=Medium.saturationPressure(300);
//  Modelica.SIunits.MolarMass MM;
//  Real q= Medium.vapourQuality(props.state);
//  Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp;
//  Modelica.SIunits.ThermalConductivity lambda= Medium.thermalConductivity(props.state);
//  Modelica.SIunits.DynamicViscosity eta = Medium.dynamicViscosity(props.state);
  Modelica.Blocks.Sources.Sine sine_p(
    amplitude=2.5e6,
    freqHz=1,
    offset=2.5001e6,
    startTime=3)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.ExpSine expSine_h(
    amplitude=350e3,
    freqHz=2,
    damping=0.1,
    offset=450e3,
    phase=1.5707963267949)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
equation
    props.p = 1e5+time*1e5 "sine_p.y";
    props.h = 722774;

//  props.s = 5.88105;
//   props.T = 350;
//   props.Xi = fill(0,0);

  //d = props.d;
  //h = props.h;
  //h = Medium.dewEnthalpy(props.sat);

  //d = Medium.density(props.state);
  //s = specificEntropy(props.state);
  //s = props.state.s;
//  MM = Medium.molarMass(props.state);
//  Tsat = Medium.saturationTemperature(props.p,props.X);
//  Tsat = Medium.temperature_pqX(props.p,0.5,props.X);
//  psat = Medium.saturationPressure(props.T,props.X);
//  psat = Medium.pressure_TqX(props.T,0.5,props.X);
//  h = Medium.dewEnthalpy(props.sat);
//  s = Medium.dewEntropy(props.sat);
//  s = Medium.bubbleEntropy(props.sat);
//  d = Medium.dewDensity(props.sat);

  annotation (experiment(StopTime=10, NumberOfIntervals=1000),
      __Dymola_experimentSetupOutput);
end PropsPureSubstance;
